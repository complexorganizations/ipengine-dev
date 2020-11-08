import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void push({BuildContext context, Widget child}) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => child));
}
