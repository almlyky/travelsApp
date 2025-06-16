// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// // import 'package:permission_handler/permission_handler.dart';
// import 'package:travelapp2/main.dart';

// class Test extends StatefulWidget {
//   const Test({super.key});

//   @override
//   State<Test> createState() => _TestState();
// }

// class PickeImage {
//   static const platform = MethodChannel('com.example.app/image_picker');
// //  Enum ImageSourceType=E { camera, gallery }
//   static const String CAMERA = "camera";
//   static const String GALLERY = "gallery";
//   Future<void> requestStoragePermission() async {
//     if (await Permission.storage.request().isGranted) {
//       print("✅ تم منح الإذن!");
//     } else {
//       print("❌ تم رفض الإذن!");
//     }
//   }

//   pickImage(String source) async {
//     requestStoragePermission();
//     try {
//       final String? imagePath =
//           await platform.invokeMethod('pickImage', {"source": source});
//       if (imagePath != null) {
//         // setState(() {
//         return File(imagePath);
//         // });
//       }
//     } on PlatformException catch (e) {
//       print("خطأ في اختيار الصورة: ${e.message}");
//     }
//   }
// }

// File? image;

// class _TestState extends State<Test> {
//   PickeImage pickeImage = PickeImage();

// //   Future<void> requestCameraPermission() async {
// //   var status = await Permission.camera.status;
// //   if (!status.isGranted) {
// //     await Permission.camera.request();
// //   }
// // }
//   // Future<void> openNativeCamera() async {
//   //   String camera = await PlatformHelper.openNativeCamera();
//   //   setState(() {
//   //     image = File(camera);
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Center(
//             child: ElevatedButton(
//                 onPressed: () async {
//                   String? message = await PlatformHelper.getNativeMessage();
//                   print("Message from Kotlin: $message");
//                 },
//                 child: Text("send")),
//           ),
//           ElevatedButton(
//               onPressed: () {
//                 setState(() {
//               image=pickeImage.pickImage(PickeImage.CAMERA);

//                 });
//               },
//               child: Text("opencamer")),
//           ElevatedButton(
//               onPressed: (){
//                  setState(() {
//               image= pickeImage.pickImage(PickeImage.GALLERY);
//                 });
//               },
//               child: Text("gallery")),
//           Image(
//               image: image != null
//                   ? FileImage(image!)
//                   : AssetImage("assets/images/bus.png"))
//         ],
//       ),
//     );
//   }
// }
