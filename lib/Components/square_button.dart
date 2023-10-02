
import 'package:flutter/material.dart';


class SquareButton extends StatelessWidget {
  final String imagePath;
  const SquareButton({super. key, required this.imagePath,});

  @override
  Widget build(BuildContext context){
    return Container(
      child: Image.asset(
        imagePath,
        width: 50,
        height: 50,
      ),
    );
  }
}