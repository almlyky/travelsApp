import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelapp2/controller/auth/logincontoller.dart';
import 'package:travelapp2/core/constant/routes.dart';
import 'package:travelapp2/core/my_function/validinput.dart';
import 'package:travelapp2/view/widgets/shared/customTextfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Logincontoller logincontoller = Get.put(Logincontoller());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  const Text(
                    "تسجيل الدخول!",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "مرحباً بك، قم بتسجيل الدخول",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 50),
                  Form(
                      key: logincontoller.formstate,
                      child: Column(
                        children: [
                          CustomTextfild(
                            validate: (val) {
                              return validinput(val!, 5, 100);
                            },
                            controller: logincontoller.username,
                            hintext: "ادخل اسم المستخدم",
                            icon: Icons.person,
                            obscureText: false,
                            prefixIcon: true,
                          ),
                          const SizedBox(height: 16),
                          CustomTextfild(
                            validate: (val) {
                              return validinput(val!, 5, 100);
                            },
                            controller: logincontoller.passowrd,
                            hintext: "ادخل كلمة المرور",
                            icon: Icons.password,
                            obscureText: true,
                            prefixIcon: true,
                          ),
                        ],
                      )),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.VerifyCode);
                      },
                      child: Text(
                        "هل نسيت كلمة السر؟",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(value: true, onChanged: (value) {}),
                      const Text("تذكرني"),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: GetBuilder<Logincontoller>(
                      builder: (controller) => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {
                          logincontoller.login();
                        },
                        child: logincontoller.load
                            ? CircularProgressIndicator()
                            : Text("تسجيل الدخول"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("ليس لديك حساب؟ "),
                      TextButton(
                        onPressed: () {
                          logincontoller.goToSignUp();
                        },
                        child: Text(
                          "إنشاء حساب",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text("أو"),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        // backgroundColor: Colors.yellow,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      onPressed: () {
                        logincontoller.loginWithGoogle();
                      },
                      icon: const Icon(
                        Icons.g_mobiledata,
                        color: Color.fromARGB(255, 255, 255, 255),
                        size: 40,
                      ),
                      label: const Text(
                        "الدخول عبر جوجل",
                        // style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  // const Spacer(),
                ],
              ),
            )
            // const Spacer(),
          ],
        ),
      ),
    );
  }
}
