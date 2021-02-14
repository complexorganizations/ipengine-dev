import 'package:flutter/material.dart';
import 'package:ipengine/features/presentation/widgets/theme/style.dart';

class IntroductionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "IPengine Documentation",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "As easy as pie",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Container(
            height: 390,
            width: 660,
            alignment: Alignment.center,
            child: Image.asset(
              'assets/docImg.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "The easiest way to get started with IPengine is with our offical API.",
          style: TextStyle(
            fontSize: 14,
            color: color555555,
          ),
        )
      ],
    );
  }
}
