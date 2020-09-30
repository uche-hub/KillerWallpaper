import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:killer_wallpaper/data/data.dart';
import 'package:killer_wallpaper/model/wallpaper_model.dart';
import 'package:killer_wallpaper/widget/widget.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {

  final String searchQuery;
  Search({this.searchQuery});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<WallpaperModel> wallpapers = new List();

  TextEditingController searchController = new TextEditingController();

  getSearchWallpaper(String query) async{
    await http.get("https://api.pexels.com/v1/search?query=$query&per_page=30&page=1",
        headers: {
          "Authorization" : apiKey}).then((value) {

      // print(response.body.toString());

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element){
        //print(element);
        WallpaperModel wallpaperModel = new WallpaperModel();
        wallpaperModel = WallpaperModel.fromMap(element);
        wallpapers.add(wallpaperModel);
      });

      setState(() {});

    });


  }

  @override
  void initState() {
    getSearchWallpaper(widget.searchQuery);
    // TODO: implement initState
    super.initState();
    searchController.text = widget.searchQuery;
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
              Container(
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(30)
                ),
                padding: EdgeInsets.symmetric(horizontal: 24),
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            hintText: "Search Wallpaper",
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Search(
                              searchQuery: searchController.text,
                            )
                        ));
                      },
                      child: Container(
                          child: Icon(Icons.search)),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16,),
              wallpaperList(wallpapers: wallpapers, context: context)
            ],
          ),
        ),
      ),
    );
  }
}
