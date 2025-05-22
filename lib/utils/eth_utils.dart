import 'package:abushakir/abushakir.dart';

mixin EthUtils {
    static const initialPage = 10000;
EtDatetime getfirstDayOfWeek(EtDatetime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }
  List<EtDatetime> getWeekDates(EtDatetime startOfWeek) {
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }
List<EtDatetime> getMonthDates(EtDatetime startOfWeek) {
    return List.generate(30, (index) => startOfWeek.add(Duration(days: index)));
}
  final List _weekDayNames = ETC.today().weekdays;

}