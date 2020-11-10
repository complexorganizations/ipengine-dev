import 'package:flutter/material.dart';
import 'package:ipengine/features/presentation/widgets/theme/style.dart';

class FirstTimeUsingApiWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "IP Address Parameter",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        RichText(
          text: TextSpan(style: TextStyle(fontSize: 14,color: color555555),children: [
            TextSpan(
                text:
                    "The quickest and easiest way to get started with IPinfo is to use one of our "),
            TextSpan(
                text: "official libraries",
                style: TextStyle(
                    decoration: TextDecoration.underline, color: Colors.blue)),
            TextSpan(
                text:
                    "which are available for many popular programming languages and frameworks. If you'd like to write your own library or interact directly with our API then the documentation below can help you.")
          ]),
        ),
        SizedBox(height: 10,),
        Text(
          "Authentication",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10,),
        Text(
            'Your API token is used to authenticate you with our API, and can be provided either as an HTTP Basic Auth username, a bearer token, or alternatively as a token URL parameter.'),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: btnBgColor.withOpacity(.4),
            borderRadius: BorderRadius.all(Radius.circular(8),),
          ),
          child: Text("""
              # With Basic Auth
              \$ curl -u \$TOKEN: ipinfo.io
              
              # With Bearer token
              \$ curl -H "Authorization: Bearer \$TOKEN" ipinfo.io
              
              # With token query parameter
              \$ curl ipinfo.io?token=\$TOKEN
          """,style: TextStyle(color: Colors.black),),
        ),
        SizedBox(height: 10,),

        Text("It's also possible to use the API without authentication in a more limited capacity.")
      ],
    );
  }
}
