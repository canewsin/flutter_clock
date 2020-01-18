// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum _Element {
  background,
  text,
  shadow,
}

final _lightTheme = {
  _Element.background: Color(0xFF81B3FE),
  _Element.text: Colors.white,
  _Element.shadow: Colors.black,
};

final _darkTheme = {
  _Element.background: Colors.black,
  _Element.text: Colors.white,
  _Element.shadow: Color(0xFF174EA6),
};

/// A basic digital clock.
///
/// You can do better than this!
class DigitalClock extends StatefulWidget {
  const DigitalClock(this.model);

  final ClockModel model;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(DigitalClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      // Update once per minute. If you want to update every second, use the
      // following code.
      // _timer = Timer(
      //   Duration(minutes: 1) -
      //       Duration(seconds: _dateTime.second) -
      //       Duration(milliseconds: _dateTime.millisecond),
      //   _updateTime,
      // );
      // Update once per second, but make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  List numbers = []
    ..addAll(ones)
    ..addAll(
      [
        'Ten',
        'Eleven',
        'Twelve',
      ],
    );

  static List ones = const [
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
    'Seven',
    'Eight',
    'Nine',
  ];

  List teens = const [
    'Eleven',
    'Twelve',
    'Thirteen',
    'Fourteen',
    'Fifteen',
    'Sixteen',
    'Seventeen',
    'Eighteen',
    'Nineteen',
  ];

  List tens = const [
    'Ten',
    'Twenty',
    'Thirty',
    'Forty',
    'Fifty',
    'Sixty',
  ];

  List weekdays = const [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  List months = const [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).brightness == Brightness.light
        ? _lightTheme
        : _darkTheme;
    final hour =
        DateFormat(widget.model.is24HourFormat ? 'HH' : 'hh').format(_dateTime);
    final minute = DateFormat('mm').format(_dateTime);
    var second = _dateTime.second.toRadixString(2);
    if (second.length < 6) second = '0' * (6 - second.length) + second;
    List<Widget> bins = [];
    for (var i = 0; i < second.length; i++) {
      double size = 10.0;
      bool checked = second[i] == '1';
      bins.add(
        Container(
          height: size,
          width: size,
          margin: EdgeInsets.all(size / 4),
          decoration: BoxDecoration(
            color: checked ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(size / 2),
            border: Border.all(
              width: 1.0,
              color: Color(0xFF286788),
            ),
          ),
        ),
      );
    }
    final weekday = weekdays[_dateTime.weekday];
    final day = _dateTime.day;
    final month = months[_dateTime.month - 1];
    final fontSize = MediaQuery.of(context).size.width / 3.0;
    final defaultStyle = TextStyle(
      color: colors[_Element.text],
      fontFamily: 'Roboto-Medium',
      fontSize: fontSize,
      shadows: [
        Shadow(
          blurRadius: 0,
          color: colors[_Element.shadow],
          offset: Offset(0, 0),
        ),
      ],
    );

    final timeText = getTimeText('$hour:$minute');

    List<String> timeUnits = [
      hour.substring(0, 1),
      hour.substring(1),
      minute.substring(0, 1),
      minute.substring(1),
    ];

    List<Widget> paintedTexts = [];

    for (var i = 0; i < timeUnits.length; i++) {
      paintedTexts.add(
        Padding(
          padding: EdgeInsets.only(
            left: fontSize / 15,
            right: fontSize / 2.4,
            top: fontSize / 3.5,
          ),
          child: CustomPaint(
            painter: TextPainterC(
              timeUnits[i],
              defaultStyle,
            ),
          ),
        ),
      );
    }
    paintedTexts.insert(
      2,
      Padding(
        padding: EdgeInsets.only(
          left: fontSize / 9,
          right: fontSize / 3,
          top: fontSize / 3.5,
        ),
      ),
    );

    return Container(
      // color: colors[_Element.background],
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          stops: [
            0.0,
            0.5,
            1.0,
          ],
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFF59B9EB),
            Color(0xFF286788),
          ],
          radius: 1.2,
          center: Alignment.topLeft,
        ),
      ),
      child: Center(
        child: DefaultTextStyle(
          style: defaultStyle,
          child: Stack(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: paintedTexts,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          widget.model.temperatureString,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Color(0xFF286788),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          '$weekday, $day $month',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    // padding: const EdgeInsets.all(35.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: bins,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    padding: EdgeInsets.only(
                      top: 8.0,
                      bottom: 8.0,
                      left: 16.0,
                      right: 16.0,
                    ),
                    margin: EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      timeText,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFF286788),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String timeString(int hours, int min) {
    if (min >= 0 && min < 5) {
      return '${numbers[hours - 1]}\'O Clock';
    } else if (min >= 5 && min < 10) {
      return 'Five Past ${numbers[hours - 1]}';
    } else if (min >= 10 && min < 15) {
      return 'Ten Past ${numbers[hours - 1]}';
    } else if (min >= 15 && min < 20) {
      return 'Quarter Past ${numbers[hours - 1]}';
    } else if (min >= 20 && min < 25) {
      return 'Twenty Past ${numbers[hours - 1]}';
    } else if (min >= 25 && min < 30) {
      return 'Twenty Five Past ${numbers[hours - 1]}';
    } else if (min >= 30 && min < 35) {
      return 'Half Past ${numbers[hours - 1]}';
    } else if (min >= 35 && min < 40) {
      return 'Twenty Five To ${numbers[hours]}';
    } else if (min >= 40 && min < 45) {
      return 'Tewnty To ${numbers[hours]}';
    } else if (min >= 45 && min < 50) {
      return 'Quarter To ${numbers[hours]}';
    } else if (min >= 50 && min < 55) {
      return 'Ten To ${numbers[hours]}';
    } else if (min >= 55) {
      return 'Five To ${numbers[hours]}';
    }
    return '';
  }

  String getTimeText(String time) {
    int hours = int.parse(time.substring(0, time.indexOf(':')));
    int minutes = int.parse(time.substring(time.indexOf(':') + 1, time.length));
    String wish = "It's ${timeString(hours, minutes)}";
    String w =
        "Its Twelve \'O Clock Already, Have a Sweet Dream with your pillow";

    // print(hour);
    // print(minute);
    return wish;
  }
}

