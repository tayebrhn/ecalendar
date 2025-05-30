import 'package:abushakir/abushakir.dart';
import 'package:flutter/material.dart';

const initialPage = 10000;
const int dayGrid = 42;

EtDatetime getfirstDayOfWeek(EtDatetime date) {
  return date.subtract(Duration(days: date.weekday - 1));
}

List<EtDatetime> getWeekDates(EtDatetime startOfWeek) {
  return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
}

List<EtDatetime> getMonthDates(EtDatetime startOfWeek) {
  return List.generate(30, (index) => startOfWeek.add(Duration(days: index)));
}

//  final List _weekDayNames = ETC.today().weekdays;
bool isSameDay(EtDatetime a, EtDatetime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

bool currentMonth(EtDatetime a, EtDatetime b) {
  return a.month == b.month;
}

bool isToday(EtDatetime day) {
  final EtDatetime now = EtDatetime.now();
  return day.year == now.year && day.month == now.month && day.day == now.day;
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

// class DayCell {
//   final EtDatetime date;
//   final bool isCurrentMonth;
//   DayCell({required this.date, required this.isCurrentMonth});
//   bool get hasEvents {
//     return date.dayEvent().isNotEmpty;
//   }

//   BealEvent get bealEvent {
//     return BealEvent.fromJson(date.dayEvent());
//   }
// }

extension on EtDatetime {
  // List dayEvent() {
  //   return BahireHasab(year: year).allAtswamat.where((element) {
  //     return element['day']['date'] == day &&
  //         element['day']['month'] == monthGeez;
  //   }).toList();
  // }

  // bool get hasEvents {
  //   return dayEvent().isNotEmpty;
  // }

  // BealEvent get bealEvent {
  //   return BealEvent.fromJson(dayEvent());
  // }

  int get totalDays {
    return month == 13
        ? isLeap
            ? 6
            : 5
        : 30;
  }
}

// List<DayCell> generateMonthDays(EtDatetime month) {
//   /**
//      *
//      * weekdays
//      * sun->0
//      * mon->1
//      * tue->2
//      * wed->3
//      * thu->4
//      * fri->5
//      * sat->6
//      * */
//   final startWeekDay = month.weekday % 7;

//   final totalDays = month.totalDays();

//   //prev month
//   final EtDatetime prevMonth;
//   if (month.month - 1 == 0) {
//     prevMonth = EtDatetime(year: month.year - 1, month: 13);
//   } else {
//     prevMonth = EtDatetime(year: month.year, month: month.month - 1);
//   }
//   final prevMonthDays = prevMonth.totalDays();
//   final leadingDays = [
//     for (int i = startWeekDay - 1; i >= 0; i--)
//       DayCell(
//         date: EtDatetime(
//           year: prevMonth.year,
//           month: prevMonth.month,
//           day: prevMonthDays - i,
//         ),
//         isCurrentMonth: false,
//       ),
//   ];

//   //current month
//   final currentDays = [
//     for (int d = 1; d <= totalDays; d++)
//       DayCell(
//         date: EtDatetime(year: month.year, month: month.month, day: d),
//         isCurrentMonth: true,
//       ),
//   ];

//   // Next month
//   final trailingNeeded = dayGrid - (leadingDays.length + currentDays.length);
//   final nextMonth = EtDatetime(year: month.year, month: month.month + 1);
//   final trailingDays = [
//     for (int d = 1; d <= trailingNeeded; d++)
//       DayCell(
//         date: EtDatetime(year: nextMonth.year, month: nextMonth.month, day: d),
//         isCurrentMonth: false,
//       ),
//   ];
//   return [...leadingDays, ...currentDays, ...trailingDays];
// }

List<EtDatetime> generateMonthDaysNew(EtDatetime month) {
  // final key = '${month.year}-${month.month}';
  // if (_monthCache.containsKey(key)) return _monthCache[key]!;

  final firstDay = EtDatetime(year: month.year, month: month.month, day: 1);
  final daysBefore = firstDay.weekday % 7;
  final daysInMonth = month.totalDays;
  final totalCells = ((daysBefore + daysInMonth + 6) ~/ 7) * 7;
  // final totalCells = 6 * 7;
  final startDay = firstDay.subtract(Duration(days: daysBefore));
  final days = List.generate(
    totalCells,
    (i) => startDay.add(Duration(days: i)),
  );
  // _monthCache[key] = days;
  return days;
}
