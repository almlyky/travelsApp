import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelapp2/controller/cardreservationController.dart';
import 'package:travelapp2/controller/reservationcontroller.dart';
import 'package:travelapp2/core/constant/appcolors.dart';
import 'package:travelapp2/core/my-class/HandlingDataView.dart';
import 'package:travelapp2/view/widgets/myReservations/CardReservation.dart';

class MyReservations extends StatelessWidget {
  const MyReservations({super.key});

  @override
  Widget build(BuildContext context) {
    Cardreservationcontroller cardreservationcontroller =
        Get.put(Cardreservationcontroller());
    Reservationcontroller reservationcontroller =
        Get.put(Reservationcontroller());
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Appcolors.background,
            title: const Text("قائمة الحجوزات",
                style: TextStyle(
                  color: Colors.white,
                ))),
        body: GetBuilder<Reservationcontroller>(
          builder: (controller) => Handlingdataview(
            statusRequest: reservationcontroller.statusRequestBookingApp,
            widgets: Container(
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: reservationcontroller.bookingApp.length,
                itemBuilder: (context, index) {
                  // if (cardreservationcontroller.isShowDeials.isEmpty) {
                    cardreservationcontroller.setShowDetails(
                        reservationcontroller.bookingApp[index].id!, true);
                  // }
                  // homeController.travelsModel = homeController.travels[index];
                  return CardBooking(
                    cardreservationcontroller: cardreservationcontroller,
                    bookingModel: reservationcontroller.bookingApp[index],
                    reservationcontroller: reservationcontroller,
                  );
                },
              ),
            ),
          ),
        ));
  }
}
