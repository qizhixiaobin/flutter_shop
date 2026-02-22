// 全局常量
class GlobalConstants {
  static final String  APP_NAME = "Flutter Shop";
  static final String API_BASE_URL = "https://meikou-api.itheima.net/";
  static final int TIMEOUT_DURATION = 5000; // in milliseconds  
  static final String SUCCESS_CODE = "1";
}

//请求地址常量
class ApiConstants {
  static final String BANNER_LIST = "home/banner"; // 轮播图列表
  static final String CATEGORY_LIST = "home/category/head"; // 分类列表
  static final String PRODUCT_LIST = "hot/preference"; // 商品列表
  static final String PRODUCT_DETAIL = "api/product/detail"; // 商品详情
  static const String IN_VOGUE_LIST = "/hot/inVogue"; // 热榜推荐地址
  static const String ONE_STOP_LIST = "/hot/oneStop"; // 一站式推荐地址
  static const String RECOMMEND_LIST = "/home/recommend"; // 推荐列表
  static const String GUESS_LIST = "/home/goods/guessLike"  ; // 猜你喜欢列表
}