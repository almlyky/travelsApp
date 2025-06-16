import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelapp2/controller/reservationcontroller.dart';
import 'package:travelapp2/core/constant/appcolors.dart';
import 'package:travelapp2/core/constant/routes.dart';

// class CustomAlert extends StatelessWidget {
//   final Reservationcontroller reservationcontroller;

//   const CustomAlert({super.key, required this.reservationcontroller});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Stack(
//         children: [

//           AlertDialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16.0),
//             ),

//               content:
//                Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     SizedBox(height: 16.0),
//                     Text(
//                       'شكراً لك!',
//                       style: TextStyle(
//                         fontSize: 22.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 8.0),
//                     Text(
//                       'تم تأكيد حجزك .. وسيتم التواصل معك',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 16.0),
//                     ),
//                     SizedBox(height: 16.0),
//                     Container(
//                       // decoration: BoxDecoration(
//                       //   border: Border.all(color: Colors.yellow[700]!),
//                       //   borderRadius: BorderRadius.circular(8.0),
//                       // ),
//                       padding: EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('رقم الحجز:'),
//                               Text('8Q36ZPWZY9'),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 8.0),
//                     Text(
//                       'المبلغ الإجمالي: 35,000.00 ريال يمني',
//                       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 16.0),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                             Get.offNamed(Routes.MyReservation);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.grey[200],
//                           ),
//                           child: Text('حجوزاتي', style: TextStyle(color: Colors.black)),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                             Get.offNamed(Routes.Home);
//                           },
//                           style: ElevatedButton.styleFrom(
//                               // backgroundColor: Colors.yellow[700],
//                               ),
//                           child: Text('الرئيسية'),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),

//               ),
//               Positioned(
//                       top: 210,
//                       right: 160,
//                       child: CircleAvatar(
//                         radius: 30,
//                         backgroundColor: Colors.blue,
//                         child: Icon(
//                           Icons.check,
//                           size: 40,
//                           color: Colors.white,
//                         ),
//                       )),

//         ],
//       ),
//     );
//   }
// }

void showBookingConfirmationDialog() {
  Get.defaultDialog(
    title: '',
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 16.0),
        Text(
          'شكراً لك!',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'تم تأكيد حجزك .. وسيتم التواصل معك',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(height: 16.0),
        Container(
          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.yellow[700]!),
          //   borderRadius: BorderRadius.circular(8.0),
          // ),
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('رقم الحجز:'),
                  Text('8Q36ZPWZY9'),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'المبلغ الإجمالي: 35,000.00 ريال يمني',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.back();
                Get.offNamed(Routes.MyReservation);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
              ),
              child: Text('حجوزاتي', style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
                Get.offNamed(Routes.Home);
              },
              style: ElevatedButton.styleFrom(
                  
                  ),
              child: Text('الرئيسية'),
            ),
          ],
        ),
      ],
    ),
    radius: 12,
  );
}
