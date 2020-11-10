

import 'package:flutter/material.dart';
import 'package:ipengine/features/presentation/widgets/theme/style.dart';

class IntroductionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Introduction to IPengine",
          style:
          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "Easy Peasy Lemon Squeezy",
          style:
          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Container(
            height: 390,
            width: 660,
            alignment: Alignment.center,
            child: Image.asset('assets/docImg.png', fit: BoxFit
                .contain,),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "The quickest and easiest way to get started with IPinfo is to use one of our official libraries, which are available for many popular programming languages and frameworks. If you'd like to write your own library or interact directly with our API then the documentation below can help you.",
          style: TextStyle(
            fontSize: 14,
            color: color555555,
          ),
        )
      ],
    );
  }
}
