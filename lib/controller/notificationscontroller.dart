import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:travelapp2/data/localdata/sqflite.dart';

class Notificationscontroller extends GetxController {
  TextEditingController sendNotificationcontroller = TextEditingController();
  List notifications = [];
  Future<String?> getAccessToken() async {
    final Map<String, dynamic> serviceAccount = {
      "type": dotenv.env['type'],
      "project_id": dotenv.env['project_id'],
      "private_key_id": dotenv.env['private_key_id'],
      "private_key": dotenv.env['private_key']?.replaceAll(r'\n', '\n'),
      "client_email": dotenv.env['client_email'],
      "client_id": dotenv.env['client_id'],
      "auth_uri": dotenv.env['auth_uri'],
      "token_uri": dotenv.env['token_uri'],
      "auth_provider_x509_cert_url": dotenv.env['auth_provider_x509_cert_url'],
      "client_x509_cert_url": dotenv.env['client_x509_cert_url'],
      "universe_domain": dotenv.env['universe_domain'],
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];
    try {
      http.Client client = await auth.clientViaServiceAccount(
          auth.ServiceAccountCredentials.fromJson(serviceAccount), scopes);
      auth.AccessCredentials credentials =
          await auth.obtainAccessCredentialsViaServiceAccount(
              auth.ServiceAccountCredentials.fromJson(serviceAccount),
              scopes,
              client);
      client.close();
      print(credentials.accessToken.data);
      return credentials.accessToken.data;
    } catch (e) {
      return null;
    }
  }

  Future<String?> mygettoken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    return token;
  }

  subscribeTopic(String topic) async {
    await FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  unSubscribeTopic(String topic) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }

  permission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  sendnotification(String titele, String message, String topic) async {
    // permission();
    // subscribe to topic on each app start-up
    var linkapi =
        "https://fcm.googleapis.com/v1/projects/travelsapp-41249/messages:send";
    // var token = await mygettoken();
    var accestoken = await getAccessToken();
    var response = await http.post(Uri.parse(linkapi),
        body: json.encode({
          "message": {
            "topic": topic,
            "notification": {"title": titele, "body": message}
          }
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accestoken'
        });
    if (response.statusCode == 200) {
      print('Notification sent successfully!');
    } else {
      print('Failed to send notification: ${response.statusCode}');
    }
  }

  addNotificatios(RemoteMessage message) async {
    DateTime dateTime = DateTime.now();
    String date =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    await DatabaseHelper().insertdata({
      "title": message.notification!.title,
      "body": message.notification!.body,
      "date": date
    }, "notifications");
    getNotifications();
  }

  getNotifications() async {
    notifications.clear();
    List<Map<String, dynamic>> response =
        await DatabaseHelper().getdata('notifications');
    notifications.addAll(response);
    update();
  }

  @override
  void onInit() {
    getNotifications();
    super.onInit();
  }
}
