import 'package:get/get.dart';
import 'package:travelapp2/core/midleware.dart';
import 'package:travelapp2/view/screan/HomeBottombar.dart';
import 'package:travelapp2/view/screan/Myreservations.dart';
import 'package:travelapp2/view/screan/addtravelers.dart';
import 'package:travelapp2/view/screan/auth/login.dart';
import 'package:travelapp2/view/screan/auth/signup.dart';
import 'package:travelapp2/view/screan/homescrean.dart';
import 'package:travelapp2/view/screan/notifications.dart';
import 'package:travelapp2/view/screan/pageReservation.dart';
import 'package:travelapp2/view/screan/reservationConfirm.dart';
import 'package:travelapp2/view/screan/searchTravels.dart';
import 'package:travelapp2/view/screan/sendnotification.dart';
import 'package:travelapp2/view/screan/travelers.dart';

class Routes {
  static const String Home = "/home";
  static const String HomeScrean = "/homescrean";
  static const String Traveler = "/traveler";
  static const String MyReservation = "/myreservation";
  static const String AddTraveler = "/addtraveler";
  static const String EditTraveleler = "/edittraveler";
  static const String Reservation = "/reservation";
  static const String ReservationConfirm = '/reservationconfirm';
  static const String SearhTravels = "/searchtravels";
  static const String SendNotification = "/sendnotification";
  static const String Notification = "/notification";

  static const String Login = "/login";
  static const String SignUp = "/signup";
}

List<GetPage<dynamic>>? routeapp = [
  GetPage(name: Routes.Home, page: () => Home()),
  GetPage(name: Routes.HomeScrean, page: () => Homescrean()),
  GetPage(name: Routes.Traveler, page: () => Travelers()),
  GetPage(name: Routes.MyReservation, page: () => MyReservations()),
  GetPage(
      name: Routes.AddTraveler,
      page: () => Addtravelers(
            action: "add",
          ),
      middlewares: [Authmiddleware()]),
  GetPage(
      name: Routes.EditTraveleler, page: () => Addtravelers(action: "edit")),
  GetPage(
      name: Routes.Reservation,
      page: () => Reservation(),
      middlewares: [Authmiddleware()]),
  GetPage(name: Routes.ReservationConfirm, page: () => Reservationconfirm()),
  GetPage(name: Routes.SearhTravels, page: () => Searchtravels()),
  GetPage(name: Routes.Login, page: () => LoginPage()),
  GetPage(name: Routes.SignUp, page: () => SignUpPage()),
  GetPage(name: Routes.SendNotification, page: ()=>Sendnotification()),
  GetPage(name: Routes.Notification, page: ()=>Notifications())
];
