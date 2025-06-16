import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelapp2/core/constant/linksapi.dart';
import 'package:travelapp2/core/constant/routes.dart';
import 'package:travelapp2/core/my-class/statusrequest.dart';
import 'package:travelapp2/core/my_function/handledata.dart';
import 'package:travelapp2/data/models/travelModel.dart';
// import 'package:travelapp2/data/remote/companydata.dart';
import 'package:travelapp2/data/remote/controlData.dart';
import 'package:travelapp2/view/screan/homescrean.dart';
import 'package:travelapp2/view/screan/Myreservations.dart';
import 'package:travelapp2/view/screan/settings.dart';
import 'package:travelapp2/view/screan/travelers.dart';

class HomeController extends GetxController {
  int selectedIndex = 0;
  bool checkedVip = false;
  bool checkedEconomic = false;
  List city = [];
  final TextEditingController trFromController = TextEditingController();
  final TextEditingController trToController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  late StatusRequest statusRequest = StatusRequest.loading;
  late StatusRequest statusRequestCompany;
  late StatusRequest statusRequestCustom;
  late StatusRequest statusRequestBooking;

  late TravelsModel travelsModel;
  late TravelsModel travelsModelBooking;

  Controldata controldata = Controldata();
  // CompanyData companyData = CompanyData();
  List<TravelsModel> travels = [];
  List<TravelsModel> search = [];
  List company = [];
  List<Widget> widgetOption = [
    Homescrean(),
    Travelers(),
    MyReservations(),
    Settings()
  ];

  //bottomnavigationbart دالة تغيير الصفحات في
  onItemTapped(int index) {
    selectedIndex = index;
    update();
  }

  goToReservation() {
    Get.toNamed(Routes.Reservation);
  }

  goToSearchTravel() {
    Get.toNamed(Routes.SearhTravels);
  }

  Future<void> selectDate(
      int firstDate, BuildContext context, TextEditingController date) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // التاريخ الافتراضي
      firstDate: DateTime(firstDate), // أول تاريخ يمكن اختياره
      lastDate: DateTime(2101), // آخر تاريخ يمكن اختياره
    );
    if (picked != null) date.text = "${picked.toLocal()}".split(' ')[0];
  }

  void onTap(int index, TextEditingController controller) {
    controller.text = city[index];
    update();
  }

  void changeSelect(String type, bool value) {
    if (type == "vip") {
      checkedVip = value;
    } else {
      checkedEconomic = value;
    }
    update();
  }

  //  للشركات api دالة تقوم بعمل جلب
  getCompany() async {
    statusRequestCompany = StatusRequest.loading;
    var response = await controldata.getData(apiAppCompany);
    statusRequestCompany = handlingData(response);
    if (statusRequestCompany == StatusRequest.success) {
      company = response;
    }
  }

  // دالة تقوم بعمل جلب الرحلات من جميع الشركات
  getTravel() async {
    statusRequest = StatusRequest.loading;
    for (int i = 0; i < company.length; i++) {
      String api = await company[i]['com_api'];
      String endTravel = await company[i]['com_end_travel'];
      String comImage = company[i]['com_image'];

      var response = await controldata.getData("$api$endTravel");
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        List<TravelsModel> companyTravels =
            response.map<TravelsModel>((travelData) {
          return TravelsModel.fromJson(travelData, {
            "travel_id": company[i]['travel_id'],
            "travel_from": company[i]['travel_from'],
            "travel_to": company[i]['travel_to'],
            "travel_price": company[i]['travel_price'],
            "travel_num_seats": company[i]['travel_num_seats'],
            "travel_start_time": company[i]['travel_start_time'],
            "travel_wait_time": company[i]['travel_wait_time'],
            "com_name": company[i]['com_name'],
            "com_api": company[i]['com_api'],
            'com_image':comImage
          });
        }).toList();
        travels.addAll(companyTravels);
        List cityto = travels.map((element) => element.travelTo).toList();
        List cityfrom = travels.map((element) => element.travelFrom).toList();
        city = cityto + cityfrom;
        // ازالة التكرار للمدن
        List uniqueCity = city.toSet().toList();
        city = uniqueCity;
      }
    }
    update();
  }

  searchTravels(String trFrom, String trTo, String date) {
    statusRequest = StatusRequest.loading;
    search = travels
        .where((element) =>
            element.travelFrom == trFrom &&
            element.travelTo == trTo &&
            element.date == date)
        .toList();
    statusRequest = StatusRequest.success;
    update();
  }

  // مصفوفة الصفحات التي في bottomnavigationbar
  // عمل دالة لاستدعاء الدالتين لظمان تنفيذ التالية بعد اكتمال تنفيذ الاولى
  getData() async {
    await getCompany(); // تأكد من انتظار تنفيذ getCompany
    await getTravel(); // بعد ذلك نفذ getTravel
  }

  @override
  void onInit() {
    super.onInit(); 
    getData();
  }
}
