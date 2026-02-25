import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/api/user.dart';
import 'package:flutter_shop/stores/TokenManager.dart';
import 'package:flutter_shop/stores/UserController.dart';
import 'package:flutter_shop/utils/LoadingDialog.dart';
import 'package:flutter_shop/utils/ToastUtils.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Usercontroller _usercontroller = Get.find();
  final TextEditingController _phoneController = TextEditingController(); // 账号控制器
  final TextEditingController _codeController = TextEditingController(); // 密码控制器
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // 表单Key
  // 用户账号Widget
  Widget _buildPhoneTextField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '请输入账号';
        }
        // 校验手机号格式
        final phoneRegExp = RegExp(r'^1[3-9]\d{9}$');
        if (!phoneRegExp.hasMatch(value)) {
          return '请输入有效的手机号';
        }
        return null;
      },
      controller: _phoneController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20), // 内容内边距
        hintText: "请输入账号",
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  // 用户密码Widget
  Widget _buildCodeTextField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '请输入密码';
        }
        // 校验密码格式（6-16位，字母、数字、下划线）
        final passwordRegExp = RegExp(r'^[a-zA-Z0-9_]{6,16}$');
        if (!passwordRegExp.hasMatch(value)) {
          return '密码长度为6-16位，且只能包含字母、数字和下划线';
        }
        return null;
      },
      controller: _codeController,
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20), // 内容内边距
        hintText: "请输入密码",
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  void _login() async{
    Loadingdialog.show(context, message: "努力登录中...");
    String account = _phoneController.text;
    String password = _codeController.text;
    try {
    final userInfo = await loginAPI(account, password);
    _usercontroller.updateUserInfo(userInfo);
    tokenManager.setToken(userInfo.token);
    Loadingdialog.hide(context);
    Toastutils.show(context, "登录成功，欢迎${userInfo.nickname}！");
    Navigator.pop(context); // 登录成功后返回上一页
    } catch (e) {
      Loadingdialog.hide(context);
      Toastutils.show(context, (e as DioException).message ?? "登录失败，请稍后再试");
    }
  }

  // 登录按钮Widget
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // 登录逻辑
          if (_formKey.currentState?.validate() ?? false) {
            // 勾选隐私政策和用户协议
            if (!_isChecked) {
              Toastutils.show(context, "请同意隐私条款和用户协议");
            } else {
              _login();
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text("登录", style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }

  bool _isChecked = false;
  // 勾选Widget
  Widget _buildCheckbox() {
    return Row(
      children: [
        // 设置勾选为圆角
        Checkbox(
          value: _isChecked,
          activeColor: Colors.black,
          checkColor: Colors.white,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value ?? false;
            });
          },
          // 设置形状
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // 圆角大小
          ),
          // 可选：设置边框
          side: BorderSide(color: Colors.grey, width: 2.0),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "查看并同意"),
              TextSpan(
                text: "《隐私条款》",
                style: TextStyle(color: Colors.blue),
              ),
              TextSpan(text: "和"),
              TextSpan(
                text: "《用户协议》",
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 头部Widget
  Widget _buildHeader() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "账号密码登录",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("惠多美登录", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(30),
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 20),
              _buildHeader(),
              SizedBox(height: 30),
              _buildPhoneTextField(),
              SizedBox(height: 20),
              _buildCodeTextField(),
              SizedBox(height: 20),
              _buildCheckbox(),
              SizedBox(height: 20),
              _buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
