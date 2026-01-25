import 'package:flutter/material.dart';

class Hot extends StatefulWidget {
  const Hot({super.key});

  @override
  State<Hot> createState() => _HotState();
}

class _HotState extends State<Hot> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: 200,
      alignment: Alignment.center,
      child: Text("Hot Section"),
    );
  }
}