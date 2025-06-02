import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// import 'package:lottie/lottie.dart';
import 'package:travelapp2/core/my-class/statusrequest.dart';

class Handlingdataview extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widgets;
  const Handlingdataview(
      {super.key, required this.statusRequest, required this.widgets});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(child: Lottie.asset("assets/lottie/loading2.json"))
        : statusRequest == StatusRequest.offlineFailure
            ? Center(child: Lottie.asset("assets/lottie/offline.json"))
            : statusRequest == StatusRequest.failure ||
                    statusRequest == StatusRequest.serverFailure
                ? Center(
                    child: Lottie.asset("assets/lottie/server_failure.json"))
                : widgets;
  }
}
