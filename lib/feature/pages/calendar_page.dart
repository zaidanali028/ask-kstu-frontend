import 'package:first_app/feature/colors.dart';
import 'package:first_app/feature/pages/dashboard.dart';
import 'package:first_app/feature/pages/notice_board_shimmer.dart';
import 'package:first_app/models/announcement.dart';
import 'package:first_app/models/constant.dart';
import 'package:first_app/models/events.dart';
import 'package:first_app/services/notice_board.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    final noticeProvider =
        Provider.of<NoticeBoardProvider>(context, listen: false);
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
                        // flex: 1,
                        child: Container(
                      height: 20,
                      decoration: const BoxDecoration(
                          color: topColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 10),
                        child: Column(children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => Dashboard()),
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
                        flex: 10,
                        child: Container(
                            height: MediaQuery.of(context).size.height / 2,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                color: bottomColor,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30))),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
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
                                    // ..._getEventFromDay(DateTime.now())
                                    //     .map((Event event) => ListTile(
                                    //           title: Text(event.title),
                                    //         )),
                                    // SizedBox(height: 20,),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                                  2 -
                                              18,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: topColor,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10))),
                                      child: FutureBuilder<List<Announcement>>(
                                        future: noticeProvider.fetchNotice(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0),
                                                child: Container(
                                                    height: 243,
                                                    child: ListView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        children: [
                                                          NoticeBoardShimmer(),
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          NoticeBoardShimmer(),
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          NoticeBoardShimmer(),
                                                        ])));
                                          } else if (snapshot.hasError) {
                                            return Text('${snapshot.error}');
                                          } else {
                                            final noticeboard = snapshot.data!;
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Container(
                                                height: 243,
                                                child: ListView.builder(
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  itemCount: noticeboard.length,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 12.0),
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: 120,
                                                        decoration: BoxDecoration(
                                                            color: bottomColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 150,
                                                              height: double
                                                                  .infinity,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius: BorderRadius.only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10)),
                                                                image: noticeboard[index]
                                                                            .featured_image !=
                                                                        null
                                                                    ? DecorationImage(

                                                                image: NetworkImage(
                                                                      "${announcement_imgUri}${noticeboard[index].featured_image}"),
                                                                fit: BoxFit
                                                                   .cover)

                                                                    : DecorationImage(
                                                                        image: NetworkImage(
                                                                            "https://cdn-icons-png.flaticon.com/512/3135/3135715.png"),
                                                                        fit: BoxFit
                                                                            .fill),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 194,
                                                              height: double
                                                                  .infinity,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.only(
                                                                      topRight:
                                                                          Radius.circular(
                                                                              10),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              10))),
                                                              child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 8.0,
                                                                      right:
                                                                          8.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        "${noticeboard[index].title}",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                        maxLines:
                                                                            3,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                      Spacer(),
                                                                      Container(
                                                                        width:
                                                                            150,
                                                                        height:
                                                                            20,
                                                                        child:
                                                                            Text(

                                                                          "${DateTime.parse(noticeboard[index].created_at)}",

                                                                          style: TextStyle(
                                                                              color: Colors.grey.shade500,
                                                                              fontSize: 15),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.fade,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    )
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
