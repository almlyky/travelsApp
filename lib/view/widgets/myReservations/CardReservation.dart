import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelapp2/controller/cardreservationController.dart';
import 'package:travelapp2/controller/homecontroller.dart';
import 'package:travelapp2/controller/reservationcontroller.dart';
import 'package:travelapp2/core/constant/appcolors.dart';
import 'package:travelapp2/data/models/bookingModel.dart';
import 'package:travelapp2/data/models/travelModel.dart';

class CardBooking extends StatelessWidget {
  final BookingModel bookingModel;
  final Cardreservationcontroller cardreservationcontroller;
  final Reservationcontroller reservationcontroller;

  const CardBooking(
      {super.key,
      required this.reservationcontroller,
      required this.bookingModel,
      required this.cardreservationcontroller});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Cardreservationcontroller>(
      builder: (controller) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                      height: 60,
                      width: 60,
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/albaraka.png")),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          softWrap: true,
                          ' باصات ${bookingModel.companyName} للنقل الدولي',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                        Text(
                          bookingModel.date!,
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Time and City Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('موعد الحضور',
                          style: TextStyle(fontSize: 14, color: Colors.black)),
                      Text(bookingModel.timePresence!,
                          style: TextStyle(fontSize: 18, color: Colors.blue)),
                      const Text('من مدينة',
                          style: TextStyle(fontSize: 14, color: Colors.black)),
                      Text(bookingModel.travelFrom!,
                          style:
                              const TextStyle(fontSize: 16, color: Colors.red)),
                    ],
                  ),
                  Icon(Icons.navigate_next_sharp, size: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('موعد الانطلاق',
                          style: TextStyle(fontSize: 14, color: Colors.black)),
                      Text(bookingModel.time!,
                          style: TextStyle(fontSize: 18, color: Colors.blue)),
                      Text('الى مدينة',
                          style: TextStyle(fontSize: 14, color: Colors.black)),
                      Text(bookingModel.travelTo!,
                          style: TextStyle(fontSize: 16, color: Colors.red)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Waiting Time
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 5),
                ],
              ),
              const SizedBox(height: 10),
              // Trip Type and Availability
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('نوع النقل: اقتصادي',
                      style: Theme.of(context).textTheme.headlineMedium),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text(
                        bookingModel.status!,
                        style: TextStyle(color: Appcolors.forgroundbutton),
                      ),
                    ),
                    color: Appcolors.background,
                  ),
                  // Text(bookingModel.status!,style: TextStyle(color: const Color.fromARGB(255, 200, 151, 4)),),
                  Text('متاح',
                      style: TextStyle(fontSize: 14, color: Colors.green)),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        controller.changeShowDetails(bookingModel.id!);
                      },
                      child: Text(
                        controller.isShowDeials[bookingModel.id] == true
                            ? "التفاصيل"
                            : "اخفاء",
                        style: TextStyle(color: Colors.blue),
                      )),
                  // const Text('سعر الرحلة',
                  // style: TextStyle(fontSize: 14, color: Colors.grey)),
                  // Text('${bookingModel.totalAmount} ريال سعودي',
                  //     style: TextStyle(fontSize: 18, color: Colors.blue)),
                  ElevatedButton(
                    onPressed: () {
                      // reservationcontroller.travelsModelBooking = travelsModel;
                      // print(travelsModel.travelId);
                      // homeController.goToReservation();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolors.background,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                    ),
                    child: Text(
                      'إلغاء الرحلة',
                    ),
                  ),
                ],
              ),
              if (controller.isShowDeials[bookingModel.id] == false)
                Padding(
                  padding: const EdgeInsets.all(20),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("كود الحجز"),
                          Text(bookingModel.bookingCode!),
                        ],
                      ),
                      Divider(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("طريقة الدفع"),
                          Text(bookingModel.paymentStatus!),
                        ],
                      ),
                      Divider(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("سعر التذكرة"),
                          Text("${bookingModel.totalAmount}"),
                        ],
                      ),
                      Divider(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("كود الحجز"),
                          Text(bookingModel.bookingCode!),
                        ],
                      ),
                      SizedBox(height: 40),
                      Text("ملاحظات تأكيد الحجز",style: Theme.of(context).textTheme.headlineMedium,),
                      SizedBox(height: 20),
                      Text("لتأكيد الحجز يرجى ارسال معلومات الدفع على حساب الادارة عبر الواتس أب"),
                      SizedBox(height: 20),
                      Container(alignment: Alignment.topLeft, child: IconButton( onPressed: (){}, icon:Icon(Icons.call,color: Colors.green,)))
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
