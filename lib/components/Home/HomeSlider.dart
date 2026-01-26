import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/viewmodels/home.dart';

class Homeslider extends StatefulWidget {

  // 轮播图数据
  final List<BannerItem> bannerList;
  const Homeslider({required this.bannerList, super.key});

  @override
  State<Homeslider> createState() => _HomesliderState();
}

class _HomesliderState extends State<Homeslider> {
  CarouselSliderController _carouselSliderController = CarouselSliderController();
  int _currentIndex = 0;
  // 轮播图组件
  Widget _buildBanner() {
    return CarouselSlider(
      carouselController: _carouselSliderController,
      items: List.generate(widget.bannerList.length, (index) {
        return Image.network(
          widget.bannerList[index].imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
        );
      }),
      options: CarouselOptions(
        height: 300,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        pauseAutoPlayOnTouch: true,
        viewportFraction: BorderSide.strokeAlignOutside,
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  } 

  Widget _getSearch() {
    return Positioned(
      top: 10,
      left: 0,
      right:0,
      child:Padding(
      padding: EdgeInsets.all(10),
      child:Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 40),
      height: 50,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(0,0,0, 0.4),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        "搜索",
        style: TextStyle(color:Colors.white, fontSize: 16),
      ),//Text
      ),//Container
      ),//Padding
    );//Positioned
  }

  Widget _getDot() {
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.bannerList.length, (index) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 6,
            width: _currentIndex == index ? 40 : 20,
            margin: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: _currentIndex == index ? Colors.white : Colors.grey,
              borderRadius: BorderRadius.circular(3)
            ), 
            child: GestureDetector(
              onTap: () {
                _carouselSliderController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
              },
            )
          );
        }),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBanner(),
        _getSearch(),
        _getDot(),
       ],
    );
  }
}