import 'package:intl/intl.dart';

class TravelsModel {
  int? travelId;
  String? travelFrom;
  String? travelTo;
  int? travelPrice;
  int? travelNumSeats;
  String? travelStartTime;
  double? travelWaitTime;
  String? date;
  String? time;
  String? timeAtten;

  String? companyName;
  String? companyApi;
  String? comImage;

  TravelsModel(travel,
      {this.travelId,
      this.travelFrom,
      this.travelTo,
      this.travelPrice,
      this.travelNumSeats,
      this.travelStartTime,
      this.travelWaitTime});

  TravelsModel.fromJson(Map<String, dynamic> json, Map<String, dynamic> field) {
    travelId = json[field['travel_id']];
    travelFrom = json[field['travel_from']];
    travelTo = json[field['travel_to']];
    travelPrice = json[field['travel_price']];
    travelNumSeats = json[field['travel_num_seats']];
    travelStartTime = json[field['travel_start_time']];
    DateTime dateTime = DateTime.parse(travelStartTime!);
    DateTime updatedDateTime = dateTime.subtract(Duration(hours: 1));
    timeAtten = DateFormat('hh:mm a').format(updatedDateTime);
    time = DateFormat('hh:mm a').format(dateTime);

    // استبدال AM بـ "ص" و PM بـ "م"
    time = time!.replaceAll('AM', 'ص').replaceAll('PM', 'م');
    // وقت الحضور
    timeAtten = timeAtten!.replaceAll('AM', 'ص').replaceAll('PM', 'م');

    companyName = field['com_name'];
    companyApi = field['com_api'];
    // استخراج التاريخ فقط
    date =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    // استخراج الوقت فقط
    travelWaitTime = json[field['travel_wait_time']];
    comImage = field['com_image'];
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['travel_id'] = this.travelId;
    data['travel_from'] = this.travelFrom;
    data['travel_to'] = this.travelTo;
    data['travel_price'] = this.travelPrice;
    data['travel_num_seats'] = this.travelNumSeats;
    data['travel_start_time'] = this.travelStartTime;
    data['travel_wait_time'] = this.travelWaitTime;
    return data;
  }
}
