import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:yuque/pages/all_pages.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("关于"),),
      body: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.supervised_user_circle, color: Theme.of(context).primaryColor,),
              title: Text("关于我们"),
              trailing: Icon(Icons.keyboard_arrow_right,),
              onTap: (){
                Navigator.of(context).push(new CupertinoPageRoute(builder: (ctx){
                  return WebViewPage("https://femessage.github.io/blog/", title: "关于我们",);
                }));
              },
            ),
            ListTile(
              leading: Icon(Platform.isAndroid?Icons.android:FontAwesomeIcons.apple, color: Theme.of(context).primaryColor,),
              title: Text("版本信息"),
              trailing: Icon(Icons.keyboard_arrow_right,),
              onTap: (){
                Navigator.of(context).push(new CupertinoPageRoute(builder: (ctx){
                  return VersionPage();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
