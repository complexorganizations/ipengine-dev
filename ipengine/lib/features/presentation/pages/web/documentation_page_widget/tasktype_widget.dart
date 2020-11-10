import 'package:flutter/material.dart';
import 'package:ipengine/features/presentation/widgets/theme/style.dart';

class TaskTypeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "JSONP/ CORS Requests",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 10,
        ),
        RichText(
          text: TextSpan(
              style: TextStyle(fontSize: 14, color: color555555),
              children: [
                TextSpan(
                    text:
                        "JSONP and CORS are supported, allowing you to use ipinfo.io entirely in client-side code. For JSONP you just need to specify the callback parameter, e.g.  "),
                TextSpan(
                    text: "http://ipinfo.io/?callback=callback&token=\$TOKEN",
                    style: TextStyle(
                        backgroundColor: Colors.blue[100],
                        decoration: TextDecoration.underline,
                        color: Colors.red[300])),
                TextSpan(
                    text: " to the request URLs to make the requests secure.")
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
                      text: "\$.",
                    ),
                    TextSpan(
                        text: "get",
                        style: TextStyle(fontSize: 14, color: Colors.red)),
                    TextSpan(
                        text:
                            '("https://ipinfo.io?token=\$TOKEN", function(response) {'),
                    TextSpan(
                        text: "console",
                        style: TextStyle(
                            fontSize: 14, color: Colors.yellowAccent)),
                    TextSpan(
                      text: ".log(response.ip, response.country);}, ",
                    ),
                    TextSpan(
                        text: '"jsonp"',
                        style: TextStyle(fontSize: 14, color: Colors.green)),
                    TextSpan(
                      text: ")",
                    ),
                  ]),
            )),
      ],
    );
  }
}
