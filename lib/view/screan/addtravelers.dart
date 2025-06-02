import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:travelapp2/controller/homecontroller.dart';
import 'package:travelapp2/controller/travelercontroller.dart';
import 'package:travelapp2/core/constant/appcolors.dart';
import 'package:travelapp2/core/my_function/validinput.dart';
import 'package:travelapp2/view/widgets/addtraveler/customdropdown.dart';
// import 'package:travelapp2/view/widgets/addtraveler/CustomTextAddTraveler.dart';
import 'package:travelapp2/view/widgets/shared/customTextfield.dart';

class Addtravelers extends StatelessWidget {
  final String action;
  const Addtravelers({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    Travelercontroller travelercontroller = Get.find();
    HomeController homeController = Get.find();

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Appcolors.background,
          title: Text(action == "add" ? "اضافة مسافر جديد" : "تعديل مسافر",
              style: TextStyle(
                color: Colors.white,
              )),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notification_add,
                  color: Colors.white,
                ))
          ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
                key: travelercontroller.formAddtravel,
                child: Column(
                  children: [
                    CustomTextfild(
                      validate: (val) {
                        return validinput(val!, 0, 100);
                      },
                      hintext: 'الاسم بالكامل',
                      controller: travelercontroller.nameController,
                      obscureText: false,
                      prefixIcon: false,
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        homeController.selectDate(
                            1900, context, travelercontroller.dobController);
                      },
                      child: AbsorbPointer(
                        child: CustomTextfild(
                          validate: (val) {
                            return validinput(val!, 4, 10);
                          },
                          hintext: 'تاريخ الميلاد',
                          controller: travelercontroller.dobController,
                          obscureText: false,
                          prefixIcon: false,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    GetBuilder<Travelercontroller>(
                        builder: (controller) => Row(
                              children: [
                                Expanded(
                                    child: CustomDropDown(
                                        onChanged:travelercontroller.changeSelectedGender,
                                        hint: 'اختر الجنس',
                                        travelercontroller: travelercontroller,
                                        item: ['ذكر', 'أنثى'],
                                        value: travelercontroller
                                            .selectedGender!)),
                                SizedBox(width: 10),
                                Expanded(
                                  child: CustomDropDown(
                                      onChanged: travelercontroller.changeSelectedNationality,
                                      hint: 'اختر الجنسية',
                                      value: travelercontroller
                                          .selectedNationality!,
                                      item: ['يمني', 'سعودي'],
                                      travelercontroller: travelercontroller),
                                ),
                              ],
                            )),
                    SizedBox(height: 10),
                    CustomTextfild(
                      validate: (val) {
                        return validinput(val!, 9, 15);
                      },
                      hintext: 'رقم الجواز',
                      controller: travelercontroller.passportNumberController,
                      obscureText: false,
                      prefixIcon: false,
                    ),
                    SizedBox(height: 10),
                    CustomTextfild(
                      validate: (val) {
                        return validinput(val!, 9, 14);
                      },
                      hintext: 'رقم الجوال',
                      controller: travelercontroller.phoneNumberController,
                      obscureText: false,
                      prefixIcon: false,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            travelercontroller.choseimage();
                          },
                          icon: Icon(Icons.upload),
                          label: Text('ارفع الصورة'),
                        ),
                        Spacer(),
                        GetBuilder<Travelercontroller>(
                          builder: (controller) => Container(
                              child: action == "edit"
                                  ? Image.file(
                                      travelercontroller.passportImage!,
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.fill,
                                    )
                                  : travelercontroller.passportImage == null
                                      ? Text("صورة الجواز")
                                      : Image.file(
                                          travelercontroller.passportImage!,
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.fill)),
                        )
                      ],
                    ),
                  ],
                )),
            // Spacer(),
            action == "add"
                ? ElevatedButton(
                    onPressed: () {
                      travelercontroller.addTravelersData();
                      // Get.back();
                    },
                    child: Text('حفظ المسافر'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {
                      travelercontroller.uppdateTravelers(
                          travelercontroller.travelerModel!.id!);
                    },
                    child: Text('تعديل مسافر'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
