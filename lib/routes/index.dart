// 管理路由
import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/Login/index.dart';
import 'package:flutter_shop/pages/Main/index.dart';

// 返回APP根组件
Widget getRootWidget() {
  return MaterialApp(

    //命名路由
    initialRoute: "/",
    routes: getRootRoutes(),
    debugShowCheckedModeBanner: false,
  );
}

// 返回路由表
Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {
    '/': (context) => const MainPage(),
    '/login': (context) => LoginPage(),
  };
}