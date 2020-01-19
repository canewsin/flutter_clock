// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clock.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Clock on _Clock, Store {
  final _$secondsAtom = Atom(name: '_Clock.seconds');

  @override
  String get seconds {
    _$secondsAtom.context.enforceReadPolicy(_$secondsAtom);
    _$secondsAtom.reportObserved();
    return super.seconds;
  }

  @override
  set seconds(String value) {
    _$secondsAtom.context.conditionallyRunInAction(() {
      super.seconds = value;
      _$secondsAtom.reportChanged();
    }, _$secondsAtom, name: '${_$secondsAtom.name}_set');
  }

  final _$minutesAtom = Atom(name: '_Clock.minutes');

  @override
  String get minutes {
    _$minutesAtom.context.enforceReadPolicy(_$minutesAtom);
    _$minutesAtom.reportObserved();
    return super.minutes;
  }

  @override
  set minutes(String value) {
    _$minutesAtom.context.conditionallyRunInAction(() {
      super.minutes = value;
      _$minutesAtom.reportChanged();
    }, _$minutesAtom, name: '${_$minutesAtom.name}_set');
  }

  final _$hoursAtom = Atom(name: '_Clock.hours');

  @override
  String get hours {
    _$hoursAtom.context.enforceReadPolicy(_$hoursAtom);
    _$hoursAtom.reportObserved();
    return super.hours;
  }

  @override
  set hours(String value) {
    _$hoursAtom.context.conditionallyRunInAction(() {
      super.hours = value;
      _$hoursAtom.reportChanged();
    }, _$hoursAtom, name: '${_$hoursAtom.name}_set');
  }

  final _$dayAtom = Atom(name: '_Clock.day');

  @override
  int get day {
    _$dayAtom.context.enforceReadPolicy(_$dayAtom);
    _$dayAtom.reportObserved();
    return super.day;
  }

  @override
  set day(int value) {
    _$dayAtom.context.conditionallyRunInAction(() {
      super.day = value;
      _$dayAtom.reportChanged();
    }, _$dayAtom, name: '${_$dayAtom.name}_set');
  }

  final _$monthAtom = Atom(name: '_Clock.month');

  @override
  int get month {
    _$monthAtom.context.enforceReadPolicy(_$monthAtom);
    _$monthAtom.reportObserved();
    return super.month;
  }

  @override
  set month(int value) {
    _$monthAtom.context.conditionallyRunInAction(() {
      super.month = value;
      _$monthAtom.reportChanged();
    }, _$monthAtom, name: '${_$monthAtom.name}_set');
  }

  final _$tempAtom = Atom(name: '_Clock.temp');

  @override
  int get temp {
    _$tempAtom.context.enforceReadPolicy(_$tempAtom);
    _$tempAtom.reportObserved();
    return super.temp;
  }

  @override
  set temp(int value) {
    _$tempAtom.context.conditionallyRunInAction(() {
      super.temp = value;
      _$tempAtom.reportChanged();
    }, _$tempAtom, name: '${_$tempAtom.name}_set');
  }

  final _$wishAtom = Atom(name: '_Clock.wish');

  @override
  String get wish {
    _$wishAtom.context.enforceReadPolicy(_$wishAtom);
    _$wishAtom.reportObserved();
    return super.wish;
  }

  @override
  set wish(String value) {
    _$wishAtom.context.conditionallyRunInAction(() {
      super.wish = value;
      _$wishAtom.reportChanged();
    }, _$wishAtom, name: '${_$wishAtom.name}_set');
  }

  final _$oldwishAtom = Atom(name: '_Clock.oldwish');

  @override
  String get oldwish {
    _$oldwishAtom.context.enforceReadPolicy(_$oldwishAtom);
    _$oldwishAtom.reportObserved();
    return super.oldwish;
  }

  @override
  set oldwish(String value) {
    _$oldwishAtom.context.conditionallyRunInAction(() {
      super.oldwish = value;
      _$oldwishAtom.reportChanged();
    }, _$oldwishAtom, name: '${_$oldwishAtom.name}_set');
  }

  final _$weekdayAtom = Atom(name: '_Clock.weekday');

  @override
  String get weekday {
    _$weekdayAtom.context.enforceReadPolicy(_$weekdayAtom);
    _$weekdayAtom.reportObserved();
    return super.weekday;
  }

  @override
  set weekday(String value) {
    _$weekdayAtom.context.conditionallyRunInAction(() {
      super.weekday = value;
      _$weekdayAtom.reportChanged();
    }, _$weekdayAtom, name: '${_$weekdayAtom.name}_set');
  }

  final _$_ClockActionController = ActionController(name: '_Clock');

  @override
  void setSeconds(String secondsL) {
    final _$actionInfo = _$_ClockActionController.startAction();
    try {
      return super.setSeconds(secondsL);
    } finally {
      _$_ClockActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMinutes(String minutesL) {
    final _$actionInfo = _$_ClockActionController.startAction();
    try {
      return super.setMinutes(minutesL);
    } finally {
      _$_ClockActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHours(String hoursL) {
    final _$actionInfo = _$_ClockActionController.startAction();
    try {
      return super.setHours(hoursL);
    } finally {
      _$_ClockActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setday(int dayL) {
    final _$actionInfo = _$_ClockActionController.startAction();
    try {
      return super.setday(dayL);
    } finally {
      _$_ClockActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setmonth(int monthL) {
    final _$actionInfo = _$_ClockActionController.startAction();
    try {
      return super.setmonth(monthL);
    } finally {
      _$_ClockActionController.endAction(_$actionInfo);
    }
  }

  @override
  void settemp(int tempL) {
    final _$actionInfo = _$_ClockActionController.startAction();
    try {
      return super.settemp(tempL);
    } finally {
      _$_ClockActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setwish(String wishL) {
    final _$actionInfo = _$_ClockActionController.startAction();
    try {
      return super.setwish(wishL);
    } finally {
      _$_ClockActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOldwish(String wishL) {
    final _$actionInfo = _$_ClockActionController.startAction();
    try {
      return super.setOldwish(wishL);
    } finally {
      _$_ClockActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setweekday(String weekdayL) {
    final _$actionInfo = _$_ClockActionController.startAction();
    try {
      return super.setweekday(weekdayL);
    } finally {
      _$_ClockActionController.endAction(_$actionInfo);
    }
  }
}
