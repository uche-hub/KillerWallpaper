import 'package:flutter/material.dart';

Widget brandName(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Killer Wallpaper"
      ),
      Text(
        "4HD",
        style: TextStyle(
            color: Color(0xff00c2cb)
        ),
      )
    ],
  );
}