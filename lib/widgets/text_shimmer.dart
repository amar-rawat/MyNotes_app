import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TextShimmer extends StatelessWidget {
  TextShimmer({super.key, required this.text});
  String text;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Text(text),
      gradient: LinearGradient(colors: [Colors.purple, Colors.pink]),
    );
  }
}
