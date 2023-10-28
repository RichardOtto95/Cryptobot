import 'package:cryptobot/app/constants/colors.dart';
import 'package:cryptobot/app/core/models/time_model.dart';
import 'package:cryptobot/app/shared/cryptobot_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../utilities.dart';

class ScoreDatePicker extends StatefulWidget {
  final void Function(DateTime?) onConfirm;
  final void Function() onCancel;
  final DateTime? initialDate;

  const ScoreDatePicker({
    Key? key,
    required this.onConfirm,
    required this.onCancel,
    this.initialDate,
  }) : super(key: key);

  @override
  _ScoreDatePickerState createState() => _ScoreDatePickerState();
}

class _ScoreDatePickerState extends State<ScoreDatePicker> {
  CalendarController calendarController = CalendarController();
  DateTime today = DateTime.now();
  DateTime lastDate = DateTime.now();
  DateTime? _date;
  DateTime? yearSelected;

  @override
  void initState() {
    calendarController.displayDate = DateTime.now();
    super.initState();
  }

  @override
  void dispose() {
    calendarController.dispose();
    super.dispose();
  }

  List<String> letterDays = ["D", "S", "T", "Q", "Q", "S", "S"];

  List<String> weekDays = [
    "",
    "Seg",
    "Ter",
    "Qua",
    "Qui",
    "Sex",
    "Sab",
    "Dom",
  ];

  OverlayEntry? yearOverlay;

