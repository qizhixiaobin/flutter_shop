import 'package:flutter/material.dart';
import 'package:flutter_shop/viewmodels/home.dart';

class Category extends StatefulWidget {

  // 分类列表
  final List<CategoryItem> categoryList;

  const Category({super.key, required this.categoryList});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categoryList.length,
        itemBuilder: (context, index) {
          return Container(
            width: 80,
            height: 100,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 213, 218, 221),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  widget.categoryList[index].picture,
                  width: 50,
                  height: 50,
                ),
                SizedBox(height: 5),
                Text(
                  widget.categoryList[index].name,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          );
        },
      )
    );
  }
}