import 'package:flutter/material.dart';
import 'package:travelapp2/controller/travelercontroller.dart';

class CardTravelersData extends StatelessWidget {
  const CardTravelersData({
    super.key,
    required this.travelercontroller,
  });

  final Travelercontroller travelercontroller;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            Text(
              "بيانات المسافرين",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "الإسم",
                      style: TextStyle(color: Colors.red),
                    ),
                    Text("رقم الجواز",
                        style: TextStyle(color: Colors.red))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: travelercontroller
                      .selectedTravelerModels.length,
                  itemBuilder: (context, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(travelercontroller
                          .selectedTravelerModels[index].name),
                      Text(
                          "${travelercontroller.selectedTravelerModels[index].passportNumber}"),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    )
                );
  }
}
