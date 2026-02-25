import 'package:flutter/material.dart';
import 'package:flutter_shop/api/home.dart';
import 'package:flutter_shop/components/Home/Category.dart';
import 'package:flutter_shop/components/Home/HomeSlider.dart';
import 'package:flutter_shop/components/Home/Hot.dart';
import 'package:flutter_shop/components/Home/MoreList.dart';
import 'package:flutter_shop/components/Home/Suggestion.dart';
import 'package:flutter_shop/utils/ToastUtils.dart';
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
  RecommendResult _inVogueResult = RecommendResult(id: "", title: "", subTypes: []);
  RecommendResult _oneStopResult = RecommendResult(id: "", title: "", subTypes: []);
  // 推荐列表
  List<GoodDetailItem> _recommendList = [];
  final ScrollController _scrollController = ScrollController();
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
  double _paddingTop = 0.0;

  @override
  void initState() {

    super.initState();
    _registerEvent();
    Future.microtask(() async {
      _refreshKey.currentState?.show();
      // _paddingTop = 100.0;
      setState(() {
      });
    });
  }

  Future<void> _onRefresh() async {
    _page = 1;
    _hasMore = true;
    _recommendList.clear();
    await _getBannerList();
    await _getCategoryList();
    await _getRecommendResult();
    await _getInVogueResult();
    await _getOneStopResult();
    await _getRecommendList();
    Toastutils.show(context, "刷新完成");
    _paddingTop = 0.0;
    setState(() {
    });
  }

  Future<void> _getBannerList() async { 
    _bannerList = await getBannerListAPI();
  }

  Future<void> _getCategoryList() async {
    _categoryList = await getCategoryListAPI();
  }

  Future<void> _getRecommendResult() async {
    _recommendResult = await getRecommendListAPI();
  }
 
  Future<void> _getInVogueResult() async {
    _inVogueResult = await getInVogueListAPI();
  }

  Future<void> _getOneStopResult() async {
    _oneStopResult = await getOneStopListAPI();
  }

    // 获取推荐列表
  Future<void> _getRecommendList() async {
    if (_isLoading && !_hasMore) {
      return;
    }
    _isLoading = true;
    int requestLimit = _page * 10;
    _recommendList = await getRecommendScrollListAPI({"limit": requestLimit});
    _isLoading = false;
    if (_recommendList.length < requestLimit) {
      _hasMore = false;
      return;
    }
    _page++;
  }

  _registerEvent() {
    // 注册监听事件
    _scrollController.addListener(() {
      // 滚动到底部加载更多
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 50) {
        _getRecommendList();
      }
    });
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
              Expanded(child: Hot(recommendResult: _inVogueResult, type: "hot")),
              SizedBox(width: 10),
              Expanded(child: Hot(recommendResult: _oneStopResult, type: "step"))
            ],
          ),
        ),
      ),

      // 间隔
      SliverToBoxAdapter(
        child: SizedBox(height: 10),
      ),

      // 无限滚动列表
      Morelist(recommendList: _recommendList),
    ];
  }

// Globalkey是一个方法，用于在Flutter中唯一标识一个Widget，并允许在Widget树中跨越不同的层次结构访问该Widget的状态或属性。
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      padding: EdgeInsets.only(top: _paddingTop),
      child: RefreshIndicator(
        key: _refreshKey,
        onRefresh: _onRefresh,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: _getSlivers(),
        ),
      )
    );

  }
}