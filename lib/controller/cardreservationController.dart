import 'package:get/get.dart';

class Cardreservationcontroller extends GetxController {
   Map<int, bool> isShowDeials = {};
  setShowDetails(int id, bool value) {
    isShowDeials[id] = value;
  }
  

  changeShowDetails(int id) {
    setShowDetails(id, !isShowDeials[id]!);

    update();
  }
}