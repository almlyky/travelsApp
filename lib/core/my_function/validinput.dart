import 'package:get/get.dart';

validinput(String val, int min, int max, {String? type}) {
  if (val.isEmpty) {
    return "cann't be empty";
  }
  if (val.length < min) {
    return "cann't be less than $min";
  }
  if (val.length > max) {
    return "can't be larger than $max";
  }
  if (type != null) if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "not valid email";
    }
  }
}
