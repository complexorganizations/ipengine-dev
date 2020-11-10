import 'package:flutter/material.dart';
import 'package:ipengine/features/presentation/widgets/theme/style.dart';

class KeyConceptWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Developers Guide",
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
                        "Our API is available over a secure HTTPS connection for all users, even on the free plan. Simply add "),
                TextSpan(
                    text: "https://",
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
          child: Text("""
             # Get details for your own IP address over HTTPS
              \$ curl https://ipinfo.io?token=\$TOKEN
          """),
        ),
      ],
    );
  }
}
