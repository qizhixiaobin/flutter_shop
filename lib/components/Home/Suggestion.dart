import 'package:flutter/material.dart';
import 'package:flutter_shop/viewmodels/home.dart';

class Suggestion extends StatefulWidget {
  final RecommendResult recommendResult;
  const Suggestion({super.key, required this.recommendResult});

  @override
  State<Suggestion> createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {

  // 获取三个推荐商品
  List<GoodsItem> _getThreeGoodsItems() {
    if (widget.recommendResult.subTypes.isEmpty) {
      return [];
    }
    return widget.recommendResult.subTypes.first.goodsItems.items.take(3).toList();
  }

  // 推荐头组件
  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          "特惠推荐",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 86, 24, 20)
          ),
        ),
        SizedBox(width: 10),
        Text(
          "精选省攻略",
          style: TextStyle(
            fontSize: 12,
            color: Color.fromARGB(255, 86, 24, 20)
          ),
        )
      ],
    );
  }

  // 左部组件
  Widget _buildLeft() {
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/assets/home_cmd_inner.png"),
          fit: BoxFit.cover
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  //右部分推荐商品
  List<Widget> _buildRight() {
    List<GoodsItem> goodsList = _getThreeGoodsItems();
    return List.generate(goodsList.length, (index) {
      return Column(
        children: [
          Image.network(goodsList[index].picture,
          errorBuilder: (context, error, stackTrace) => Image.asset("lib/assets/home_cmd_sm.png"),
            width: 100,
            height: 140,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:10.0),
      child: Container(
        padding: EdgeInsets.all(12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blue,
          image: DecorationImage(
            image: AssetImage("lib/assets/home_cmd_sm.png"), 
            fit: BoxFit.cover
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
         children: [
          _buildHeader(),
          SizedBox(height: 10.0),
          Row(
            children: [
              _buildLeft(),
              Expanded(child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:_buildRight()
              ))
            ],
          )
         ],
        ),
      ),
    );
  }
}