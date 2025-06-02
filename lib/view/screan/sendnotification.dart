import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelapp2/controller/notificationscontroller.dart';
import 'package:travelapp2/core/my_function/validinput.dart';
import 'package:travelapp2/view/widgets/shared/customTextfield.dart';

class Sendnotification extends StatelessWidget {
  const Sendnotification({super.key});

  @override
  Widget build(BuildContext context) {
    Notificationscontroller notificationscontroller =
        Get.put(Notificationscontroller());
    return Scaffold(
      appBar: AppBar(
        title: Text("إرسال إشعار"),
      ),
      body: ListView(
        children: [
          CustomTextfild(
              controller: notificationscontroller.sendNotificationcontroller,
              hintext: 'ادخل الإشعار',
              validate: (val) {
                return validinput(val!, 0, 1000);
              },
              obscureText: false,
              prefixIcon: false),
          ElevatedButton(
              onPressed: () {
                notificationscontroller.sendnotification(
                    "hi", notificationscontroller.sendNotificationcontroller.text, "TravelApp");
              },
              child: Text("إرسال"))
        ],
      ),
    );
  }
}
