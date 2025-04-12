import 'package:flutter/material.dart';

class OnboardItem extends StatelessWidget {
  const OnboardItem(
      {super.key,
      required this.image,
      required this.description1,
      required this.description2});
  final String image, description1, description2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Spacer(
            flex: 1,
          ),
          Image.asset(
            image,
            height: 400,
            width: 400,
          ),
          Spacer(
            flex: 1,
          ),
          Text(
            description1,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            description2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          Spacer(
            flex: 5,
          )
        ],
      ),
    );
  }
}
