import 'dart:io';

class TravelerModel {
  int? id; // id يمكن أن يكون null لأنه يتم إنشاؤه تلقائيًا
  String name;
  String dob;
  String? gender; // gender يمكن أن يكون null
  String nationality;
  int passportNumber;
  int phoneNumber;
  String passportImagePath;

  TravelerModel({
    this.id,
    required this.name,
    required this.dob,
    this.gender,
    required this.nationality,
    required this.passportNumber,
    required this.phoneNumber,
    required this.passportImagePath,
  });

  // تحويل JSON إلى كائن
  factory TravelerModel.fromJson(Map<String, dynamic> json) {
    return TravelerModel(
      id: json['id'],
      name: json['name'],
      dob: json['dob'],
      gender: json['gender'],
      nationality: json['nationality'],
      passportNumber: json['passport_number'],
      phoneNumber: json['phone_number'],
      passportImagePath: json['passport_image_path'],
    );
  }

  // تحويل الكائن إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dob': dob,
      'gender': gender,
      'nationality': nationality,
      'passportNumber': passportNumber,
      'phoneNumber': phoneNumber,
      // 'passportImagePath': passportImagePath,
    };
  }
}
