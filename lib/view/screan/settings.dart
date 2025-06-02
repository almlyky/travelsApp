// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelapp2/controller/auth/logincontoller.dart';
import 'package:travelapp2/controller/notificationscontroller.dart';
import 'package:travelapp2/controller/reservationcontroller.dart';
import 'package:travelapp2/controller/travelercontroller.dart';
import 'package:travelapp2/core/constant/appcolors.dart';
import 'package:travelapp2/core/constant/routes.dart';
import 'package:travelapp2/core/serveces.dart';
import 'package:travelapp2/view/widgets/homescrean/showBottomSheetCity.dart';
import 'package:travelapp2/view/widgets/travelersconfirm/customalert.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});
  @override
  Widget build(BuildContext context) {
    Logincontoller logincontoller = Get.put(Logincontoller());
    Notificationscontroller notificationscontroller = Get.find();
    // Reservationcontroller reservationcontroller =
    //     Get.put(Reservationcontroller());
    // Travelercontroller travelercontroller = Get.put(Travelercontroller());
    setteng controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolors.background,
        title: const Text("الإعدادت",
            style: TextStyle(
              color: Colors.white,
            )),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                CardSetting(
                    icon: Icons.settings, title: "تعديل الصفحة الشخصية"),
                CardSetting(icon: Icons.favorite, title: "المفضلة"),
                CardSetting(icon: Icons.directions_bus, title: "محطات الوصول"),
                CardSetting(
                    icon: Icons.help_outline, title: "شرح استخدام التطبيق"),
                CardSetting(
                  icon: Icons.support_agent,
                  title: "المساعدة والدعم",
                ),
                CardSetting(
                  icon: Icons.info_outline,
                  title: "عن التطبيق",
                  onTap: () {
                    notificationscontroller.getAccessToken();
                    // print(controller.shared.getString("token"));
                    // print(controller.shared.getString("userId"));
                  },
                ),
                CardSetting(
                  icon: Icons.logout,
                  title: "تسجيل الخروج",
                  onTap: () {
                    logincontoller.logUot();
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Column(
            children: [
              Text(
                "Version : 1.5.8",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}

class CardSetting extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function()? onTap;
  const CardSetting({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Icon(Icons.navigate_next_sharp, color: Colors.grey),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.black),
          SizedBox(width: 10),
          Text(title),
        ],
      ),
      onTap: onTap,
    );
  }
}
