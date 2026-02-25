
import 'package:flutter_shop/contants/GlobalConstants.dart';
import 'package:flutter_shop/utils/DioRequest.dart';
import 'package:flutter_shop/viewmodels/user.dart';

Future<UserInfo> loginAPI(String account, String password) async {

  final data = {
    "account": account,
    "password": password,
  };
  final response = await dioRequest.post(ApiConstants.LOGIN, data: data);
  return UserInfo.fromJSON(response);
}

Future<UserInfo> getUserProfileAPI() async {
  final response = await dioRequest.get(ApiConstants.USER_PROFILE);
  return UserInfo.fromJSON(response);
}