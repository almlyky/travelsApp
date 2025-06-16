import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:travelapp2/core/constant/appcolors.dart';
import 'package:travelapp2/core/constant/routes.dart';
import 'package:travelapp2/core/serveces.dart';
import 'package:travelapp2/firebase_options.dart';
class PlatformHelper {
  static const MethodChannel _channel = MethodChannel('com.example.channel');

  static Future<int> calculateSum(int num1, int num2) async {
    try {
      final int result = await _channel.invokeMethod('calculateSum', {
        "num1": num1,
        "num2": num2,
      });
      return result;
    } on PlatformException catch (e) {
      print("Error: '${e.message}'.");
      return 0;
    }
  }

  static Future<String> openNativeCamera() async {
    try {
      final String imagePath = await _channel.invokeMethod('openCamera');
      // print("Image Path: $imagePath");
      return imagePath;
    } on PlatformException catch (e) {
      print("Error: '${e.message}'.");
      return "";
    }
  }

  static Future<String?> getNativeMessage() async {
    try {
      final String? result = await _channel.invokeMethod('getMessage');
      return result;
    } on PlatformException catch (e) {
      return "Failed: ${e.message}";
    }
  }
}

void main() async {
  await initial();
  await dotenv.load(fileName: ".env");
  runApp(const TravelCardApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("============================== background ===================== ");
  print("Handling a background message: ${message.notification!.body}");
}

Future initial() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Get.putAsync<setteng>(() => setteng().init());
}

class TravelCardApp extends StatelessWidget {
  const TravelCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale("ar"),
      initialRoute: Routes.Home,
      // home: Test(),
      getPages: routeapp,
      theme: ThemeData(
          // focusColor: Colors.white,
          fontFamily: "Cairo",
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolors.backgroundbutton,
                  foregroundColor: Appcolors.forgroundbutton,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)))),
          textTheme: TextTheme(
              headlineMedium: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Appcolors.headlineMedium))),
    );
  }
}
