
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