import 'package:flutter/material.dart';
import 'package:killer_wallpaper/views/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Killer Wallpaper',
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      home: SplashScreen(),
    );
  }
}