class TextPainterC extends CustomPainter {
  String text;
  TextStyle style;
  TextPainterC(this.text, this.style);
  @override
  void paint(Canvas canvas, Size size) {
    final ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(
        ui.ParagraphStyle(
      fontSize: style
          .fontSize, // There unfortunelly are some things to be copied from your common TextStyle to ParagraphStyle :C
      fontFamily: style
          .fontFamily, // IDK why it is like this, this is somewhat weird especially when there is `pushStyle` which can use the TextStyle...
      fontStyle: style.fontStyle,
      fontWeight: style.fontWeight,
      textAlign: TextAlign.justify,
      //maxLines: 25,
    ))
      ..pushStyle(style
          .getTextStyle()) // To use multiple styles, you must make use of the builder and `pushStyle` and then `addText` (or optionally `pop`).
      ..addText(text);

    final ui.Paragraph paragraph = paragraphBuilder.build()
      ..layout(
        ui.ParagraphConstraints(
          width: size.width - 12.0 - 12.0,
        ),
      ); // Paragraph need to have specified width :/
    canvas.drawParagraph(paragraph, const Offset(0.0, 0.0));

    for (var i = 0; i < 4; i++) {
      Paint paint = Paint()
        ..style = (props(style.fontSize)[text]['binary'][i] == 0)
            ? PaintingStyle.stroke
            : PaintingStyle.fill
        ..strokeWidth = 1.0
        ..color = Color(0xFF286788);
      canvas.drawCircle(
        props(style.fontSize)[text]['offset'][i],
        style.fontSize / 50,
        paint,
      );
    }
  }

