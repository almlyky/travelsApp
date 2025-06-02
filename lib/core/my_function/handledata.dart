
import 'package:travelapp2/core/my-class/statusrequest.dart';

handlingData(response){
  if(response is StatusRequest){
    return response;
  }
  else {
    return StatusRequest.success;
  }
}