
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
    List<CategoryItem>? childrenList = childrenFromJson != null
        ? childrenFromJson.map((child) => CategoryItem.fromJson(child)).toList()
        : null;

    return CategoryItem(
      id: json['id'].toString(),
      name: json['name'],
      picture: json['picture'],
      children: childrenList,
    );
  }
}