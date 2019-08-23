import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yuque/json/group_repository_bean.dart';
import 'package:yuque/json/local_repolist_bean.dart';
import 'package:yuque/json/user_groups_bean.dart';
import 'package:yuque/logic/main_page_logic.dart';
import 'package:yuque/pages/provider_pages.dart';
import 'package:yuque/utils/check_update_util.dart';
import 'package:yuque/widget/loading_widget.dart';
//import 'package:flutter_bugly/flutter_bugly.dart';

class MainPageModel extends ChangeNotifier {
  MainPageLogic logic;
  BuildContext context;
  LoadingFlag groupLoadingFlag = LoadingFlag.loading;
  LoadingFlag personRepoLoadingFlag = LoadingFlag.loading;
  bool isEditing = false;
  int currentExplosionWidget = -99;
  List<UserGroupListBean> groupsBeans = [];
  List<GroupRepoListBean> personRepoBeans = [];
  List<LocalRepoListBean> deleteChooseList = [];
  List<bool> deleteCheckList = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final refreshController = RefreshController();

  MainPageModel() {
    logic = MainPageLogic(this);
  }

  @override
  void dispose() {
    super.dispose();
    // refreshController.dispose();
    scaffoldKey?.currentState?.dispose();
    debugPrint("MainPageEvent销毁了");
  }

  void notifyMessagePush(notify) {
    var extras;
    if (Platform.isAndroid) {
      var extra = notify['extras'];
      var result = extra['cn.jpush.android.EXTRA'];
      extras = jsonDecode(result);
    } else {
      extras = notify['extras'];
    }
    String title = extras['title'];
    String slug = extras['slug'];
    String nameSpace = extras['nameSpace'];
    print("分别是:$title\n$slug\n$nameSpace");
    Navigator.of(context).push(
      new CupertinoPageRoute(
        builder: (context) {
          return ProviderPages.getInstance()
              .getArticleDetailPage(title, slug, nameSpace);
        },
      ),
    );
  }

  void refresh() {
    notifyListeners();
  }

  void setContext(BuildContext context) {
    if (this.context == null) {
      //未启动App，点击推送
      JPush().getLaunchAppNotification().then((notify) {
        if (notify['extras'] != null) {
          print('首次打开==$notify');
          notifyMessagePush(notify);
        }
      });

      logic.getGroups();
      logic.getPersonRepos();
      CheckUpdateUtil().checkUpdate(context);
      JPush().addEventHandler(onReceiveMessage: (notify) {
        debugPrint("收到信息:$notify");
        // notifyMessagePush(notify);
      }, onReceiveNotification: (notify) {
        debugPrint("收到通知内容:${notify}");
        if (Platform.isIOS) {
          var content = notify['aps']['alert'];
          var extras = notify['extras'];
          String title = extras['title'];
          String slug = extras['slug'];
          String nameSpace = extras['nameSpace'];

          scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).primaryColor,
            // duration: Duration(seconds: 2),
            content: CupertinoButton(
              child: Text(
                content,
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  new CupertinoPageRoute(
                    builder: (context) {
                      return ProviderPages.getInstance()
                          .getArticleDetailPage(title, slug, nameSpace);
                    },
                  ),
                );
              },
            ),
          ));
        }

        // notifyMessagePush(notify);
      }, onOpenNotification: (notify) {
        print('点击推送--$notify');
        notifyMessagePush(notify);
      });

      this.context = context;
    }
  }

  void setGroupLoadingFlag(LoadingFlag flag) {
    if (this.groupLoadingFlag != flag) {
      this.groupLoadingFlag = flag;
      notifyListeners();
    }
  }

  void setPersonRepoLoadingFlag(LoadingFlag flag) {
    if (this.personRepoLoadingFlag != flag) {
      this.personRepoLoadingFlag = flag;
      notifyListeners();
    }
  }
}
