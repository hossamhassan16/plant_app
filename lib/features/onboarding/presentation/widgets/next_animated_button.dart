import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

class NextAnimatedButton extends StatelessWidget {
  const NextAnimatedButton(
      {super.key, required this.onTap, required this.text});
  final void Function()? onTap;
  final dynamic text;

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      height: 70,
      width: 200,
      text: text,
      isReverse: true,
      selectedTextColor: Colors.white,
      transitionType: TransitionType.LEFT_TO_RIGHT,
      textStyle: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      backgroundColor: Colors.green,
      selectedBackgroundColor: Colors.green,
      borderColor: Colors.white,
      borderRadius: 50,
      borderWidth: 2,
      onPress: onTap,
    );
  }
}
