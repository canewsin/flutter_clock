import 'package:mobx/mobx.dart';

// Include generated file
part 'clock.g.dart';

// This is the class used by rest of your codebase
class Clock = _Clock with _$Clock;

// The store-class
abstract class _Clock with Store {
  @observable
  String seconds = '00';

  @action
  void setSeconds(String secondsL) {
    seconds = secondsL;
  }

  @observable
  String minutes = '00';

  @action
  void setMinutes(String minutesL) {
    minutes = minutesL;
  }

  @observable
  String hours = '00';

  @action
  void setHours(String hoursL) {
    hours = hoursL;
  }

  @observable
  int day = 0;

  @action
  void setday(int dayL) {
    day = dayL;
  }

  @observable
  int month = 0;

  @action
  void setmonth(int monthL) {
    month = monthL;
  }

  @observable
  int temp = 0;

  @action
  void settemp(int tempL) {
    temp = tempL;
  }

  @observable
  String wish = '';

  @action
  void setwish(String wishL) {
    wish = wishL;
  }

  @observable
  String weekday = '';

  @action
  void setweekday(String weekdayL) {
    weekday = weekdayL;
  }
}
