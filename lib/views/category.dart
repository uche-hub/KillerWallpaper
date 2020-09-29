import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:killer_wallpaper/data/data.dart';
import 'package:killer_wallpaper/model/wallpaper_model.dart';
import 'package:killer_wallpaper/widget/widget.dart';

class Categories extends StatefulWidget {

  final String categoryName;
  Categories({this.categoryName});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  List<WallpaperModel> wallpapers = new List();

  getSearchWallpaper(String query) async{
    var response = await http.get("https://api.pexels.com/v1/search?query=$query&per_page=500&page=1",
        headers: {
          "Authorization" : apiKey}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element){
        //print(element);
        WallpaperModel wallpaperModel = new WallpaperModel();
        wallpaperModel = WallpaperModel.fromMap(element);
        wallpapers.add(wallpaperModel);
      });

      setState(() {});
    });

    // print(response.body.toString())

  }

  @override
  void initState() {
    getSearchWallpaper(widget.categoryName);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 16,),
              wallpaperList(wallpapers: wallpapers, context: context)
            ],
          ),
        ),
      ),
    );
  }
}
