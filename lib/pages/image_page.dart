import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math';

class ImagePage extends StatelessWidget {

  final String imageUrl;
  final bool isNetwork;


  ImagePage(this.imageUrl, {this.isNetwork = true});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            PhotoView(
              onTapUp: (ctx,details,value){
                debugPrint("up：${details}");
                Navigator.of(context).pop();
              },
              imageProvider: isNetwork? CachedNetworkImageProvider(imageUrl) : AssetImage(imageUrl),
            ),
            Align(
              alignment: Alignment(0,0.8),
              child: IconButton(icon: Icon(Icons.cancel, color: Colors.white70,size: 35,), onPressed: (){
                Navigator.of(context).pop();
              }),
            )
          ],
        )
    );
  }
}


class StfImagePage extends StatefulWidget {

  final String imageUrl;


  StfImagePage(this.imageUrl);

  @override
  _StfImagePageState createState() => _StfImagePageState();
}

class _StfImagePageState extends State<StfImagePage> {

  PhotoViewScaleState _state = PhotoViewScaleState.initial;
  bool isDragging = false;
  PhotoViewController controller;


  @override
  void initState() {
    super.initState();
    controller = PhotoViewController();
    controller.addIgnorableListener((){
      debugPrint("ignore");
    });
    controller.outputStateStream.listen((value){
      debugPrint("value:${value}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: PhotoView(
              controller: controller,
              scaleStateChangedCallback: (state){
                debugPrint("当前state：${state.index}");
                setState(() {
                  _state = state;
                });
              },
              imageProvider: CachedNetworkImageProvider(widget.imageUrl),
            ),
          ),
          Align(
            alignment: Alignment(0,0.8),
            child: IconButton(icon: Icon(Icons.cancel, color: Colors.white70,size: 35,), onPressed: (){
              Navigator.of(context).pop();
            }),
          )
        ],
      )
//      Draggable(
//        onDragEnd: (detail){
//          if(detail.offset.dx.abs() > 100 || detail.offset.dy.abs() > 100){
//            Navigator.of(context).pop();
//            isDragging = false;
//          } else{
//            isDragging = false;
//            setState(() {
//
//            });
//          }
//          debugPrint("结束x:${detail.offset.dx}  y:${detail.offset.dy}");
//        },
//        onDragStarted: (){
//          isDragging = true;
//          setState(() {
//
//          });
//          debugPrint("开始");
//        },
//        maxSimultaneousDrags: getDragFlag(),
//        feedback: Container(
//          width: MediaQuery.of(context).size.width,
//          height: MediaQuery.of(context).size.height,
//          alignment: Alignment.center,
//          child: CachedNetworkImage(imageUrl: widget.imageUrl,),
//        ),
//        childWhenDragging: Container(),
//        child: !isDragging? Stack(
//          children: <Widget>[
//            Container(
//              width: MediaQuery.of(context).size.width,
//              height: MediaQuery.of(context).size.height,
//              child: PhotoView(
//                scaleStateChangedCallback: (state){
//                  setState(() {
//                    _state = state;
//                  });
//                },
//                imageProvider: CachedNetworkImageProvider(widget.imageUrl),
//              ),
//            ),
//            Align(
//              alignment: Alignment(0,0.8),
//              child: IconButton(icon: Icon(Icons.cancel, color: Colors.white70,size: 35,), onPressed: (){
//                Navigator.of(context).pop();
//              }),
//            )
//          ],
//        ):Container()
//      ),
    );
  }

  int getDragFlag(){
    int flag = _state == PhotoViewScaleState.initial?1:0;
    debugPrint("flag是${flag}");
    return flag;
  }
}
