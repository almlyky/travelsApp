import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:travelapp2/core/constant/linksapi.dart';
import 'package:travelapp2/core/constant/routes.dart';
import 'package:travelapp2/core/my-class/statusrequest.dart';
import 'package:travelapp2/core/my_function/handledata.dart';
import 'package:travelapp2/data/remote/controlData.dart';

class Verifycodecontroler extends GetxController {
  StatusRequest? statusRequest;
  Controldata controldata = Controldata();
  // String? otp;
  String? errorText;
  String errorotp = "";
  late TextEditingController otpcontroller;

  chechoTp(String action) async {
    statusRequest = StatusRequest.loading;
    print(otpcontroller.text);
    var response =
        await controldata.addData(chechotp, {"otp": otpcontroller.text});
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (action == "signup") {
        Get.offNamed(Routes.Login);
      } else if (action == "reset_password") {
        // Get.toNamed(Routes.res .resetpassword,arguments: {"otp":otp});
      }
    } else {
      // errorotp = ;
      Get.snackbar("اشعار", "الكود الذي ادخلته غير صحيح");
    }
    update();
  }

  @override
  void onInit() {
    otpcontroller = TextEditingController();
    // TODO: implement onInit
    super.onInit();
  }
}
