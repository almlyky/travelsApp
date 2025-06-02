import 'package:flutter/material.dart';
import 'package:travelapp2/controller/homecontroller.dart';
import 'package:travelapp2/core/constant/appcolors.dart';
import 'package:travelapp2/data/models/travelModel.dart';

class TravelCard extends StatelessWidget {
  final TravelsModel travelsModel;
  final HomeController homeController;
  const TravelCard(
      {super.key, required this.travelsModel, required this.homeController});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      "${travelsModel.comImage!}",
                    ),
                  ),
                ),
              ),
                // Image(
                //     height: 60,
                //     width: 60,
                //     fit: BoxFit.fill,
                //     image: NetworkImage(travelsModel.comImage!,)),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        softWrap: true,
                        ' باصات ${travelsModel.companyName} للنقل الدولي',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      Text(
                        travelsModel.date!,
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
                     Text(travelsModel.timeAtten!,
                        style: TextStyle(fontSize: 18, color: Colors.blue)),
                    const Text('من مدينة',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black)),
                    Text(travelsModel.travelFrom!,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.red)),
                  ],
                ),

                Icon(Icons.navigate_next_sharp,size: 40),
               
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('موعد الانطلاق',
                        style: TextStyle(fontSize: 14, color: Colors.black)),
                    Text(travelsModel.time!,
                        style: TextStyle(fontSize: 18, color: Colors.blue)),
                    Text('الى مدينة',
                        style: TextStyle(fontSize: 14, color: Colors.black)),
                    Text(travelsModel.travelTo!,
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('نوع النقل: اقتصادي',
                    style: TextStyle(fontSize: 14, color: Colors.red)),
                Text('متاح',
                    style: TextStyle(fontSize: 14, color: Colors.green)),
              ],
            ),
            const Divider(),
            // Price and Book Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${travelsModel.travelPrice} ريال سعودي',
                    style: TextStyle(fontSize: 18, color: Colors.blue)),
                ElevatedButton(
                  onPressed: () {
                    homeController.travelsModelBooking = travelsModel;
                    print(travelsModel.travelId);
                    homeController.goToReservation();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolors.background,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                  ),
                  child: Text(
                    'احجز رحلة',
                    style: TextStyle(color: Appcolors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
