import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatWithUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 264,
      height: 51,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: const Color(0x1a000000),
              offset: Offset(5, 5),
              blurRadius: 20,
              spreadRadius: 0)
        ],
        color: const Color(0xffffffff),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 22.0),
            child: Container(
              width: 140,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Chat with us...',
                  border: InputBorder.none,
                ),
                style: GoogleFonts.montserrat(
                  color: const Color(0xff999999),
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          Container(
            width: 51,
            height: 51,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              color: const Color(0xfff0864b),
            ),
            child: InkWell(
              onTap: () {},
              child: Icon(Icons.message_outlined),
            ),
          )
        ],
      ),
    );
  }
}
