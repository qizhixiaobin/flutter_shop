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