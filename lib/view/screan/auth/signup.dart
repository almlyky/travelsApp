import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelapp2/controller/auth/signupcontroller.dart';
import 'package:travelapp2/core/my-class/statusrequest.dart';
import 'package:travelapp2/core/my_function/validinput.dart';
import 'package:travelapp2/view/widgets/shared/customTextfield.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    Signupcontroller signupcontroller = Get.put(Signupcontroller());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  // backgroundColor: Colors.yellow,
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "مستخدم جديد",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "مرحباً بك، قم بتسجيل بيانات حساب جديد",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 32),
                Form(
                    key: signupcontroller.formstate,
                    child: Column(
                      children: [
                        CustomTextfild(
                            validate: (val) {
                              return validinput(val!, 5, 100);
                            },
                            controller: signupcontroller.username,
                            hintext: "أدخل اسمك المستخدم",
                            icon: Icons.person,
                            obscureText: false,
                            prefixIcon: true,
                            
                            ),
                        const SizedBox(height: 16),
                        CustomTextfild(
                            validate: (val) {
                              return validinput(val!, 5, 100,type: "email");
                            },
                            controller: signupcontroller.email,
                            hintext: "ادخل البريد",
                            icon: Icons.email,
                            obscureText: false,
                            prefixIcon: true,
                            ),
                        const SizedBox(height: 16),
                        CustomTextfild(
                            validate: (val) {
                              return validinput(val!, 5, 100);
                            },
                            controller: signupcontroller.password,
                            hintext: "كلمة المرور",
                            obscureText: true,
                            prefixIcon: true,

                            icon: Icons.password),
                        const SizedBox(height: 16),
                        CustomTextfild(
                            validate: (val) {
                              return validinput(val!, 5, 100);
                            },
                            controller: signupcontroller.confirmpassword,
                            hintext: "تأكيد كلمة المرور",
                            obscureText: true,
                            prefixIcon: true,
                            icon: Icons.password),
                      ],
                    )),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(value: false, onChanged: (value) {}),
                    const Expanded(
                      child: Text(
                        "أوافق على الشروط والأحكام & سياسة الخصوصية",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<Signupcontroller>(
                    builder: (controller)=>
                     ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        signupcontroller.signUp();
                      },
                      child: 
                      signupcontroller.statusRequest==StatusRequest.loading?
                      CircularProgressIndicator():
                      Text("إنشاء حساب"),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("هل لديك حساب؟ "),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "تسجيل الدخول",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // const Spacer(),

            // const Spacer(),
          ],
        ),
      ),
    );
  }
}
