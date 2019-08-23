import 'dart:io';

import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:yuque/utils/check_update_util.dart';

class VersionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("版本信息"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              margin: EdgeInsets.only(top: 100),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  child: Image.asset(
                    "images/bird.png",
                  )),
            ),
            SizedBox(height: 20,),
            FutureBuilder(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  PackageInfo info = snapshot.data;
                  return Column(
                    children: <Widget>[
                      Text(
                        "${info?.appName ?? "滴雀"}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        "${info?.version ?? "1.0.0"}",
                        style: TextStyle(fontSize: 12,),
                      ),
                    ],
                  );
                }),
            Container(
              margin: EdgeInsets.only(left: 30,right: 30,top: 5),
              height: 1,
              child: Divider(),
            ),
            Platform.isAndroid ? Container(
              margin: EdgeInsets.only(left: 30,right: 30),
              child: ListTile(
                leading: Icon(Icons.cloud_upload,color: Theme.of(context).primaryColor,),
                title: Text("检查更新"),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: (){
                  CheckUpdateUtil().checkUpdate(context, isManual: true);
                },
              ),
            ):SizedBox(),
            Container(
              margin: EdgeInsets.only(left: 30,right: 30,),
              height: 1,
              child: Divider(),
            ),
          ],
        ),
      ),
    );
  }
}
