import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelapp2/controller/notificationscontroller.dart';
import 'package:travelapp2/core/constant/appcolors.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    Notificationscontroller notificationscontroller =
        Get.put(Notificationscontroller());
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Appcolors.background,
          title: const Text("الإشعارات",
              style: TextStyle(
                color: Colors.white,
              )),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notification_add,
                  color: Colors.white,
                ))
          ]),
      body: GetBuilder<Notificationscontroller>(
        builder: (controller) => 
            ListView.builder(
            itemCount: notificationscontroller.notifications.length,
            itemBuilder: (context, index) {
              return
              // Map<String,dynamic> notification=notificationscontroller.notifications[index];
              Card(
                child: ListTile(
                  subtitle: Text(notificationscontroller.notifications[index]['body']),
                    title: Text(
                        notificationscontroller.notifications[index]['title'])),
              );
            }),
      ),
    );
  }
}
