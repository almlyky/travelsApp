import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travelapp2/controller/notificationscontroller.dart';
import 'package:travelapp2/core/constant/linksapi.dart';
import 'package:travelapp2/core/constant/routes.dart';
import 'package:travelapp2/core/my-class/statusrequest.dart';
import 'package:travelapp2/core/my_function/handledata.dart';
import 'package:travelapp2/core/serveces.dart';
import 'package:travelapp2/data/remote/controlData.dart';

class Logincontoller extends GetxController {
  late TextEditingController username = TextEditingController();
  late TextEditingController passowrd = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late StatusRequest statusRequestlogin;
  late StatusRequest statusRequestUser;

  Controldata controldata = Controldata();
  setteng controllersetting = Get.find();
  Notificationscontroller notificationscontroller =
      Get.put(Notificationscontroller());
  bool load = false;
  late final String accessToken;

  goToSignUp() {
    Get.offNamed(Routes.SignUp);
  }

  Future<User?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential.user;
    }
    return null;
  }

  loginWithGoogle() async {
    statusRequestlogin = StatusRequest.loading;
    var user = await signInWithGoogle();
    var response = await controldata.signinWithgoogle(user!);
    statusRequestlogin = handlingData(response);
    if (statusRequestlogin == StatusRequest.success) {
      controllersetting.shared.setString("rule", "user");
      controllersetting.shared.setInt("userId", response['user_id']);
      notificationscontroller.subscribeTopic('TravelApp');
      Get.offNamed(Routes.Home);
    } else {
      Get.rawSnackbar(
          title: "إشعار",
          messageText: Text("يوجد خطأ ",
              style: const TextStyle(
                color: Colors.white,
              )));
    }
  }

  // Future<UserCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;

  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //   // accessToken = googleAuth!.accessToken!;
  //   print("Access Token: ${credential.accessToken}");
  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  logoutGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
  }

  logUot() async {
    controllersetting.shared.clear();
    Get.deleteAll();
    notificationscontroller.unSubscribeTopic('TravelApp');
    Get.offAllNamed(Routes.Login);
  }

  login() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      statusRequestlogin = StatusRequest.loading;
      load = true;
      update();
      var response = await controldata.addData(
          apiAppLogin, {"username": username.text, "password": passowrd.text});
      statusRequestlogin = handlingData(response);
      if (StatusRequest.success == statusRequestlogin &&
          response.containsKey("access")) {
        // print(response['access']);
        // controllersetting.shared.setString("accessToken", response['access']);
        // print(controllersetting.shared.getString("accessToken"));
        print("===========================");
        var res = await controldata.getDataAuthentecation(
            apiAppGetUser, response['access']);
        statusRequestUser = handlingData(res);
        if (statusRequestUser == StatusRequest.success) {
          controllersetting.shared.setString("rule", "user");
          controllersetting.shared.setString("username", username.text);
          controllersetting.shared.setInt("userId", res['pk']);
          notificationscontroller.subscribeTopic('TravelApp');
          Get.offNamed(Routes.Home);
        }
      } else {
        load = false;
        update();
      }
    }
  }
}
