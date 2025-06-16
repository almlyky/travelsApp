import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelapp2/controller/homecontroller.dart';
import 'package:travelapp2/core/constant/appcolors.dart';
import 'package:travelapp2/core/my-class/HandlingDataView.dart';
import 'package:travelapp2/view/widgets/homescrean/travelcard.dart';

class Searchtravels extends StatelessWidget {
  const Searchtravels({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text("Search Page"),
        backgroundColor: Appcolors.background,
      ),
      body: ListView(
        children: [
          GetBuilder<HomeController>(
            builder: (context) => Handlingdataview(
              statusRequest: homeController.statusRequest,
              widgets: Container(
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: homeController.search.length,
                  itemBuilder: (context, index) {
                    homeController.travelsModel = homeController.search[index];
          
                    return TravelCard(
                      travelsModel: homeController.travelsModel,
                      homeController: homeController,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
