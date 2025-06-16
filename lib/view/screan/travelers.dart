import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelapp2/controller/travelercontroller.dart';
import 'package:travelapp2/core/constant/appcolors.dart';
import 'package:travelapp2/core/my-class/HandlingDataView.dart';

class Travelers extends StatelessWidget {
  const Travelers({super.key});

  @override
  Widget build(BuildContext context) {
    Travelercontroller travelercontroller = Get.put(Travelercontroller());
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Appcolors.background,
            title: const Text("قائمة المسافرين",
                style: TextStyle(
                  color: Colors.white,
                )),
            actions: [
              IconButton(
                  onPressed: () {
                    travelercontroller.gotoAddTraveler();
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ))
            ]),
        body: GetBuilder<Travelercontroller>(
          builder: (controller) => Handlingdataview(
            statusRequest: travelercontroller.statusRequest!,
            widgets: ListView.builder(
              itemCount: travelercontroller.travelers.length,
              itemBuilder: (context, index) => ListTile(
                leading: Image.network(
                    travelercontroller.travelers[index].passportImagePath),
                // Image.file(
                //             File(travelercontroller.customer[index].passportImagePath),
                //             width: 50,
                //             height: 50,
                //             fit: BoxFit.cover,
                //           ),
                // : Icon(Icons.person),
                title: Text(travelercontroller.travelers[index].name),
                subtitle: Text(
                    'رقم الجواز: ${travelercontroller.travelers[index].passportNumber}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          travelercontroller.deleteTravelersData(
                              travelercontroller.travelers[index].id!);
                        }),
                    IconButton(
                        onPressed: () {
                          travelercontroller.travelerModel =
                              travelercontroller.travelers[index];
                          travelercontroller.goToEditTraveler();
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.green,
                        ))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
