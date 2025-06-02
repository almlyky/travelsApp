import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:travelapp2/core/constant/linksapi.dart';
import 'package:travelapp2/core/constant/routes.dart';
import 'package:travelapp2/core/my-class/statusrequest.dart';
import 'package:travelapp2/core/my_function/handledata.dart';
import 'package:travelapp2/core/serveces.dart';
import 'package:travelapp2/data/models/travelerModel.dart';
import 'package:travelapp2/data/remote/controlData.dart';
import 'package:http/http.dart' as http;

class Travelercontroller extends GetxController {
  GlobalKey<FormState> formAddtravel = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController passportNumberController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  TravelerModel? travelerModel;
  File? passportImage;
  String? selectedGender="ذكر";
  String? selectedNationality="يمني";
  List<TravelerModel> travelers = [];
  List<int> selectedTravelerIds = [];
  List<TravelerModel> selectedTravelerModels = [];
  setteng controllerSetting = Get.find();

  StatusRequest? statusRequest;
  StatusRequest? statusRequestEdit;
  StatusRequest? statusRequestDelete;

  Controldata controldata = Controldata();

  void toggleSelection(int id, TravelerModel TravelerModel) {
    if (selectedTravelerIds.contains(id) ||
        selectedTravelerModels.contains(TravelerModel)) {
      selectedTravelerIds.remove(id);
      selectedTravelerModels.remove(TravelerModel);
      // إزالة الـ ID إذا كان موجودًا
    } else {
      selectedTravelerIds.add(id);
      selectedTravelerModels.add(TravelerModel);
      // إضافة الـ ID إذا لم يكن موجودًا
    }
    update(); // تحديث واجهة المستخدم
  }

  gotoAddTraveler() {
    Get.toNamed(Routes.AddTraveler);
  }
// void changeSelectedGender(String? value){
//  selectedGender = value;
//     update();
// }
  changeSelectedGender(String? value) {
    selectedGender = value;
    update();
  }

   changeSelectedNationality(String? value) {
    selectedNationality = value;
    update();
  }

  uppdateDataTraveler() async {
    nameController.text = travelerModel!.name;
    dobController.text = travelerModel!.dob;
    // changeSelectedGender(travelerModel!.gender!.trim());
    // changeSelectedNationality(travelerModel!.nationality.trim());
    passportNumberController.text = "${travelerModel!.passportNumber}";
    phoneNumberController.text = "${travelerModel!.phoneNumber}";
    Uri uri = Uri.parse(travelerModel!.passportImagePath);
    String fileName = uri.pathSegments.last;
    var img = await http.get(uri);
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    final file = File('$tempPath/$fileName');
    await file.writeAsBytes(img.bodyBytes);
    passportImage = file;
  }

  goToEditTraveler() async {
    await uppdateDataTraveler();
    Get.toNamed(Routes.EditTraveleler);
  }

  uppdateTravelers(int id) async {
    final formdata = formAddtravel.currentState;
    if (formdata!.validate()) {
      if (passportImage == null) {
        Get.rawSnackbar(
            title: "اشعار",
            messageText: Text("لا يمكن ترك الصورة فارغة",
                style: const TextStyle(
                  color: Colors.white,
                )));
      } else {
        Map<String, dynamic> data = {
          'name': nameController.text,
          'dob': dobController.text,
          'gender': selectedGender,
          'nationality': selectedNationality,
          'passport_number': passportNumberController.text,
          'phone_number': phoneNumberController.text,
          // 'passportImagePath': passportImage
        };
        statusRequestEdit = StatusRequest.loading;
        String api =
            "${apiAppTraveler}${controllerSetting.shared.getInt("userId")}/";
        var response = await controldata.uppdateDatawithFile(
            "$api$id/", data, passportImage!);
        statusRequestEdit = handlingData(response);
        print(statusRequestEdit);
        if (statusRequestEdit == StatusRequest.success) {
          TravelerModel traveler = TravelerModel.fromJson(response);
          travelers = travelers.map((element) {
            return element.id == id ? traveler : element;
          }).toList();
          Get.rawSnackbar(
              title: "اشعار",
              messageText: Text("تم تعديل البيانات",
                  style: const TextStyle(
                    color: Colors.white,
                  )));
        }
        update();
        // Get.back();
      }
    }
  }

  Future<void> choseimage() async {
    final ImagePicker picker = ImagePicker();
    final pickerfile = await picker.pickImage(source: ImageSource.gallery);
    if (pickerfile != null) {
      passportImage = File(pickerfile.path);
      update();
    } else {
      print("not file ");
    }
  }

  addTravelersData() async {
    final formdata = formAddtravel.currentState;
    if (formdata!.validate()) {
      if (passportImage == null) {
        Get.rawSnackbar(
            title: "اشعار",
            messageText: Text("لا يمكن ترك الصورة فارغة",
                style: const TextStyle(
                  color: Colors.white,
                )));
      } else {
        Map<String, dynamic> data = {
          'name': nameController.text,
          'dob': dobController.text,
          'gender': selectedGender,
          'nationality': selectedNationality,
          'passport_number': passportNumberController.text,
          'phone_number': phoneNumberController.text,
          // 'passportImagePath': passportImage
        };
        // print(data);
        statusRequest = StatusRequest.loading;
        String api =
            "${apiAppTraveler}${controllerSetting.shared.getInt("userId")}/";
        var response =
            await controldata.addDatawithFile(api, data, passportImage!);
        statusRequest = handlingData(response);

        if (statusRequest == StatusRequest.success &&
            response['message'] == "success") {
          TravelerModel traveler = TravelerModel.fromJson(response['data']);
          travelers.add(traveler);
          Get.rawSnackbar(
            title: "اشعار",
            messageText: Text("تم ادخال البيانات",
                style: const TextStyle(
                  color: Colors.white,
                )),
          );
        } else if (response['message'] == "already_exist") {
          Get.rawSnackbar(
              title: "اشعار",
              messageText: Text("البيانات موجودة مسبقا",
                  style: const TextStyle(
                    color: Colors.white,
                  )));
        }
        update();
      }
    }
  }

  getTravelersData() async {
    try {
      statusRequest = StatusRequest.loading;
      int user_id = controllerSetting.shared.getInt("userId")!;
      String api = "${apiAppTraveler}${user_id}/";
      var response = await controldata.getData(api);
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        List<TravelerModel> customers = response.map<TravelerModel>((element) {
          return TravelerModel.fromJson(element);
        }).toList();
        travelers.addAll(customers);
      }
      update();
    } catch (e) {
      print(e);
    }
  }

  deleteTravelersData(int id) async {
    statusRequestDelete = StatusRequest.loading;
    String api =
        "${apiAppTraveler}${controllerSetting.shared.getInt("userId")}/$id/";
    var response = await controldata.deleteData(api);
    statusRequestDelete = handlingData(response);

    if (statusRequestDelete == StatusRequest.success) {
      travelers.removeWhere((element) => element.id == id);
      Get.rawSnackbar(
        title: "اشعار",
        messageText: Text("تم حذف البيانات",
            style: const TextStyle(
              color: Colors.white,
            )),
      );
    } else if (statusRequestDelete == StatusRequest.failure) {
      Get.rawSnackbar(
          title: "اشعار",
          messageText: Text("المسافر مرتبط مرتبط بحجز لا  يمكن حذفة",
              style: const TextStyle(
                color: Colors.white,
              )));
    }
    update();
  }

  @override
  void onInit() {
    getTravelersData();
    super.onInit();
  }

  
}

