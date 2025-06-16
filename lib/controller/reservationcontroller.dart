import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelapp2/controller/homecontroller.dart';
import 'package:travelapp2/controller/travelercontroller.dart';
import 'package:travelapp2/core/constant/linksapi.dart';
import 'package:travelapp2/core/constant/routes.dart';
import 'package:travelapp2/core/my-class/statusrequest.dart';
import 'package:travelapp2/core/my_function/handledata.dart';
import 'package:travelapp2/core/serveces.dart';
import 'package:travelapp2/data/models/bookingModel.dart';
import 'package:travelapp2/data/models/travelModel.dart';
import 'package:travelapp2/data/models/travelerModel.dart';
import 'package:travelapp2/data/remote/controlData.dart';
import 'package:travelapp2/view/widgets/travelersconfirm/customalert.dart';

class Reservationcontroller extends GetxController {
  StatusRequest? statusRequestTraveler;
  StatusRequest? statusRequestBooking;
  StatusRequest statusRequestBookingApp = StatusRequest.loading;
  HomeController homeController = Get.find();
  Travelercontroller travelercontroller = Get.put(Travelercontroller());
  Controldata controldata = Controldata();
  setteng controllerSitting = Get.find();
  List<BookingModel> bookingApp = [];
  String? code;

  goToReservationConfirm() {
    if (travelercontroller.selectedTravelerModels.length > 0)
      Get.toNamed(Routes.ReservationConfirm);
    else
      Get.rawSnackbar(
          title: "إشعار",
          messageText: Text("قم بإختيار مسافر",
              style: const TextStyle(
                color: Colors.white,
              )));
  }

  String? paymentMethod = "cash";
  onChangeRadio(String? value) {
    paymentMethod = value;
    update();
  }

  addBookingCompany(String name) async {
    statusRequestTraveler = StatusRequest.loading;
    // String table = "travelers";
    // List<Map<String, dynamic>> customData =
    // await DatabaseHelper().getOneData(customerIdlocal, table);
    var selectcompany = homeController.company
        .where((element) => element["com_name"] == name)
        .toList();
    //    DateTime today = DateTime.now();
    // String formattedDate = "${today.year}-${today.month}-${today.day}";
    Map<String, dynamic> companyData = selectcompany[0];
    String api = companyData['com_api'];

    String endAddTraveler = companyData['com_end_add_customer'];
    String endAddBooking = companyData['com_end_add_booking'];
    String apiCustomer = "$api$endAddTraveler";
    String apiBooking = "$api$endAddBooking";
    // print(travelercontroller.selectedTravelerIds.length);
    for (int i = 0; i < travelercontroller.selectedTravelerIds.length; i++) {
      TravelerModel travelerModel =
          travelercontroller.selectedTravelerModels[i];
      Map<String, dynamic> dataTraveler = {
        // companyData['customer_id']:customData[0]['id'],
        companyData['customer_name']: "${travelerModel.name}",
        companyData['customer_phone']: "${travelerModel.phoneNumber}",
        companyData['customer_passport_number']:
            "${travelerModel.passportNumber}",
        companyData['customer_passport_image']:
            "${travelerModel.passportImagePath}",
        companyData['customer_gender']: "${travelerModel.gender}",
        companyData['customer_nationality']: "${travelerModel.nationality}",
        companyData['customer_birthday']: "${travelerModel.dob}"
      };

      var response = await controldata.addData(apiCustomer, dataTraveler);
      statusRequestTraveler = handlingData(response);

      int? customerId;

      if (statusRequestTraveler == StatusRequest.success) {
        customerId = response[companyData['customer_id']];
        Map<String, dynamic> dataBooking = {
          companyData['customer_fk']: "$customerId",
          companyData['travel_fk']:
              "${homeController.travelsModelBooking.travelId}",
        };
        addBooking(travelerModel.id!, apiBooking, dataBooking, i);
      }
    }
    update();
  }

  // دالة الحجز للشركة
  addBooking(int travelerId, String apibooking, Map<String, dynamic> data,
      int count) async {
    statusRequestBooking = StatusRequest.loading;
    var response = await controldata.addData(apibooking, data);
    statusRequestBooking = handlingData(response);
    if (statusRequestBooking == StatusRequest.success &&
        response['message'] == "success") {
      addBookinkToApp(travelerId);
      if (count == travelercontroller.selectedTravelerIds.length - 1) {
        Get.rawSnackbar(
            title: "إشعار",
            messageText: Text("تم حجز ${count + 1} رحلة بنجاح  ",
                style: const TextStyle(
                  color: Colors.white,
                )));
        showBookingConfirmationDialog();
      }
    } else if (statusRequestBooking == StatusRequest.success &&
        response['message'] == "already_exist") {
      Get.rawSnackbar(
          title: "إشعار",
          messageText: Text("الرحلة محجوزه مسبقا بنفس الاسم",
              style: const TextStyle(
                color: Colors.white,
              )));
    }
  }

  // دالة الحجز للتطبيق
  addBookinkToApp(int travelerId) async {
    TravelsModel travelsModel = homeController.travelsModelBooking;
    statusRequestBookingApp = StatusRequest.loading;
    String api = "${apiBooking}${controllerSitting.shared.getInt("userId")}/";
    Map<String, dynamic> bookingdata = {
      "traveler_fk": "$travelerId",
      // "booking_date":date,
      "departure_date": travelsModel.travelStartTime,
      "travel_from": travelsModel.travelFrom,
      "travel_to": travelsModel.travelTo,
      // "status":travelercontroller.
      "total_amount": "${travelsModel.travelPrice}",
      "booking_code": "1QAx456FS2",
      "payment_status": paymentMethod,
      "com_name": travelsModel.companyName
    };
    var response = await controldata.addData(api, bookingdata);
    // print(response);
    statusRequestBookingApp = handlingData(response);
    if (statusRequestBookingApp == StatusRequest.success &&
        response['message'] == "success") {
      code = response['booking_code'];
      BookingModel bookingModel = BookingModel.fromJson(response['data']);
      bookingApp.add(bookingModel);
    }
  }

  getBookingApp() async {
    String api = "${apiBooking}${controllerSitting.shared.getInt("userId")}/";
    statusRequestBookingApp = StatusRequest.loading;
    var response = await controldata.getData(api);
    statusRequestBookingApp = handlingData(response);
    if (statusRequestBookingApp == StatusRequest.success) {
      List<BookingModel> booking = response.map<BookingModel>((element) {
        return BookingModel.fromJson(element);
      }).toList();
      bookingApp.addAll(booking);
    }
    update();
  }

  @override
  void onInit() {
    getBookingApp();
    super.onInit();
  }
}
