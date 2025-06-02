import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelapp2/controller/homecontroller.dart';
  HomeController homeController = Get.find();

void showCityPicker(TextEditingController controller,BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            const ListTile(
              title: Text('اختر المدينة',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: homeController.city.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(homeController.city[index]),
                    onTap: () {
                      homeController.onTap(index, controller);
                      Navigator.pop(
                          context); // لإغلاق القائمة بعد اختيار المدينة
                    },
                  );
                },
              ),
            ),
            ListTile(
              title: const Text('إغلاق', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }