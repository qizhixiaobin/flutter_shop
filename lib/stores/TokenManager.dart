
import 'package:flutter_shop/contants/GlobalConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tokenmanager {

  Future<SharedPreferences> _getInstance() {
    return SharedPreferences.getInstance();
  }

  String _token = "";

  // 初始化token
  Future<void> init() async  {
    final prefs = await _getInstance();
    _token = prefs.getString(GlobalConstants.TOKEN_KEY) ?? "";
  }

  // 设置token
  Future<void> setToken(String token) async {
    final prefs = await _getInstance();
    prefs.setString(GlobalConstants.TOKEN_KEY, token);
    _token = token;
  }

  // 获取token  
  String getToken() {
    return _token;
  }

  // 删除token
  Future<void> removeToken() async {
    final prefs = await _getInstance();
    prefs.remove(GlobalConstants.TOKEN_KEY);
    _token = "";
  }
}

final tokenManager = Tokenmanager();