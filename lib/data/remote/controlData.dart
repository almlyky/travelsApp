import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:travelapp2/core/api/crud.dart';
import 'package:travelapp2/core/constant/linksapi.dart';

class Controldata {
  Crud crud = Crud();

  getData(String api) async {
    var response = await crud.getrequst(api);
    return response.fold((l) => l, (r) => r);
  }

  getDataAuthentecation(String api, dynamic token) async {
    var response = await crud.getrequstAuthentecation(api, token);
    return response.fold((l) => l, (r) => r);
  }

  signinWithgoogle(User user) async {
    var response = await crud.postrequstAuthentication(apiSignGoogle, user);
    return response.fold((l) => l, (r) => r);
  }

  addData(String api, Map<String, dynamic> data) async {
    var response = await crud.postrequst(api, data);
    return response.fold((l) => l, (r) => r);
  }

  addDatawithFile(String api, Map<String, dynamic> data, File file) async {
    var response = await crud.postrequstFile(api, data, file);
    return response.fold((l) => l, (r) => r);
  }

  uppdateDatawithFile(String api, Map<String, dynamic> data, File file) async {
    var response = await crud.putrequstFile(api, data, file);
    return response.fold((l) => l, (r) => r);
  }

  deleteData(String api) async {
    var response = await crud.deleteRequest(api);
    return response.fold((l) => l, (r) => r);
  }
}
