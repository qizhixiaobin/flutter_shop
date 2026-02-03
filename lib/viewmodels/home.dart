
class BannerItem {
  
  final String imageUrl;
  final String id;

  BannerItem({required this.imageUrl, required this.id});

  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return  BannerItem(
      imageUrl: json['imgUrl'],
      id: json['id'].toString(),
    );
  }
}
//根据json数据解析模型
class CategoryItem {
  final String id;
  final String name;
  final String picture;
  final List<CategoryItem>? children;

  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    this.children,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    var childrenFromJson = json['children'] as List?;
    List<CategoryItem>? childrenList = childrenFromJson?.map((child) => CategoryItem.fromJson(child)).toList();

    return CategoryItem(
      id: json['id'].toString(),
      name: json['name'],
      picture: json['picture'],
      children: childrenList,
    );
  }
}


class RecommendResult {
  final String id;
  final String title;
  final List<SubType> subTypes;

  RecommendResult({required this.id, required this.title, required this.subTypes});

  factory RecommendResult.fromJson(Map<String, dynamic> json) {
    var list = json['subTypes'] as List?;
    List<SubType> subTypes = list?.map((e) => SubType.fromJson(e as Map<String, dynamic>)).toList() ?? [];
    return RecommendResult(
      id: json['id'].toString(),
      title: json['title'].toString(),
      subTypes: subTypes,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subTypes': subTypes.map((e) => e.toJson()).toList(),
      };
}

class SubType {
  final String id;
  final String title;
  final GoodsItems goodsItems;

  SubType({required this.id, required this.title, required this.goodsItems});

  factory SubType.fromJson(Map<String, dynamic> json) {
    return SubType(
      id: json['id'].toString(),
      title: json['title'].toString(),
      goodsItems: GoodsItems.fromJson(json['goodsItems'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'goodsItems': goodsItems.toJson(),
      };
}

class GoodsItems {
  final int counts;
  final int pageSize;
  final int pages;
  final int page;
  final List<GoodsItem> items;

  GoodsItems({required this.counts, required this.pageSize, required this.pages, required this.page, required this.items});

  factory GoodsItems.fromJson(Map<String, dynamic> json) {
    int parseInt(dynamic v) {
      if (v is int) return v;
      if (v is String) return int.tryParse(v) ?? 0;
      return 0;
    }

    var list = json['items'] as List?;
    List<GoodsItem> items = list?.map((e) => GoodsItem.fromJson(e as Map<String, dynamic>)).toList() ?? [];

    return GoodsItems(
      counts: parseInt(json['counts']),
      pageSize: parseInt(json['pageSize']),
      pages: parseInt(json['pages']),
      page: parseInt(json['page']),
      items: items,
    );
  }

  Map<String, dynamic> toJson() => {
        'counts': counts,
        'pageSize': pageSize,
        'pages': pages,
        'page': page,
        'items': items.map((e) => e.toJson()).toList(),
      };
}

class GoodsItem {
  final String id;
  final String name;
  final String? desc;
  final String price;
  final String picture;
  final int orderNum;

  GoodsItem({required this.id, required this.name, this.desc, required this.price, required this.picture, required this.orderNum});

  factory GoodsItem.fromJson(Map<String, dynamic> json) {
    int parseInt(dynamic v) {
      if (v is int) return v;
      if (v is String) return int.tryParse(v) ?? 0;
      return 0;
    }

    return GoodsItem(
      id: json['id'].toString(),
      name: json['name'].toString(),
      desc: json['desc']?.toString(),
      price: json['price'].toString(),
      picture: json['picture'].toString(),
      orderNum: parseInt(json['orderNum']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'desc': desc,
        'price': price,
        'picture': picture,
        'orderNum': orderNum,
      };
}
