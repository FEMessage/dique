import 'dart:io';

import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:yuque/json/check_update_bean.dart';
import 'package:yuque/public/api_service.dart';
import 'package:yuque/utils/shared_util.dart';
import 'package:yuque/widget/update_dialog.dart';
import 'loading_widget.dart';

class LoadingDialog extends StatefulWidget {
  @override
  _LoadingDialogState createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {

  LoadingFlag  checkUpdateFlag = LoadingFlag.loading;
  bool isLatest = false;



  @override
  void initState() {
    super.initState();
    _checkUpdate();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.fromLTRB(width/5, height/4, width/5, height/4),
      child: Card(
          child: !isLatest? LoadingWidget(
            text: "更新检测中...",
            errorText: "重新检测",
            flag: checkUpdateFlag,
            errorCallBack: (){
              _checkUpdate();
            },
          ) : Center(
            child: Text("已是最新版本"),
          )
      )
    );
  }

  Future _checkUpdate() async {
    setState(() {
      checkUpdateFlag = LoadingFlag.loading;
    });
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    debugPrint("当前版本:${packageInfo.version}");
    String token = await SharedUtil.instance.getString(Keys.xToken);
    ApiService.getInstance().getCheckUpdate(token, (data) async {
      CheckUpdateBean bean = CheckUpdateBean.fromMap(data);
      int cloudAndroidVersion = int.parse((bean?.android?.version??"0").replaceAll(".", ""));
      int localVersion = int.parse(packageInfo.version.replaceAll(".", ""));
      if(cloudAndroidVersion > localVersion){
        Navigator.of(context).pop();
        if(Platform.isAndroid){
          _showUpdateDialog(bean?.android?.version??"", bean.android.content, bean.android.downloadLink, bean.android.isForceUpdate == 0, context);
        } else if(Platform.isIOS){
          _showUpdateDialog(bean?.ios?.version??"", bean.ios.content, bean.ios.downloadLink, bean.ios.isForceUpdate == 0, context);
        }
      } else {
        setState(() {
          isLatest = true;
        });
        Future.delayed(Duration(milliseconds: 500), (){
          if(context != null){
            Navigator.of(context).pop();
          }
        });
      }
    }, (msg){
      debugPrint("${msg}");
      setState(() {
        checkUpdateFlag = LoadingFlag.error;
      });
    });
  }

  _showUpdateDialog(String version, String updateInfo, String url,
      bool isForceUpgrade, BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return UpdateDialog(
            version: version,
            updateInfo: updateInfo,
            updateUrl: url,
            isForce: isForceUpgrade,
          );
        });
  }
}
