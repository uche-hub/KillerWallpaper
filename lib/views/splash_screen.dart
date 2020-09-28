import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  startTimer() async{
    var duration = Duration(seconds: 4);
    return Timer(duration, route);
  }

  route(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset("assets/images/k.png"),
            ),
            Text(
              "Killer Wallpaper 4HD",
              style: TextStyle(
                fontSize: 25,
                color: Color(0xff00c2cb)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
