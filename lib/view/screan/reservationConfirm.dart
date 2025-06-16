import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelapp2/controller/homecontroller.dart';
import 'package:travelapp2/controller/reservationcontroller.dart';
import 'package:travelapp2/controller/travelercontroller.dart';
import 'package:travelapp2/core/constant/appcolors.dart';
import 'package:travelapp2/view/widgets/travelersconfirm/cardDiscountCode.dart';
import 'package:travelapp2/view/widgets/travelersconfirm/cardTravelDetails.dart';
import 'package:travelapp2/view/widgets/travelersconfirm/cardTravelersdata.dart';
import 'package:travelapp2/view/widgets/travelersconfirm/customalert.dart';
import 'package:travelapp2/view/widgets/travelersconfirm/paymentData.dart';
import 'package:travelapp2/view/widgets/travelersconfirm/paymentMethods.dart';
import 'package:travelapp2/view/widgets/travelersconfirm/ticketPrices.dart';

class Reservationconfirm extends StatelessWidget {
  const Reservationconfirm({super.key});

  @override
  Widget build(BuildContext context) {
    Travelercontroller travelercontroller = Get.find();
    HomeController homeController = Get.find();
    Reservationcontroller reservationcontroller =
        Get.put(Reservationcontroller());
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل الرحلة',style: TextStyle(color: Colors.white)),
        backgroundColor: Appcolors.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardTravelersData(travelercontroller: travelercontroller),
              SizedBox(
                height: 20,
              ),
              CardTravelDetails(homeController: homeController),
              CardDiscountCode(),
              SizedBox(height: 20),
              PaymentMethods(reservationcontroller: reservationcontroller),
              SizedBox(height: 20),
              PaymentData(),
              SizedBox(height: 20),
              TicketPrices(
                  homeController: homeController,
                  travelercontroller: travelercontroller),
              SizedBox(height: 20),
              CheckboxListTile(
                title: Text('أوافق على سياسات حجز الشركة'),
                value: true,
                onChanged: (value) {},
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  reservationcontroller.addBookingCompany(
                      homeController.travelsModelBooking.companyName!);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('تأكيد الحجز'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