  Map props(double fontSize) => {
        '0': {
          'offset': {
            0: Offset((fontSize / 4) + (fontSize / 35), fontSize / 4),
            1: Offset((fontSize / 2.275) + (fontSize / 40), fontSize / 1.8),
            2: Offset((fontSize / 14) + (fontSize / 40), fontSize / 1.8),
            3: Offset((fontSize / 4) + (fontSize / 35), fontSize / 1.112),
          },
          'binary': const [0, 0, 0, 0]
        },
        '1': {
          'offset': {
            0: Offset((fontSize / 8) + (fontSize / 35), fontSize / 3),
            1: Offset((fontSize / 3.5) + (fontSize / 40), fontSize / 3.5),
            2: Offset((fontSize / 3.5) + (fontSize / 40), fontSize / 1.8),
            3: Offset((fontSize / 3.5) + (fontSize / 35), fontSize / 1.2),
          },
          'binary': const [0, 0, 0, 1]
        },
        '2': {
          'offset': {
            0: Offset((fontSize / 10) + (fontSize / 35), fontSize / 3),
            1: Offset((fontSize / 2.5) + (fontSize / 40), fontSize / 3),
            2: Offset((fontSize / 3.8) + (fontSize / 40), fontSize / 1.5),
            3: Offset((fontSize / 2.5) + (fontSize / 35), fontSize / 1.14),
          },
          'binary': const [0, 0, 1, 0]
        },
        '3': {
          'offset': {
            0: Offset((fontSize / 10) + (fontSize / 35), fontSize / 3),
            1: Offset((fontSize / 2.5) + (fontSize / 40), fontSize / 3),
            2: Offset((fontSize / 2.4) + (fontSize / 40), fontSize / 1.25),
            3: Offset((fontSize / 10.5) + (fontSize / 35), fontSize / 1.25),
          },
          'binary': const [0, 0, 1, 1]
        },
        '4': {
          'offset': {
            0: Offset((fontSize / 7.0) + (fontSize / 35), fontSize / 1.8),
            1: Offset((fontSize / 2.7) + (fontSize / 40), fontSize / 3.6),
            2: Offset((fontSize / 2.7) + (fontSize / 40), fontSize / 1.8),
            3: Offset((fontSize / 2.7) + (fontSize / 35), fontSize / 1.15),
          },
          'binary': const [0, 1, 0, 0]
        },
        '5': {
          'offset': {
            0: Offset((fontSize / 2.7) + (fontSize / 40), fontSize / 3.8),
            1: Offset((fontSize / 8.0) + (fontSize / 35), fontSize / 2.0),
            2: Offset((fontSize / 2.25) + (fontSize / 40), fontSize / 1.5),
            3: Offset((fontSize / 8.5) + (fontSize / 35), fontSize / 1.25),
          },
          'binary': const [0, 1, 0, 1]
        },
        '6': {
          'offset': {
            0: Offset((fontSize / 3.0) + (fontSize / 40), fontSize / 3.8),
            1: Offset((fontSize / 10.0) + (fontSize / 35), fontSize / 2.0),
            2: Offset((fontSize / 8.5) + (fontSize / 35), fontSize / 1.25),
            3: Offset((fontSize / 2.25) + (fontSize / 40), fontSize / 1.5),
          },
          'binary': const [0, 1, 1, 0]
        },
        '7': {
          'offset': {
            0: Offset((fontSize / 10.0) + (fontSize / 40), fontSize / 3.8),
            1: Offset((fontSize / 2.25) + (fontSize / 35), fontSize / 3.8),
            2: Offset((fontSize / 3.125) + (fontSize / 35), fontSize / 1.8),
            3: Offset((fontSize / 5.5) + (fontSize / 40), fontSize / 1.13),
          },
          'binary': const [0, 1, 1, 1]
        },
        '8': {
          'offset': {
            0: Offset((fontSize / 10.0) + (fontSize / 40), fontSize / 3.0),
            1: Offset((fontSize / 2.4) + (fontSize / 35), fontSize / 2.5),
            2: Offset((fontSize / 10.0) + (fontSize / 35), fontSize / 1.4),
            3: Offset((fontSize / 2.5) + (fontSize / 40), fontSize / 1.2),
          },
          'binary': const [1, 0, 0, 0]
        },
        '9': {
          'offset': {
            0: Offset((fontSize / 11) + (fontSize / 40), fontSize / 2.5),
            1: Offset((fontSize / 2.5) + (fontSize / 35), fontSize / 2.5),
            2: Offset((fontSize / 2.5) + (fontSize / 35), fontSize / 1.4),
            3: Offset((fontSize / 6.0) + (fontSize / 40), fontSize / 1.14),
          },
          'binary': const [1, 0, 0, 1]
        },
      };

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
