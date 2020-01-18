// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:digital_clock/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test Binary Digits', () {
    bool passed = false;
    if (props(14)['0']['binary'] == [0, 0, 0, 0]) {
      passed = true;
    } else {
      return false;
    }
    if (props(14)['0']['binary'] != [0, 0, 0, 1]) {
      passed = true;
    } else {
      return false;
    }
    return passed;
  });
}
