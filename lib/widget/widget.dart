import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:killer_wallpaper/model/wallpaper_model.dart';
import 'package:killer_wallpaper/views/image_view.dart';

Widget brandName(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          children: <TextSpan>[
            TextSpan(text: 'Killer Wallpaper', style: TextStyle(color: Color(0xff000000))),
            TextSpan(text: '4HD', style: TextStyle(color: Color(0xff00c2cb))),
          ],
        ),
      ),
    ],
  );
}

Widget wallpaperList({List<WallpaperModel> wallpapers, context}){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper){
        return GridTile(
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => ImageView(
                  imgUrl: wallpaper.src.portrait,
                )
              ));
            },
            child: Hero(
              tag: wallpaper.src.portrait,
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                    child: Image.network(wallpaper.src.portrait, fit: BoxFit.cover,)),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}