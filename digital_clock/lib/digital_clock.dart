// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import 'utils.dart';

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

  void _updateModel() => (mounted) ? setState(() {}) : null;

  bool _lightYearMode = false;
  void _updateTime() {
    var _dateTime = !_lightYearMode
        ? DateTime.now()
        : DateTime.fromMillisecondsSinceEpoch(
            (DateTime.now().millisecondsSinceEpoch * 8000).toInt());
    ;
    String hour =
        DateFormat(widget.model.is24HourFormat ? 'HH' : 'hh').format(_dateTime);
    String minute = DateFormat('mm').format(_dateTime);
    String second = DateFormat('ss').format(_dateTime);
    clock.setSeconds(second);
    clock.setMinutes(minute);
    clock.setHours(hour);
    clock.setmonth(_dateTime.month);
    clock.setday(_dateTime.day);
    clock.setwish(getTimeText('$hour:$minute'));
    clock.setweekday(weekdays[_dateTime.weekday - 1]);

    _timer = Timer(
      Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
      _updateTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    var fontSize = 0.0;
    var calcWidth = 0.0;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      calcWidth = MediaQuery.of(context).size.width;
      fontSize = calcWidth / 3.0;
    } else {
      calcWidth = MediaQuery.of(context).size.height / 3 * 4.75;
      fontSize = calcWidth / 3.0;
    }
    final colors = Theme.of(context).brightness == Brightness.light
        ? lightTheme
        : darkTheme;

    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          stops: [
            0.0,
            0.25,
            1.0,
          ],
          colors: [
            colors[ClockTheme.startColor],
            colors[ClockTheme.middleColor],
            colors[ClockTheme.endColor],
          ],
          radius: 1.2,
          center: Alignment.topLeft,
        ),
      ),
      child: Center(
        child: Stack(
          children: <Widget>[
            TimeWidget(
              calcWidth: calcWidth,
              fontSize: fontSize,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TopWidgets(
                  calcWidth: calcWidth,
                  widget: widget,
                  colors: colors,
                ),
                SecondsTicker(
                  calcWidth: calcWidth,
                ),
                WishWidget(
                  calcWidth: calcWidth,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String timeString(int hours, int min) {
    List<int> listHack = [0, 15, 30, 45];
    if (hours == 0) hours = 12;
    if (listHack.contains(min)) {
      switch (min) {
        case 0:
          return '${numbers[hours - 1]}\'O Clock';
          break;
        case 15:
          return 'Quarter Past ${numbers[hours - 1]}.';
          break;
        case 30:
          return 'Half Past ${numbers[hours - 1]}.';
          break;
        case 45:
          return 'Quarter To ${(hours == 12) ? numbers[0] : numbers[hours]}.';
          break;
        default:
      }
    } else if (min > 0) {
      if (min < 45) {
        if (min < 15)
          return '${dectoText(min)} Past ${numbers[hours - 1]}';
        else
          return '${numbers[hours - 1]} ${dectoText(min)}'; //${(hours == 12) ? '' : 'Minutes'}
      } else {
        return '${dectoText(60 - min)} Minutes To ${(hours == 12) ? numbers[0] : numbers[hours]}';
      }
    }
    return '';
  }

  String dectoText(int dec) {
    var txt = '';
    var localStr = dec.toString();
    if (localStr.length < 2) localStr = '0$localStr';
    String onesPos = localStr.substring(1);
    String tensPos = localStr.substring(0, 1);
    int onesInt = int.parse(onesPos);
    int tensInt = int.parse(tensPos);
    if (onesInt > 0) txt = ones[onesInt - 1];
    if (dec > 0 && dec < 20) {
      if (dec > 10 && dec < 20)
        txt = teens[dec - 10 - 1];
      else if (dec == 10) txt = tens[0];
    } else {
      if (tensPos != '0' && onesPos != '0')
        txt = tens[tensInt - 1] + ' $txt';
      else
        txt = 'Twelve';
    }
    return txt;
  }

  String improveWish(String hours, String wish, bool afternoon) {
    if (hours.contains('Twelve')) {
      if (!afternoon) {
        wish = wish + ' Already, Have a Sweet Dream with your Pillow.';
      } else {
        wish = wish + ', Have Your Tasty Lunch.';
      }
    } else if (hours.contains('Five') ||
        hours.contains('Six') ||
        hours.contains('Seven') ||
        hours.contains('Eight') ||
        hours.contains('Nine')) {
      if (!afternoon) {
        wish = 'Good Morning, $wish.';
      } else {
        wish = 'Good Evening, $wish.';
      }
    } else if (hours.contains('Ten')) {
      if (!afternoon) {
        wish = 'Good Morning, $wish.';
      } else {
        wish = 'Good Night, $wish, Have Sweet Dreams.';
      }
    } else if (hours.contains('One') ||
        hours.contains('Two') ||
        hours.contains('Three') ||
        hours.contains('Four')) {
      if (!afternoon) {
        wish = 'Good Morning, $wish.';
      } else {
        wish = 'Good Afternoon, $wish.';
      }
    }
    return wish;
  }

  String getTimeText(String time) {
    int hours = int.parse(time.substring(0, time.indexOf(':')));
    bool afternoon = false;
    if (hours >= 12) {
      afternoon = true;
      hours = hours - 12;
    }
    int minutes = int.parse(time.substring(time.indexOf(':') + 1, time.length));
    String wish = "It's ${timeString(hours, minutes)}";
    return improveWish(dectoText(hours), wish, afternoon);
  }
}

class TopWidgets extends StatelessWidget {
  const TopWidgets({
    Key key,
    @required this.calcWidth,
    @required this.widget,
    @required this.colors,
  }) : super(key: key);

  final double calcWidth;
  final DigitalClock widget;
  final Map<ClockTheme, ui.Color> colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TempWidget(calcWidth: calcWidth, widget: widget, colors: colors),
        DateandDayWidget(calcWidth: calcWidth),
      ],
    );
  }
}

class TimeWidget extends StatelessWidget {
  const TimeWidget({
    Key key,
    @required this.calcWidth,
    @required this.fontSize,
  }) : super(key: key);

  final double fontSize;
  final double calcWidth;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).brightness == Brightness.light
        ? lightTheme
        : darkTheme;
    final defaultStyle = TextStyle(
      color: colors[ClockTheme.text],
      fontFamily: 'Roboto-Medium',
      fontSize: fontSize,
      shadows: [
        Shadow(
          blurRadius: 0,
          color: colors[ClockTheme.shadow],
          offset: Offset(0, 0),
        ),
      ],
    );
    List<Widget> paintedTexts = [];
    for (var i = 0; i < 4; i++) {
      paintedTexts.add(
        Observer(
          builder: (context) {
            String str = '00';
            switch (i) {
              case 0:
                str = clock.hours.substring(0, 1);
                break;
              case 1:
                str = clock.hours.substring(1);
                break;
              case 2:
                str = clock.minutes.substring(0, 1);
                break;
              case 3:
                str = clock.minutes.substring(1);
                break;
              default:
            }

            return Padding(
              padding: EdgeInsets.only(
                left: calcWidth / 16.44,
                right: calcWidth / 8.22,
                top: calcWidth / 10.275,
              ),
              child:
                  // AnimatedContainer(
                  //   duration: Duration(seconds: 2),
                  //   curve: Curves.bounceInOut,
                  //   child:
                  CustomPaint(
                painter: TextPainterC(
                  str,
                  defaultStyle,
                ),
              ),
              // ),
            );
          },
        ),
      );
    }
    paintedTexts.insert(
      2,
      Padding(
        padding: EdgeInsets.only(
          left: calcWidth / 16.44,
          right: calcWidth / 13.7,
          top: calcWidth / 10.275,
        ),
      ),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: paintedTexts,
    );
  }
}

