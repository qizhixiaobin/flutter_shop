import 'package:flutter/material.dart';

class MineView extends StatefulWidget {
  const MineView({super.key});

  @override
  State<MineView> createState() => _MineViewState();
}

class _MineViewState extends State<MineView> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.yellow,alignment: Alignment.center, child: Text("我的"),);
  }
}