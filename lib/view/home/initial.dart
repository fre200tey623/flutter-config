import 'package:flutter/material.dart';
import './home.dart';
import './business.dart';
import './school.dart';
import './menu.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> listOfWidgets = [
    const HomePage(),
    const BusinessWidget(),
    const SchoolWidget(),
  ];
  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.favorite_rounded,
    Icons.settings_rounded,
  ];
  List<Menu> menus = [
    Menu(Icons.home_rounded, Colors.blueAccent),
    Menu(Icons.favorite_rounded, Colors.redAccent),
    Menu(Icons.settings_rounded, Colors.greenAccent),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(child: listOfWidgets[currentIndex]),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        width: size.width,
        height: size.width * .155,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: ListView.builder(
          itemCount: menus.length,
          scrollDirection: Axis.horizontal,
          padding:
              EdgeInsets.symmetric(horizontal: size.width * menus.length * .06),
          itemBuilder: (context, index) => InkWell(
            onTap: () => _onItemTapped(index),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1500),
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
                    borderRadius: const BorderRadius.vertical(
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
            ),
          ),
        ),
      ),
    );
  }
}
