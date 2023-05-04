import 'package:first_app/feature/colors.dart';
import 'package:first_app/feature/pages/dashboard.dart';
import 'package:first_app/models/events.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();
  CalendarFormat format = CalendarFormat.month;
  void _onDaySelected(DateTime day, DateTime focusDay) {
    setState(() {
      today = day;
    });
  }

  Map<DateTime, List<Event>> selectedEvents = {};
  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventFromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: topColor,
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Row(children: [
                  Container(
                    color: bottomColor,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                  Container(
                    color: topColor,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                ]),
                Column(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2,
                          decoration: const BoxDecoration(
                              color: topColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 15),
                            child: Column(children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Dashboard()),
                                          (route) => false);
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back_ios,
                                      color: bottomColor,
                                      size: 25,
                                    ),
                                  ),
                                  const Text(
                                    "Calendar",
                                    style: TextStyle(
                                        color: bottomColor,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ]),
                          ),
                        )),
                    Expanded(
                        flex: 6,
                        child: Container(
                            height: MediaQuery.of(context).size.height / 2,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                color: bottomColor,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30))),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 18.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TableCalendar(
                                        eventLoader: _getEventFromDay,
                                        locale: "en_US",
                                        calendarFormat: format,
                                        rowHeight: 45,
                                        availableGestures:
                                            AvailableGestures.all,
                                        headerStyle: HeaderStyle(
                                          titleCentered: true,
                                          formatButtonVisible: false,
                                        ),
                                        onFormatChanged:
                                            (CalendarFormat _format) {
                                          setState(() {
                                            format = _format;
                                          });
                                        },
                                        formatAnimationCurve:
                                            Curves.fastOutSlowIn,
                                        focusedDay: today,
                                        calendarStyle: CalendarStyle(
                                            isTodayHighlighted: true,
                                            selectedDecoration: BoxDecoration(
                                                color: topColor,
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            defaultDecoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            selectedTextStyle:
                                                TextStyle(color: bottomColor),
                                            weekendDecoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            todayDecoration: BoxDecoration(
                                                color: Colors.purpleAccent,
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        firstDay: DateTime.utc(2010, 10, 16),
                                        lastDay: DateTime.utc(2030, 3, 16),
                                        onDaySelected: _onDaySelected,
                                        selectedDayPredicate: (day) =>
                                            isSameDay(day, today)),
                                    ..._getEventFromDay(DateTime.now())
                                        .map((Event event) => ListTile(
                                              title: Text(event.title),
                                            ))
                                  ],
                                ))))
                  ],
                )
              ],
            ),
          ),
        ),
      )),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () => showDialog(
      //       context: context,
      //       builder: (context) => AlertDialog(
      //             title: Text("Add Event"),
      //             content: TextFormField(
      //               controller: _eventController,
      //             ),
      //             actions: [
      //               TextButton(
      //                   onPressed: () {
      //                     Navigator.pop(context);
      //                   },
      //                   child: Text("Cancel")),
      //               TextButton(
      //                   onPressed: () {
      //                     if (_eventController.text.isEmpty) {
                            
      //                     } else {
      //                       if (selectedEvents[DateTime.now()] != null) {
      //                         selectedEvents[DateTime.now()]
      //                             ?.add(Event(title: _eventController.text));
      //                       } else {
      //                         selectedEvents[DateTime.now()] = [
      //                           Event(title: _eventController.text)
      //                         ];
      //                       }
      //                     }
      //                     Navigator.pop(context);
      //                     _eventController.clear();
      //                     setState(() {
                            
      //                     });
      //                     return;
      //                   },
      //                   child: Text("Ok")),
      //             ],
      //           )),
      //   label: Text("Add Event"),
      //   icon: Icon(Icons.send),
      // ),
    
    );
  }
}
