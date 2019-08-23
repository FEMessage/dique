//navigation的头
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yuque/pages/image_page.dart';
import 'package:yuque/pages/version_page.dart';
import 'package:yuque/pages/webview_page.dart';
import 'package:yuque/utils/check_update_util.dart';
import 'package:yuque/utils/shared_util.dart';
//import 'package:flutter_bugly/flutter_bugly.dart';

class NavHeader extends StatelessWidget {
  final Widget exitWidget;

  @override
  Widget build(BuildContext context) {

    return Stack(children: <Widget>[
      new Container(
        width: 500,
        height: MediaQuery.of(context).size.height,
        child: new FlareActor(
          "flrs/bg_head.flr",
          animation: "move",
          fit: BoxFit.cover,
        ),
      ),
      ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.transparent),
              accountName: FutureBuilder(
                  future: SharedUtil.instance.getString(Keys.username),
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? "...",
                      style: TextStyle(fontSize: 10, color: Colors.black54),
                    );
                  }),
              accountEmail: FutureBuilder(
                  future: SharedUtil.instance.getString(Keys.userId),
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? "...",
                      style: TextStyle(fontSize: 10, color: Colors.black54),
                    );
                  }),
            currentAccountPicture: ClipRRect(
              borderRadius: BorderRadius.circular(40.0),
              child: FutureBuilder(
                  future: SharedUtil.instance.getString(Keys.userAvatarUrl),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(new MaterialPageRoute(builder: (ctx){
                          return ImagePage(snapshot.data);
                        }));
                      },
                      child: CachedNetworkImage(
                          imageUrl: snapshot.data,
                          placeholder: (context, url) =>
                          new CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor),
                          ),
                          errorWidget: (context, url, error) => new Icon(
                            Icons.error,
                            color: Colors.redAccent,
                          )),
                    )
                        : CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                    );
                  }),
            ),

          ),
//          ListTile(
//            leading: Icon(Icons.feedback, color: Theme.of(context).primaryColorLight,),
//            title: Text("意见反馈",),
//            trailing: Icon(Icons.keyboard_arrow_right),
//            onTap: (){
//              Navigator.of(context).push( new CupertinoPageRoute(builder: (context){
//                return FeedbackPage();
//              }));
//            },
//          ),
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
      Positioned(
        right: 16,
        bottom: 16,
        child: exitWidget,
      ),
    ]);
  }

  NavHeader(this.exitWidget);

}
