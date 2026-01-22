import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/Cart/index.dart';
import 'package:flutter_shop/pages/Category/index.dart';
import 'package:flutter_shop/pages/Home/index.dart';
import 'package:flutter_shop/pages/Mine/index.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  // 当前选中的索引
  int _currentIndex = 0;
  // 定义数据，根据数据进行渲染4个导航
  final List<Map<String, String>> _navilist = [{
      "icon": "lib/assets/ic_public_home_normal.png",
      "activeIcon": "lib/assets/ic_public_home_active.png",
      "title": "首页"
    }, {
      "icon": "lib/assets/ic_public_pro_normal.png",
      "activeIcon": "lib/assets/ic_public_pro_active.png",
      "title": "分类"
    }, {
      "icon": "lib/assets/ic_public_cart_normal.png",
      "activeIcon": "lib/assets/ic_public_cart_active.png",
      "title": "购物车"
    }, {
      "icon": "lib/assets/ic_public_my_normal.png",
      "activeIcon": "lib/assets/ic_public_my_active.png",
      "title": "我的"
    }
  ];

  // 根据数据生成BottomNavigationBarItem列表  
  List<BottomNavigationBarItem> _getBottomNavigationItem() {
    return List.generate(_navilist.length, (index) {
      return BottomNavigationBarItem(
        icon: Image.asset(
          _navilist[index]["icon"]!,
          width: 30,
          height: 30,
        ),
        activeIcon: Image.asset(
          _navilist[index]["activeIcon"]!,
          width: 30,
          height: 30,
        ),
        label: _navilist[index]["title"],
      );
    });
  }

  // 返回页面
  List<Widget> _getPages() {
    return [
      HomeView(),
      Category(),
      CartView(),
      MineView()
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // SafeArea避开刘海等遮挡区域
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: _getPages(),
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        items: _getBottomNavigationItem()
      ),
    );
  }
}