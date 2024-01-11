import 'package:flutter/material.dart';

showSnackBar({required BuildContext context,required String text}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: Duration(seconds: 3),
    content: Text(text),
    action: SnackBarAction(label: "close", onPressed: () {}),
  ));
}
