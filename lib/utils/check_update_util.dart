import 'dart:io';

import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:yuque/json/check_update_bean.dart';
import 'package:yuque/public/api_service.dart';
import 'package:yuque/utils/shared_util.dart';
import 'package:yuque/widget/loading_dialog.dart';
import 'package:yuque/widget/update_dialog.dart';

class CheckUpdateUtil {


  Future checkUpdate(BuildContext context,{bool isManual = false}) async {


    if(isManual){
      showDialog(context: context, builder: (ctx){
        return LoadingDialog();
      });
    } else{
      String token = await SharedUtil.instance.getString(Keys.xToken);
      ApiService.getInstance().getCheckUpdate(token,(data) async {
        CheckUpdateBean bean = CheckUpdateBean.fromMap(data);
        print('看看更新的数据-->$data');

        int cloudAndroidVersion = int.parse((bean?.android?.version??"0").replaceAll(".", ""));
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        int localVersion = int.parse(packageInfo.version.replaceAll(".", ""));
        if(cloudAndroidVersion > localVersion){
          if(Platform.isAndroid){
            _showUpdateDialog(bean?.android?.version??"", bean.android.content, bean.android.downloadLink, bean.android.isForceUpdate == 1, context);
          } else if(Platform.isIOS){
            _showUpdateDialog(bean?.ios?.version??"", bean.ios.content, bean.ios.downloadLink, bean.ios.isForceUpdate == 1, context);
          }
        }
      }, (msg){
        debugPrint("${msg}");
      });
    }

  }


  _showUpdateDialog(String version, String updateInfo, String url,
      bool isForceUpgrade, BuildContext context) {
    showDialog(
        context: context,
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
