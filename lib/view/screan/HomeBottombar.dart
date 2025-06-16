import 'package:flutter/material.dart';
import 'package:travelapp2/controller/homecontroller.dart';
import 'package:get/get.dart';
import 'package:travelapp2/core/constant/appcolors.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
  HomeController homeController=Get.put(HomeController());
    return GetBuilder<HomeController>(
      builder: (context)=>
        Scaffold(
          body: homeController.widgetOption[homeController.selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: homeController.onItemTapped,
          currentIndex: homeController.selectedIndex,
          selectedItemColor: Appcolors.bottomAppbarSelected,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "الرئيسية"),
            BottomNavigationBarItem(icon: Icon(Icons.card_travel_outlined),label: "المسافرين"),
            BottomNavigationBarItem(icon: Icon(Icons.book),label: "حجوزاتي"),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: "الإعدادت")
          ]
          ),
      ),
    );
  }
}
