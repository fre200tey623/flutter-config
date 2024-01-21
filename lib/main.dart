import 'package:flutter/material.dart';
import './home.dart';
import './business.dart';
import './school.dart';
import './menu.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp>{
  
  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> listOfWidgets = [
    HomeWidget(),
    BusinessWidget(),
    SchoolWidget(),
  ];
  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.favorite_rounded,
    Icons.settings_rounded,
  ];
    int currentIndex = 0;

    List<Menu> menus = [
    Menu(Icons.home_rounded, Colors.blueAccent),
    Menu(Icons.favorite_rounded, Colors.redAccent),
    Menu(Icons.settings_rounded, Colors.greenAccent),
    ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: listOfWidgets[currentIndex],
        bottomNavigationBar: Container(
        width: 5,
        margin: EdgeInsets.only(
          bottom: 30,
          left: 65,
          right: 55,
        ),
        height: size.width * .155,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: menus.length,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: size.width * .024),
          itemBuilder: (context, index) => InkWell(
            onTap: () => _onItemTapped(index),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 1500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  margin: EdgeInsets.only(
                    bottom: index == currentIndex ? 0 : size.width * .029,
                    right: size.width * .0422,
                    left: size.width * .0422,
                  ),
                  width: size.width * .128,
                  height: index == currentIndex ? size.width * .014 : 0,
                  decoration: BoxDecoration(
                    color: index == currentIndex
                        ? menus[index].color
                        : Colors.transparent,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10),
                    ),
                  ),
                ),
                Icon(
                  menus[index].iconData,
                  size: size.width * .076,
                  color: index == currentIndex
                      ? menus[index].color
                      : Colors.black38,
                ),
                SizedBox(height: size.width * .03),
              ],
            ),),),
          ),
      ),
    ); // Replace Container() with your desired widget
  }
}
