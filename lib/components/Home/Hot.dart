import 'package:flutter/material.dart';
import 'package:flutter_shop/viewmodels/home.dart';

class Hot extends StatefulWidget {
  final RecommendResult recommendResult;
  final String type;
  const Hot({super.key, required this.recommendResult, required this.type});

  @override
  State<Hot> createState() => _HotState();
}

class _HotState extends State<Hot> {

  // 获取三个推荐商品
  List<GoodsItem> _getTwoGoodsItems() {
    if (widget.recommendResult.subTypes.isEmpty) {
      return [];
    }
    return widget.recommendResult.subTypes.first.goodsItems.items.take(2).toList();
  }

  // 推荐头组件
  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          widget.type == "hot" ? "爆款推荐" : "一站买全",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 86, 24, 20)
          ),
        ),
        SizedBox(width: 10),
        Text(
          widget.type == "hot" ? "精心优选" : "最受欢迎",
          style: TextStyle(
            fontSize: 12,
            color: Color.fromARGB(255, 86, 24, 20)
          ),
        )
      ],
    );
  }

//右部分推荐商品
  List<Widget> _buildRight() {
    List<GoodsItem> goodsList = _getTwoGoodsItems();
    return List.generate(goodsList.length, (index) {
      return Column(
        children: [
          Image.network(goodsList[index].picture,
          errorBuilder: (context, error, stackTrace) => Image.asset("lib/assets/home_cmd_sm.png"),
            width: 80,
            height: 112,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 5.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              " ¥${goodsList[index].price} ",
              style: TextStyle(
                color: Colors.white
              ),
            ),
          )
        ],
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: widget.type == "hot" ? Color.fromARGB(255, 177, 239, 184) : Color.fromARGB(255, 231, 187, 164),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
         children: [
          _buildHeader(),
          SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:_buildRight()
              ))
            ],
          )
         ],
        ),
    );
  }
}