  OverlayEntry getOverlay() {
    List<Widget> getYearsWidgets() {
      List<Widget> years = [];
      for (int i = today.year; i >= 1900; i--) {
        years.add(
          InkWell(
            onTap: () {
              calendarController.selectedDate = DateTime(i, 6);
              calendarController.displayDate = DateTime(i, 6);
              yearOverlay!.remove();
              yearOverlay = null;
            },
            child: Container(
              height: wXD(50, context, webSize: 16),
              width: wXD(80, context, webSize: 26),
              alignment: Alignment.center,
              child: Text(
                i.toString(),
                style: textFamily(fontSize: 14),
              ),
            ),
          ),
        );
      }
      return years;
    }

    return OverlayEntry(
      builder: (context) {
        return Positioned(
          child: GestureDetector(
            onTap: () {
              yearOverlay!.remove();
              yearOverlay = null;
            },
            child: Container(
              height: maxHeight(context),
              width: maxWidth(context),
              color: black.withOpacity(.15),
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.only(
                        top: wXD(80, context, webSize: 26),
                        bottom: wXD(15, context, webSize: 3)),
                    width: wXD(300, context, webSize: 100),
                    height: wXD(400, context, webSize: 100),
                    alignment: Alignment.center,
                    child: Material(
                      color: Colors.transparent,
                      child: ScrollConfiguration(
                        behavior: CryptobotScrollBehavior(),
                        child: SingleChildScrollView(
                          child: Wrap(
                            children: getYearsWidgets(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Container(
                      width: wXD(300, context, webSize: 100),
                      height: wXD(80, context, webSize: 25),
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                        color: primaryColor,
                      ),
                      padding:
                          EdgeInsets.only(left: wXD(20, context, webSize: 5)),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Selecione um ano",
                        style: textFamily(
                          fontSize: 20,
                          color: white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String month = "";

  @override
  Widget build(BuildContext context) {
    month = Time(calendarController.displayDate!).month();
    return Material(
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTap: () {
              widget.onCancel();
            },
            child: Container(
              height: maxHeight(context),
              width: maxWidth(context),
              color: black.withOpacity(.5),
              alignment: Alignment.center,
            ),
          ),
          Container(
            height: wXD(448, context, webSize: 130),
            width: wXD(339, context, webSize: 90),
            decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Column(
              children: [
                Container(
                  width: wXD(339, context, webSize: 90),
                  height: wXD(107, context, webSize: 30),
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25)),
                    color: primaryColor,
                  ),
                  padding: EdgeInsets.only(
                      left: wXD(30, context, webSize: 10),
                      top: wXD(14, context, webSize: 5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        today.year.toString(),
                        textAlign: TextAlign.center,
                        style: textFamily(
                          fontSize: 17,
                          color: white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: wXD(7, context, webSize: 3)),
                      Text(
                        Time(today).weekDay(capitalize: true).substring(0, 3) +
                            ", ${today.day} de " +
                            Time(today).month(capitalize: true).substring(0, 3),
                        textAlign: TextAlign.center,
                        style: textFamily(
                          fontSize: 32,
                          color: white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                        width: wXD(280, context, webSize: 90),
                        height: wXD(340, context, webSize: 100),
                        padding:
                            EdgeInsets.only(top: wXD(35, context, webSize: 15)),
                        alignment: Alignment.center,
                        child: SfCalendar(
                          initialDisplayDate: widget.initialDate,
                          onViewChanged: (viewChangedDetails) {
                            print(
                                "${viewChangedDetails.visibleDates.first}   -   $today");
                            if (viewChangedDetails.visibleDates.first.month !=
                                    lastDate.month ||
                                viewChangedDetails.visibleDates.first.year !=
                                    lastDate.year) {
                              WidgetsBinding.instance!
                                  .addPostFrameCallback((_) {
                                setState(() {
                                  print("setState 1");
                                });
                              });
                            }
                            lastDate = viewChangedDetails.visibleDates.first;
                          },
                          onTap: (calendarTapDetails) =>
                              _date = calendarTapDetails.date,
                          controller: calendarController,
                          view: CalendarView.month,
                          cellBorderColor: primaryColor,
                          monthCellBuilder: (context, details) {
                            return Material(
                              borderRadius: BorderRadius.circular(500),
                              color: Colors.transparent,
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  details.date.day.toString(),
                                  style: textFamily(
                                    color: primaryColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            );
                          },
                          monthViewSettings: const MonthViewSettings(
                            showTrailingAndLeadingDates: false,
                          ),
                          selectionDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: primaryColor, width: 2),
                          ),
                        )
                        // CalendarDatePicker(
                        //   firstDate: DateTime(1900),
                        //   lastDate: DateTime(2200),
                        //   initialDate: DateTime.now(),
                        //   onDateChanged: (date) => _date = date,
                        // )

                        // SfDateRangePicker(
                        //   controller: datePickerController,
                        //   selectionMode: DateRangePickerSelectionMode.single,
                        //   onSelectionChanged: (args){},
                        //   cellBuilder: (context, cellDetails) {
                        //     return Material(
                        //       borderRadius: BorderRadius.circular(500),
                        //       color: Colors.transparent,
                        //       child: Container(
                        //         alignment: Alignment.center,
                        //         child: Text(
                        //           cellDetails.date.day.toString(),
                        //           style: textFamily(
                        //             color: primaryColor,
                        //             fontSize: 17,
                        //             fontWeight: FontWeight.w400,
                        //           ),
                        //         ),
                        //       ),
                        //     );
                        //   },
                        // ),
                        ),
                    Container(
                      width: wXD(280, context, webSize: 90),
                      height: wXD(95, context, webSize: 30),
                      color: white,
                      padding:
                          EdgeInsets.only(top: wXD(10, context, webSize: 3)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => setState(() {
                                  calendarController.backward!();
                                  print("setState 2");
                                }),
                                child: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: wXD(15, context, webSize: 5),
                                  color: primaryColor,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  yearOverlay = getOverlay();
                                  Overlay.of(context)!.insert(yearOverlay!);
                                },
                                child: Text(
                                  month.substring(0, 1).toUpperCase() +
                                      month.substring(1, month.length) +
                                      " de " +
                                      calendarController.displayDate!.year
                                          .toString(),
                                  style: textFamily(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => setState(() {
                                  calendarController.forward!();
                                  print("setState 3");
                                }),
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: wXD(15, context, webSize: 5),
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: List.generate(
                              7,
                              (index) => Expanded(
                                child: Text(
                                  letterDays[index],
                                  textAlign: TextAlign.center,
                                  style: textFamily(
                                    fontSize: 17,
                                    color: gray,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: wXD(6, context, webSize: 2),
                      right: wXD(-12, context, webSize: 0),
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: widget.onCancel,
                            child: Text(
                              "Cancelar",
                              textAlign: TextAlign.center,
                              style: textFamily(
                                fontSize: 17,
                                color: primaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(width: wXD(10, context, webSize: 4)),
                          TextButton(
                            onPressed: () => widget.onConfirm(_date),
                            child: Text(
                              "Ok",
                              textAlign: TextAlign.center,
                              style: textFamily(
                                fontSize: 17,
                                color: primaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