class TempWidget extends StatelessWidget {
  const TempWidget({
    Key key,
    @required this.calcWidth,
    @required this.widget,
    @required this.colors,
  }) : super(key: key);

  final double calcWidth;
  final DigitalClock widget;
  final Map<ClockTheme, ui.Color> colors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(calcWidth / 34.25),
      child: Observer(builder: (context) {
        int sec = int.parse(clock.seconds);
        String temp = '';
        if (sec > 40) {
          temp = 'High : ' + widget.model.highString;
        } else if (sec > 20) {
          temp = ' Low : ' + widget.model.lowString;
        } else {
          temp = 'Avg : ' + widget.model.temperatureString;
        }
        return Text(
          temp,
          style: TextStyle(
            fontSize: calcWidth / 29.36,
            color: colors[ClockTheme.textTemp],
          ),
        );
      }),
    );
  }
}

class DateandDayWidget extends StatelessWidget {
  const DateandDayWidget({
    Key key,
    @required this.calcWidth,
  }) : super(key: key);

  final double calcWidth;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final weekday = clock.weekday;
        final day = clock.day;
        final month = months[clock.month - 1];
        return Padding(
          padding: EdgeInsets.all(calcWidth / 34.25),
          child: Text(
            '$weekday, $day $month',
            style: TextStyle(
              fontSize: calcWidth / 29.36,
              color: Color(0xFFFFFFFF),
            ),
          ),
        );
      },
    );
  }
}

class WishWidget extends StatelessWidget {
  const WishWidget({
    Key key,
    @required this.calcWidth,
  }) : super(key: key);

  final double calcWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Observer(builder: (context) {
        return Text(
          clock.wish,
          style: TextStyle(
            fontSize: calcWidth / 34.25,
            color: Color(0xFF286788),
          ),
        );
      }),
    );
  }
}

class SecondsTicker extends StatelessWidget {
  const SecondsTicker({
    Key key,
    @required this.calcWidth,
  }) : super(key: key);

  final double calcWidth;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Observer(builder: (context) {
        var second = int.parse(clock.seconds).toRadixString(2);
        if (second.length < 6) second = '0' * (6 - second.length) + second;
        List<Widget> bins = [];
        for (var i = 0; i < second.length; i++) {
          double size = calcWidth / 41.1;
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
                  color: Colors.white.withAlpha(125), //Color(0xFF286788),
                ),
              ),
            ),
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: bins,
        );
      }),
    );
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
        fontSize: style.fontSize,
        fontFamily: style.fontFamily,
        fontStyle: style.fontStyle,
        fontWeight: style.fontWeight,
        textAlign: TextAlign.justify,
      ),
    )
      ..pushStyle(ui.TextStyle(shadows: [
        ui.Shadow(
          blurRadius: 45,
          color: Colors.black45, //Colors.white54.withOpacity(0.25)
          offset: Offset(0, 5),
        ),
      ]))
      ..addText(text);

    final ui.Paragraph paragraph = paragraphBuilder.build()
      ..layout(
        ui.ParagraphConstraints(width: size.width),
      );
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

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
