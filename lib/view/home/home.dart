import 'package:flutter/material.dart';

class CalendarDay {
  final String day;
  final String month;
  final String year;

  CalendarDay(this.day, this.month, this.year);
}

final currentDay = DateTime.now().day;
const daysLetters = ["S", "T", "Q", "Q", "S", "S", "D"];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var allDays = <CalendarDay>[];
  var selectedDayIndex = 0;

  @override
  void initState() {
    super.initState();

    var todayDay = DateTime.now().day;
    var todayMonth = DateTime.now().month;
    var todayYear = DateTime.now().year;

    setState(() {
      for (int i = 0; i < 2; i++) {
        var currentYear = DateTime.now().year + i;

        print(currentYear);

        for (var j = 0; j < 12; j++) {
          DateTime firstDayOfMonth = DateTime(currentYear, j + 1, 1);
          DateTime lastDayOfMonth =
              firstDayOfMonth.add(const Duration(days: -1));
          int daysInMonth = lastDayOfMonth.day;
          print(daysInMonth);

          for (var k = 0; k < daysInMonth; k++) {
            if (todayDay == k + 1 &&
                todayMonth == j + 1 &&
                todayYear == currentYear) {
              selectedDayIndex = allDays.length;
            }

            allDays.add(CalendarDay((k + 1).toString(), (j + 1).toString(),
                currentYear.toString()));
          }
        }
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedDayIndex = index;
    });
  }

  void _changeWeek(String direction) {
    setState(() {
      if (direction == "left") {
        selectedDayIndex--;
      } else {
        selectedDayIndex++;
      }
      print(allDays[selectedDayIndex].day);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
          top: size.width * 0.04,
          left: size.width * 0.04,
          right: size.width * 0.04),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width,
            padding: EdgeInsets.symmetric(vertical: size.width * 0.038),
            height: 136,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(235, 218, 218, .62),
                  blurRadius: 30,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(allDays[selectedDayIndex].month,
                    style: TextStyle(
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.w600)),
                Text(allDays[selectedDayIndex].year,
                    style: TextStyle(
                        fontSize: size.width * 0.025,
                        fontWeight: FontWeight.w600)),
                Padding(padding: EdgeInsets.only(top: size.height * 0.01)),
                Expanded(
                    child: Row(
                  children: [
                    SizedBox(
                        width: size.width * 0.1,
                        child: Center(
                          child: TapRegion(
                              behavior: HitTestBehavior.opaque,
                              onTapInside: (PointerDownEvent event) {
                                _changeWeek("left");
                              },
                              child: Icon(
                                Icons.chevron_left,
                                size: size.width * 0.075,
                              )),
                        )),
                    SizedBox(
                      width: size.width * 0.72,
                      height: size.height * 0.065,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 7,
                          itemBuilder: (context, index) => Container(
                                width: size.width * 0.72 / 7,
                                padding: EdgeInsets.only(
                                    top: size.width * 0.01,
                                    bottom: size.width * 0.016),
                                decoration: BoxDecoration(
                                  color: index == 3
                                      ? Colors.blueAccent
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: TapRegion(
                                    behavior: HitTestBehavior.opaque,
                                    onTapInside: (PointerDownEvent event) {
                                      _onItemTapped(index);
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          daysLetters[index],
                                          style: TextStyle(
                                              fontSize: size.width * 0.038,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          allDays[selectedDayIndex + index - 3]
                                              .day,
                                          style: TextStyle(
                                              fontSize: size.width * 0.038,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    )),
                              )),
                    ),
                    SizedBox(
                        width: size.width * 0.1,
                        child: Center(
                          child: TapRegion(
                              behavior: HitTestBehavior.opaque,
                              onTapInside: (PointerDownEvent event) {
                                _changeWeek("right");
                              },
                              child: Icon(
                                Icons.chevron_right,
                                size: size.width * 0.075,
                              )),
                        ))
                  ],
                ))
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: size.height * 0.025)),
          Expanded(
            child: Container(
              width: size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(235, 218, 218, .62),
                    blurRadius: 30,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const SingleChildScrollView(
                child: Text("asdf"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
