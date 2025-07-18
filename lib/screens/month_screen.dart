import 'package:abushakir/abushakir.dart';
import '../state/state_manager.dart';
import '../widgets/month_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/eth_utils.dart';

class MonthlyScreen extends StatefulWidget {
  const MonthlyScreen({super.key});
  @override
  State<MonthlyScreen> createState() => _MonthlyScreenState();
}

class _MonthlyScreenState extends State<MonthlyScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DateChangeNotifier>().ifPageSet();
      // print(context.read<DateChangeNotifier>().currentPage);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageCtrlr =
        Provider.of<DateChangeNotifier>(context, listen: false).pageController;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: _buildWeekdayHeaders(2)),
          Expanded(
            flex: 11,
            child: PageView.builder(
              controller: pageCtrlr,
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
                context.read<DateChangeNotifier>().updatePageNum(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekdayHeaders(int startOfWeek) {
    return Table(
      children: [
        TableRow(
          children:
              getLocalizedEthiopianWeekDays(context)
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
                        day,
                      ),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}
