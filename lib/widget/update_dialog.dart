import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yuque/public/NetManager.dart';
import 'package:open_file/open_file.dart';

class UpdateDialog extends StatefulWidget {
  final String version;
  final String updateInfo;
  final String updateUrl;
  final bool isForce;

  UpdateDialog({
    this.version,
    this.updateInfo,
    this.updateUrl,
    this.isForce = false,
  });

  @override
  State<StatefulWidget> createState() => new UpdateDialogState();
}

class UpdateDialogState extends State<UpdateDialog> {
  int _downloadProgress = 0;
  NetManager manager;
  CancelToken token;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        margin: EdgeInsets.only(left: 50, right: 50, top: 200, bottom: 200),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                  margin: EdgeInsets.fromLTRB(5, 30, 5, 5),
                  child: Material(
                    child: Text(
                      "新版本来啦!",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Colors.transparent,
                  )),
            ),
            Expanded(
                flex: 5,
                child: Container(
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    child: Material(
                      color: Colors.transparent,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          widget.updateInfo,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ))),
            _downloadProgress != 0
                ? Expanded(
                    child: Container(
                      child: LinearProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.orange),
                        backgroundColor: Colors.grey[300],
                        value: _downloadProgress / 100, //精确模式，进度20%
                      ),
                    ),
                    flex: 1,
                  )
                : SizedBox(),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: Colors.white,
                ),
                child: Row(
                  children: <Widget>[
                    !widget.isForce
                        ? Expanded(
                            flex: 1,
                            child: FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "取消",
                                  style: TextStyle(color: Colors.grey,fontSize: 16),
                                )),
                          )
                        : SizedBox(),
                    !widget.isForce
                        ? Container(
                            width: 1,
                            color: Colors.grey[100],
                          )
                        : SizedBox(),
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                          onPressed: () async {
                            if (Platform.isAndroid) {
                              _androidUpdate();
                            } else if (Platform.isIOS) {
                              _iosUpdate();
                            }
                          },
                          child: Text(
                            "升级",
                            style: TextStyle(color: Colors.black,fontSize: 16),
                          )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _androidUpdate() async {
    String path = (await getExternalStorageDirectory()).path;
    debugPrint("获取的目录:${path}");
    manager.download(widget.updateUrl, path + "/Download/" + "release.apk",
        cancelToken: token, onReceiveProgress: (int count, int total) {
      setState(() {
        _downloadProgress = ((count / total) * 100).toInt();
        if (_downloadProgress == 100) {
          debugPrint("读取的目录:${path}");
          try {
            OpenFile.open(path + "/Download/" + "release.apk");
          } catch (e) {}
          Navigator.of(context).pop();
        }
      });
    });
  }

  void _iosUpdate(){
    launch(widget.updateUrl);
  }



  @override
  void initState() {
    super.initState();
    manager = NetManager();
    token = new CancelToken();
  }

  @override
  void dispose() {
    super.dispose();
    token?.cancel();
    manager?.clear();
    debugPrint("升级销毁");
  }
}
