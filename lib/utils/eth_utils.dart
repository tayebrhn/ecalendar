import 'package:abushakir/abushakir.dart';

class EthUtils {
    static const initialPage = 10000;
    static const int dayGrid = 42;

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
static bool isSameDay(EtDatetime a, EtDatetime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

static List dayEvent(EtDatetime date) {  
  return BahireHasab(year: date.year).allAtswamat.where((element) {
    return element['day']['date'] == date.day && element['day']['month'] == date.monthGeez;
  }).toList();
}



}

