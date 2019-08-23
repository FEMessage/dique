import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:yuque/widget/loading_widget.dart';
import 'dart:io';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  WebViewPage(this.url, {this.title});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  FlutterWebviewPlugin flutterWebviewPlugin;


  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin = new FlutterWebviewPlugin();

  }


  @override
  void dispose() {
    super.dispose();
    flutterWebviewPlugin.dispose();

  }

  @override
  Widget build(BuildContext context) {
    flutterWebviewPlugin.onProgressChanged.listen((value){
      if (value==1) {
        flutterWebviewPlugin.show();
      }
    });
    return WillPopScope(
      onWillPop: (){
        flutterWebviewPlugin.close().then((a){
          Navigator.of(context).pop();
        });
      },
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title??widget.url, overflow: TextOverflow.ellipsis,),
          leading: IconButton(icon: Platform.isIOS?Icon(Icons.arrow_back_ios):Icon(Icons.arrow_back), onPressed: (){
            flutterWebviewPlugin.close().then((a){
              Navigator.of(context).pop();
            });
          }),
        ),
        body: WebviewScaffold(
          url: widget.url,
          hidden: true,
          initialChild: Center(
            child: LoadingWidget(
              text: widget.title == null?"网页加载中...":"请稍后...",
              errorCallBack: (){
                flutterWebviewPlugin.reload();
              },
            ),
          ),
        ),
      ),
    );
  }
}
