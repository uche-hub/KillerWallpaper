import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageView extends StatefulWidget {

  final String imgUrl;
  ImageView({@required this.imgUrl});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  var filePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.imgUrl,
            child: Container(
              height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.network(widget.imgUrl, fit: BoxFit.cover,)),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){
                    _save();
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xff1c1b1b).withOpacity(0.8),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width/2,
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white54, width: 1),
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                                colors: [
                                  Color(0x36ffffff),
                                  Color(0x0fffffff)
                                ]
                            )
                        ),
                        child: Column(
                          children: [
                            Text("Save Wallpaper",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70
                              ),
                            ),
                            Text("Image will be saved in gallery",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white70
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16,),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel", style: TextStyle(
                    color: Colors.white
                  ),
                  ),
                ),
                SizedBox(height: 50,)
              ],
            ),
          )
        ],
      ),
    );
  }

  _save() async {
    if(Platform.isAndroid){
      await _askPermission();
    }
    var response = await Dio().get(widget.imgUrl,
        options: Options(responseType: ResponseType.bytes));
    final result =
    await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    Fluttertoast.showToast(
      msg: result,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.black,
    );
    Navigator.pop(context);
  }

  // void showToast(){
  //   Fluttertoast.showToast(
  //     msg: text,
  //     toastLength: Toast.LENGTH_LONG,
  //     gravity: ToastGravity.BOTTOM,
  //     timeInSecForIosWeb: 5,
  //     backgroundColor: Colors.black,
  //   );
  // }

  _askPermission() async {
    PermissionStatus status = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    if(status != PermissionStatus.granted){
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    }
  }
}
