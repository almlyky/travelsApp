import 'package:intl/intl.dart';

class BookingModel {
  int? id; // معرف الحجز
  int? travelerId; // معرف المسافر المرتبط بالحجز
  DateTime? bookingDate; // تاريخ الحجز
  String? departureDate; // تاريخ ووقت المغادرة
  String? travelFrom; // مكان المغادرة
  String? travelTo; // الوجهة
  String? status; // حالة الحجز
  double? totalAmount; // المبلغ الإجمالي للحجز
  String? bookingCode; // رمز الحجز
  String? paymentStatus; // حالة الدفع
  String? time;
  String? timePresence;
  String? date;
  String? companyName;

  // Constructor
  BookingModel({
    required this.id,
    required this.travelerId,
    required this.bookingDate,
    required this.departureDate,
    required this.travelFrom,
    required this.travelTo,
    required this.status,
    required this.totalAmount,
    required this.bookingCode,
    required this.paymentStatus,
  });

  // Factory method لتحويل JSON إلى كائن Dart
  BookingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    travelerId = json['traveler_fk'];
    bookingDate = DateTime.parse(json['booking_date']);
    departureDate = json['departure_date'];
    travelFrom = json['travel_from'];
    travelTo = json['travel_to'];
    status = json['status'];
    totalAmount = double.tryParse(json['total_amount']) ?? 0.0;
    bookingCode = json['booking_code'];
    paymentStatus = json['payment_status'];
    companyName = json['com_name'];
    if (status == "pending") {
      status = "حالة الإنتظار";
    } else if (status == "confirmed") {
      status = "مؤكدة";
    } else {
      status = "ملغية";
    }
  

    DateTime dateTime = DateTime.parse(departureDate!);
    DateTime updatedDateTime = dateTime.subtract(Duration(hours: 1));
    timePresence = DateFormat('hh:mm a').format(updatedDateTime);
    time = DateFormat('hh:mm a').format(dateTime);
    date =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    // استبدال AM بـ "ص" و PM بـ "م"
    time = time!.replaceAll('AM', 'ص').replaceAll('PM', 'م');
    // وقت الحضور
    timePresence = timePresence!.replaceAll('AM', 'ص').replaceAll('PM', 'م');
  }

  // تحويل كائن Dart إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'traveler_fk': travelerId,
      'booking_date': bookingDate,
      'departure_date': departureDate,
      'travel_from': travelFrom,
      'travel_to': travelTo,
      'status': status,
      'total_amount': totalAmount,
      'booking_code': bookingCode,
      'payment_status': paymentStatus,
    };
  }
}
