import 'package:flutter/material.dart';
import '../../../../Core/Theme/Palatte.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.text, required this.color});
  final String text;
   final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 50,

      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: color,
        border:color==AppPallete.backgroundColor? Border.all(
          color: AppPallete.borderColor,
        ):Border.all(color:AppPallete.backgroundColor ),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(child: Text(text)),
    );
  }
}