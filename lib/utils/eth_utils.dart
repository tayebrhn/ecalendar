import 'package:abushakir/abushakir.dart';

class EthUtils {
    static const initialPage = 10000;
static EtDatetime getfirstDayOfWeek(EtDatetime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }
 static List<EtDatetime> getWeekDates(EtDatetime startOfWeek) {
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }
static List<EtDatetime> getMonthDates(EtDatetime startOfWeek) {
    return List.generate(30, (index) => startOfWeek.add(Duration(days: index)));
}
  static final List _weekDayNames = ETC.today().weekdays;

}

