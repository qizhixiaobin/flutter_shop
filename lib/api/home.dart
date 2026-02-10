import 'package:flutter_shop/contants/GlobalConstants.dart';
import 'package:flutter_shop/utils/DioRequest.dart';
import 'package:flutter_shop/viewmodels/home.dart';

Future<List<BannerItem>> getBannerListAPI() async {
  final response = await dioRequest.get(ApiConstants.BANNER_LIST);
  List<dynamic> data = response as List<dynamic>;
  return data.map((item) => BannerItem.fromJson(item)).toList();
}

Future<List<CategoryItem>> getCategoryListAPI() async {
  final response = await dioRequest.get(ApiConstants.CATEGORY_LIST);
  List<dynamic> data = response as List<dynamic>;
  return data.map((item) => CategoryItem.fromJson(item)).toList();
}

Future<RecommendResult> getRecommendListAPI() async {
  return RecommendResult.fromJson(
    await dioRequest.get(ApiConstants.PRODUCT_LIST)
  );
}

// 热榜推荐
Future<RecommendResult> getInVogueListAPI() async {
  // 返回请求
  return RecommendResult.fromJson(
    await dioRequest.get(ApiConstants.IN_VOGUE_LIST),
  );
}

// 一站式推荐
Future<RecommendResult> getOneStopListAPI() async {
  // 返回请求
  return RecommendResult.fromJson(
    await dioRequest.get(ApiConstants.ONE_STOP_LIST),
  );
}

// 推荐列表
Future<List<GoodDetailItem>> getRecommendScrollListAPI(
  Map<String, dynamic> params,
) async {
  // 返回请求
  return ((await dioRequest.get(ApiConstants.RECOMMEND_LIST, queryParameters: params))
          as List)
      .map((item) {
        return GoodDetailItem.formJSON(item as Map<String, dynamic>);
      })
      .toList();
}