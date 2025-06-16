import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:travelapp2/core/constant/linksapi.dart';
import 'package:travelapp2/core/constant/routes.dart';
import 'package:travelapp2/core/my-class/statusrequest.dart';
import 'package:travelapp2/core/my_function/handledata.dart';
import 'package:travelapp2/data/remote/controlData.dart';

class Signupcontroller extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  StatusRequest? statusRequest;
  Controldata controldata = Controldata();

  goToLogin() {
    Get.offNamed(Routes.Login);
  }

  goToverifycode() {
    Get.toNamed(Routes.VerifyCode);
  }

  signUp() async {
    FormState? formdata = formstate.currentState;
    if (formdata!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      Map<String, dynamic> data = {
        "username": username.text,
        "email": email.text,
        "password": password.text,
        "confirmPassword": confirmpassword.text,
      };
      var response = await controldata.addData(apiAppSignUp, data);
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        goToverifycode();
      }
      update();
    }
  }
}
