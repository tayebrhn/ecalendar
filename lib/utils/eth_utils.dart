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

  // static final List _weekDayNames = ETC.today().weekdays;
  static bool isSameDay(EtDatetime a, EtDatetime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static bool isToday(EtDatetime day) {
    final EtDatetime now = EtDatetime.now();
    return day.year == now.year && day.month == now.month && day.day == now.day;
  }

  static List dayEvent(EtDatetime date) {
    return BahireHasab(year: date.year).allAtswamat.where((element) {
      return element['day']['date'] == date.day &&
          element['day']['month'] == date.monthGeez;
    }).toList();
  }
}

class BealEvent {
  final String _beal;
  final String _month;
  final int _date;

  const BealEvent(this._beal, this._month, this._date);
  const BealEvent.empty() : _beal = '', _date = 0, _month = '';

  factory BealEvent.fromJson(List list) {
    if (list.isNotEmpty) {
      final bealName = list[0]['beal'];
      final bealMonth = list[0]['day']['month'];
      final bealDate = list[0]['day']['date'];
      return BealEvent(bealName, bealMonth, bealDate);
    }
    return BealEvent.empty();
  }

  String get beal => _beal;
  String get month => _month;
  int get date => _date;
}
