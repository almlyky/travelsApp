import 'package:flutter/material.dart';
import 'package:travelapp2/controller/homecontroller.dart';
import 'package:travelapp2/controller/travelercontroller.dart';

class TicketPrices extends StatelessWidget {
  const TicketPrices({
    super.key,
    required this.homeController,
    required this.travelercontroller,
  });

  final HomeController homeController;
  final Travelercontroller travelercontroller;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'أسعار التذاكر',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('إجمالي سعر التذاكر'),
                  Text(
                      '${(homeController.travelsModelBooking.travelPrice)! * (travelercontroller.selectedTravelerModels.length)} ريال سعودي'),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('خصم الكود'),
                  Text('0 ريال سعودي'),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('الإجمالي'),
                  Text(
                      '${(homeController.travelsModelBooking.travelPrice)! * (travelercontroller.selectedTravelerModels.length)} ريال سعودي'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}