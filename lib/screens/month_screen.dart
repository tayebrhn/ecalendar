import 'package:abushakir/abushakir.dart';
import 'package:eccalendar/state/state_manager.dart';
import 'package:eccalendar/utils/themedata_extension.dart';
import 'package:eccalendar/widgets/month_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../utils/eth_utils.dart';

class MonthlyScreen extends StatefulWidget {
  const MonthlyScreen({super.key});
  @override
  State<MonthlyScreen> createState() => _MonthlyScreenState();
}

class _MonthlyScreenState extends State<MonthlyScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: initialPage);
  }

  @override
  void didUpdateWidget(covariant MonthlyScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    //not advisable to dispose provider objects
    // pageProvider.dispose();
    // dateChangeProvider.dispose();
    // calEvent.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<EtDatetime> daycell;
    // final pageManager =
    // //     Provider.of<DateChangeNotifier>(context, listen: false).pageController;
    // final CalendarThemeData calendarTheme =
    //     Theme.of(context).extension<CalendarThemeData>()!;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    // final PageProvider pageProvider = Provider.of<PageProvider>(context);
    DateChangeNotifier dateChangeProvider = Provider.of<DateChangeNotifier>(
      context,
      listen: false,
    );
    return Card(
                    color: Colors.grey[200],

      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: _buildWeekdayHeaders(2),
          ),
          Expanded(
            flex: 11,
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                // dateChangeProvider.changeDate =
                final EtDatetime date = monthOffset(index);
                  
                // WidgetsBinding.instance.addPostFrameCallback((_) {
                //   context.read<DateChangeNotifier>().changeDate = date;
                // });
                return MonthlyWidget(
                  date: date,
                  // onDateSelected: (EtDatetime date) {
                  //   setState(() {
                  //     _selectedtDate = date;
                  //   });
                  // },
                  // prevMonthCallback: _goToPreviousMonth,
                  // nextMonthCallback: _goToNextMonth,
                  onDateChanged: (date) {
                    // context.read<DateChangeNotifier>().changeDate = date;
                  },
                );
              },
              //precedence in calculation matters,
              //if onPageChanged was called before itemBuilder it always called first,
              //therefore not synching the correct index of the itemBuilder
              onPageChanged: (index) {
                context.read<DateChangeNotifier>().changeDate = monthOffset(
                  index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekdayHeaders(int startOfWeek) {
    // Generate weekday names starting from custom start day
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    // final weekdays = List.generate(7, (index) {
    //   final weekday =
    //       (startOfWeek - 1 + index) % 7 + 1; // Calculate weekday number
    //   return DateFormat(
    //     'E',
    //   ).format(DateTime(2023, 1, weekday)); // Any date with known weekday
    // });

    return Table(
      children: [
        TableRow(
          children:
              weekdays
                  .map(
                    (day) => Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.clip,
                        day.toString(),
                      ),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}
