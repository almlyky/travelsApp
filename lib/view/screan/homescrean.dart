import 'package:flutter/material.dart';
import 'package:travelapp2/controller/homecontroller.dart';
import 'package:travelapp2/core/constant/appcolors.dart';
import 'package:travelapp2/core/constant/routes.dart';
import 'package:travelapp2/core/my-class/HandlingDataView.dart';
import 'package:travelapp2/view/widgets/homescrean/customtextforsearch.dart';
import 'package:travelapp2/view/widgets/homescrean/showBottomSheetCity.dart';
import 'package:travelapp2/view/widgets/homescrean/travelcard.dart';
import 'package:get/get.dart';

class Homescrean extends StatelessWidget {
  Homescrean({super.key});
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Appcolors.background,
          title: const Text("الصفحه الرئيسيه",
              style: TextStyle(
                color: Colors.white,
              )),
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(Routes.Notification);
                },
                icon: const Icon(
                  Icons.notification_add,
                  color: Colors.white,
                ))
          ]),
      body: GetBuilder<HomeController>(
          builder: (controller) => ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    color: Appcolors.background,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            showCityPicker(
                                homeController.trFromController, context);
                          },
                          child: AbsorbPointer(
                            child: CustomTextField(
                              textInputControl: homeController.trFromController,
                              hint: "من مدينه",
                              icon: const Icon(Icons.location_on),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            showCityPicker(
                                homeController.trToController, context);
                          },
                          child: AbsorbPointer(
                            child: CustomTextField(
                              textInputControl: homeController.trToController,
                              hint: "الى مدينه",
                              icon: const Icon(Icons.location_on),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            homeController.selectDate(
                                2000, context, homeController.dateController);
                          },
                          child: AbsorbPointer(
                            child: CustomTextField(
                                textInputControl: homeController.dateController,
                                icon: const Icon(Icons.calendar_month),
                                hint: 'تاريخ الرحلة'),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Checkbox(
                              value: homeController.checkedVip,
                              onChanged: (val) {
                                homeController.changeSelect("vip", val!);
                              },
                              checkColor: Appcolors.white,
                            ),
                            Text(
                              "باصات VIP",
                              style: TextStyle(color: Appcolors.white),
                            ),
                            Checkbox(
                              value: homeController.checkedEconomic,
                              onChanged: (val) {
                                homeController.changeSelect("eco", val!);
                              },
                            ),
                            Text("باصات اقتصادي",
                                style: TextStyle(color: Appcolors.white)),
                          ],
                        ),
                        MaterialButton(
                          onPressed: () {
                            homeController.searchTravels(
                                homeController.trFromController.text,
                                homeController.trToController.text,
                                homeController.dateController.text);
                            homeController.goToSearchTravel();
                          },
                          child: Container(
                              padding: const EdgeInsets.all(15),
                              color: const Color.fromRGBO(255, 255, 255, 0.338),
                              child: Center(
                                  child: Text(
                                "بحث",
                                style: TextStyle(color: Appcolors.white),
                              ))),
                        ),
                      ],
                    ),
                  ),
                  Handlingdataview(
                    statusRequest: homeController.statusRequest,
                    widgets: Container(
                      padding: EdgeInsets.all(10),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: homeController.travels.length,
                        itemBuilder: (context, index) {
                          homeController.travelsModel =
                              homeController.travels[index];
                          return TravelCard(
                            travelsModel: homeController.travelsModel,
                            homeController: homeController,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              )),
    );
  }
}
