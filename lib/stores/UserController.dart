import 'package:flutter_shop/viewmodels/user.dart';
import 'package:get/get.dart';

class Usercontroller extends GetxController {
  var userInfo = UserInfo.fromJSON({}).obs;

  void updateUserInfo(UserInfo newInfo) {
    userInfo.value = newInfo;
  }
}