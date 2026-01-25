import 'package:flutter/material.dart';

class Suggestion extends StatefulWidget {
  const Suggestion({super.key});

  @override
  State<Suggestion> createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:10.0),
      child: Container(
        color: Colors.blue,
        height: 200,
        alignment: Alignment.center,
        child: Text("Suggestion Section"),
      ),
    );
  }
}