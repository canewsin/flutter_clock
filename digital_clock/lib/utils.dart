import 'package:flutter/material.dart';

import 'mobx/clock.dart';

enum ClockTheme {
  background,
  text,
  textTemp,
  shadow,
  startColor,
  middleColor,
  endColor,
}
final clock = Clock();

List<String> numbers = const []
  ..addAll(ones)
  ..addAll(
    [
      'Ten',
      'Eleven',
      'Twelve',
    ],
  );

List<String> ones = const [
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

List<String> teens = const [
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

List<String> tens = const [
  'Ten',
  'Twenty',
  'Thirty',
  'Forty',
  'Fifty',
  'Sixty',
];

List<String> weekdays = const [
  'Sunday',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
];

List<String> months = const [
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

final lightTheme = const {
  ClockTheme.background: Color(0xFF81B3FE),
  ClockTheme.text: Colors.white,
  ClockTheme.textTemp: Color(0xFF286788),
  ClockTheme.shadow: Colors.black,
  ClockTheme.startColor: Color(0xFFFFFFFF),
  ClockTheme.middleColor: Color(0xFF59B9EB),
  ClockTheme.endColor: Color(0xFF174EA6),
};

final darkTheme = const {
  ClockTheme.background: Colors.black,
  ClockTheme.text: Colors.white,
  ClockTheme.textTemp: Colors.white,
  ClockTheme.shadow: Color(0xFF174EA6),
  ClockTheme.startColor: Color(0xFF00A7FF),
  ClockTheme.middleColor: Color(0xFF286788),
  ClockTheme.endColor: Color(0xFF00466B),
};
