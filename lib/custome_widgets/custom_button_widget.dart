import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:nexus_app/theme/style.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Duration duration;
  final Color startColor;
  final Color endColor;
  final double hight;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.hight = 50,
    this.duration = const Duration(milliseconds: 1900),
    this.startColor = Style.bg_color,
    this.endColor = const Color.fromARGB(255, 237, 202, 145),
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: duration,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: hight,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(colors: [
                startColor ?? Style.bg_color,
                endColor ?? const Color.fromARGB(255, 237, 202, 145),
              ])),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
