import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelapp2/controller/homecontroller.dart';
import 'package:travelapp2/controller/reservationcontroller.dart';
import 'package:travelapp2/controller/travelercontroller.dart';
import 'package:travelapp2/core/constant/appcolors.dart';
import 'package:travelapp2/core/constant/routes.dart';

class Reservation extends StatelessWidget {
  const Reservation({super.key});

  @override
  Widget build(BuildContext context) {
    Travelercontroller travelercontroller = Get.put(Travelercontroller());
    Reservationcontroller reservationcontroller =
        Get.put(Reservationcontroller());
    HomeController homeController = Get.find();

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Appcolors.background,
            title: const Text("تحديد مسافر",
                style: TextStyle(
                  color: Colors.white,
                )),
            actions: [
              IconButton(
                  onPressed: () {
                    // travelercontroller.gotoAddTraveler();
                  },
                  icon: const Icon(
                    Icons.notification_add,
                    color: Colors.white,
                  ))
            ]),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("حجز الرحلة لمسافرين تابعين"),
                      ElevatedButton.icon(
                        onPressed: () {
                          travelercontroller.gotoAddTraveler();
                        },
                        icon: Icon(Icons.add),
                        label: Text("مسافر جديد"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                      )
                    ],
                  ),
                  GetBuilder<Travelercontroller>(
                    builder: (controller) => ListView.builder(
                        shrinkWrap: true,
                        itemCount: travelercontroller.travelers.length,
                        itemBuilder: (context, index) {
                          final customer = travelercontroller.travelers[index];
                          final isSelected = travelercontroller
                              .selectedTravelerIds
                              .contains(customer.id);
                          return ListTile(
                            leading: Checkbox(
                                value: isSelected,
                                onChanged: (Value) {
                                  travelercontroller.toggleSelection(
                                      customer.id!, customer);
                                  // print(travelercontroller.selectedTravelerIds);
                                }),
                            title: Text(customer.name),
                            subtitle:
                                Text('رقم الجواز: ${customer.passportNumber}'),
                          );
                        }),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.offNamed(Routes.Home);
                    },
                    child: Text("إلغاء"),
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red,
                        backgroundColor: Color(0XFFFEF7FF),
                        padding:
                            EdgeInsets.symmetric(horizontal: 34, vertical: 12)),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        reservationcontroller.goToReservationConfirm();
                        // for (int i = 0;
                        //     i < travelercontroller.selectedTravelerIds.length;
                        //     i++) {
                        //   homeController.bookingTrip(
                        //       travelercontroller.selectedTravelerIds[i],
                        //       homeController.travelsModelBooking.companyName!);
                        // }
                      },
                      child: Text("التالي"),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))))
                ],
              )
            ],
          ),
        ));
  }
}
