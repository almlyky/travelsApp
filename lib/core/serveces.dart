import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelapp2/controller/notificationscontroller.dart';
import 'package:travelapp2/data/localdata/sqflite.dart';

class setteng extends GetxService {
  Notificationscontroller notificationscontroller =
      Get.put(Notificationscontroller());
  late SharedPreferences shared;
  Future<setteng> init() async {
    shared = await SharedPreferences.getInstance();
    return this;
  }

  @override
  void onInit() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        print(
            "============================== forground ===================== ");
        notificationscontroller.addNotificatios(message);
      }
    });
    super.onInit();
  }
}
