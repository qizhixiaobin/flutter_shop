
import 'package:flutter_shop/contants/GlobalConstants.dart';
import 'package:flutter_shop/utils/DioRequest.dart';
import 'package:flutter_shop/viewmodels/home.dart';

Future<GoodsDetailItems> getGuessListAPI(Map<String, dynamic> guessParams) async {
  return GoodsDetailItems.fromJson(
    await dioRequest.get(ApiConstants.GUESS_LIST)
  );
}