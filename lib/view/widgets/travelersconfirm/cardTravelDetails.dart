import 'package:flutter/material.dart';
import 'package:travelapp2/controller/homecontroller.dart';

class CardTravelDetails extends StatelessWidget {
  const CardTravelDetails({
    super.key,
    required this.homeController,
  });

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              Text(
                "تفاصيل الرحلة",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("اسم الشركه"),
                  Text(
                      homeController.travelsModelBooking.companyName!)
                ],
              ),
              Divider(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("تأريخ الرحلة"),
                  Text(homeController.travelsModelBooking.date!)
                ],
              ),
              Divider(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("من منطقة"),
                  Text(homeController.travelsModelBooking.travelFrom!)
                ],
              ),
              Divider(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("الى منطقة"),
                  Text(homeController.travelsModelBooking.travelTo!)
                ],
              ),
              Divider(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("موعد الحضور"),
                  Text(homeController.travelsModelBooking.timeAtten!)
                ],
              ),
              Divider(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("موعد الإنطلاق"),
                  Text(homeController.travelsModelBooking.time!)
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}

