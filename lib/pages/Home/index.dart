import 'package:flutter/material.dart';
import 'package:flutter_shop/api/home.dart';
import 'package:flutter_shop/components/Home/Category.dart';
import 'package:flutter_shop/components/Home/HomeSlider.dart';
import 'package:flutter_shop/components/Home/Hot.dart';
import 'package:flutter_shop/components/Home/MoreList.dart';
import 'package:flutter_shop/components/Home/Suggestion.dart';
import 'package:flutter_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  // 轮播图数据
  List<BannerItem> _bannerList = [];
  // 分类数据
  List<CategoryItem> _categoryList = []; 
  // 推荐数据
  RecommendResult _recommendResult = RecommendResult(id: "", title: "", subTypes: []);

  @override
  void initState() {

    super.initState();
    _getBannerList();
    _getCategoryList();
    _getRecommendResult();
  }

  _getBannerList() async { 
    _bannerList = await getBannerListAPI();
    setState(() {});
  }

  _getCategoryList() async {
    _categoryList = await getCategoryListAPI();
    setState(() {});
  }

  _getRecommendResult() async {
    _recommendResult = await getRecommendListAPI();
    setState(() {});
  }
 
  // 获取滚动容器的内容
  List<Widget> _getSlivers() {
    return [

      // 包裹普通Widget的Sliver组件
      SliverToBoxAdapter(
        child: Homeslider(bannerList: _bannerList,),
      ),

      // 间隔
      SliverToBoxAdapter(
        child: SizedBox(height: 10),
      ),

      // 分类
      SliverToBoxAdapter(
        child: Category(categoryList: _categoryList),
      ),

      // 间隔
      SliverToBoxAdapter(
        child: SizedBox(height: 10),
      ),

      // 推荐组件
      SliverToBoxAdapter(
        child: Suggestion(recommendResult: _recommendResult),
      ),

      // 间隔
      SliverToBoxAdapter(
        child: SizedBox(height: 10),
      ),

      // 热点组件
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: Hot()),
              SizedBox(width: 10),
              Expanded(child: Hot())
            ],
          ),
        ),
      ),

      // 间隔
      SliverToBoxAdapter(
        child: SizedBox(height: 10),
      ),

      // 无限滚动列表
      Morelist(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: _getSlivers(),
    );
  }
}