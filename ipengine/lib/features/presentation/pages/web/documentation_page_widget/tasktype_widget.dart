import 'package:flutter/material.dart';
import 'package:ipengine/features/presentation/widgets/theme/style.dart';

class TaskTypeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Authentication",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 10,
        ),
        RichText(
          text: TextSpan(
              style: TextStyle(fontSize: 14, color: color555555),
              children: [
                TextSpan(text: "It is necessary to authenticate all requests."),
              ]),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: btnBgColor.withOpacity(.4),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: RichText(
              text: TextSpan(
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    TextSpan(
                      text: "\$ ",
                    ),
                    TextSpan(
                        text:
                            'curl --location --request GET "https://api.ipengine.dev/ip/8.8.8.8" --header "key: value"'),
                  ]),
            )),
      ],
    );
  }
}
