import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelapp2/controller/auth/verifycodecontroller.dart';

class VerifyCodePage extends StatelessWidget {
  const VerifyCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    Verifycodecontroler verifycodecontroler = Get.put(Verifycodecontroler());
    return Scaffold(
      appBar: AppBar(
        title: const Text("تأكيد الرمز"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "أدخل رمز التحقق الذي تم إرساله إلى رقم هاتفك",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: verifycodecontroler.otpcontroller,
              decoration: InputDecoration(
                labelText: "رمز التحقق",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                verifycodecontroler.chechoTp("signup");
                // قم بإضافة منطق التحقق هنا
                // Get.snackbar("نجاح", "تم التحقق من الرمز بنجاح!");
              },
              child: const Text("تحقق"),
            ),
          ],
        ),
      ),
    );
  }
}
