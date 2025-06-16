// import 'package:eccommerce_new/core/constant/route.dart';
// import 'package:eccommerce_new/test/serveces.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:travelapp2/core/constant/routes.dart';
import 'package:travelapp2/core/serveces.dart';

class Authmiddleware extends GetMiddleware {
  setteng contrller = Get.find();
  @override
  RouteSettings? redirect(String? s) {
    if (contrller.shared.getString("rule") == "user") {
      return null;
      // return const RouteSettings(name: Routes.Reservation);
    }
    // if (contrller.shared.getString("rule") == "admin") {
    //   return const RouteSettings(name: Routes.AddTravel);
    // }
    return const RouteSettings(name: Routes.Login);
  }
}
