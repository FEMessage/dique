import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yuque/model/main_page_event.dart';
import 'package:yuque/json/local_repolist_bean.dart';
import 'dart:math';
import 'package:yuque/utils/shared_util.dart';

import 'package:yuque/widget/nav_head.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MainPageModel>(context);
    model.setContext(context);
    return Scaffold(
      key: model.scaffoldKey,
      appBar: AppBar(
        title: Text("主页"),
        centerTitle: true,
      ),
      drawer: Drawer(
        elevation: 10,
        child: NavHeader(Transform.rotate(
          angle: pi,
          child: IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: 30,
              ),
              onPressed: model.logic.onExitTap),
        )),
      ),
      body: Container(
        child: SmartRefresher(
          
          onRefresh: (){
            Future.delayed(Duration(seconds: 1),(){
            model.logic.getGroups();
            model.logic.getPersonRepos();

            });
          },
          controller: model.refreshController,
          header: WaterDropHeader(
            waterDropColor: Theme.of(context).primaryColor,
          ),
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 15, top: 5),
                      child: Text(
                        "我的团队",
                        style: TextStyle(color: Colors.black45),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: FutureBuilder(
                        future: SharedUtil().getBoolean(Keys.hideGroups),
                        builder: (context, snapshot) {
                          final isHiding = snapshot.data ?? false;
                          return Container(
                            margin: EdgeInsets.only(right: 15),
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                icon: isHiding
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: Colors.grey,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                onPressed: model.logic.hideGroups),
                          );
                        }),
                  )
                ],
              ),
              FutureBuilder(
                  future: SharedUtil().getBoolean(Keys.hideGroups),
                  builder: (context, snapshot) {
                    final isHiding = snapshot.data ?? false;
                    return !isHiding
                        ? Container(
                            height: 100,
                            child: model.logic.getGroupList(),
                          )
                        : SizedBox(
                            height: 15,
                          );
                  }),
              Container(
                height: 4,
                color: Colors.black12,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 15, top: 5),
                      child: Text(
                        "我的仓库",
                        style: TextStyle(color: Colors.black45),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: FutureBuilder(
                        future: SharedUtil().getBoolean(Keys.hideRepository),
                        builder: (context, snapshot) {
                          final isHiding = snapshot.data ?? false;
                          return Container(
                            margin: EdgeInsets.only(right: 15),
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                icon: isHiding
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: Colors.grey,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                onPressed: model.logic.hideRepository),
                          );
                        }),
                  )
                ],
              ),
              FutureBuilder(
                  future: SharedUtil().getBoolean(Keys.hideRepository),
                  builder: (context, snapshot) {
                    final isHiding = snapshot.data ?? false;
                    return !isHiding
                        ? Container(
                            height: 100,
                            child: model.logic.getPersonalRepoList(),
                          )
                        : SizedBox(
                            height: 15,
                          );
                  }),
              
              Container(
                height: 4,
                color: Colors.black12,
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 15, top: 5),
                      child: Text("最近浏览的团队仓库",
                          style: TextStyle(color: Colors.black45)),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(
                            right: !model.isEditing ? 15 : 0, top: 5),
                        child: model.logic.getEditWidget()),
                  ),
                ],
              ),

              FutureBuilder(
                  future: SharedUtil().getListWithToken(Keys.recentRepo),
                  builder: (context, snapshot) {
//                    debugPrint("获取到的data是${snapshot.data}");
                    List<String> data = snapshot.data ?? [];
                    List<LocalRepoListBean> beans =
                        LocalRepoListBean.fromStringList(data);
                    if (model.deleteCheckList.length != beans.length) {
                      model.deleteCheckList.clear();
                      model.deleteCheckList
                          .addAll(List.generate(beans.length, (index) {
                        return false;
                      }));
                    }
                    return beans.length != 0
                        ? Container(
                            alignment: Alignment.center,
                            child: model.logic.getLocalRepo(beans),
                          )
                        : Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 2 -
                                    250),
                            child: Text(
                              "赶快去浏览文档吧!",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20),
                            ),
                          );
                  })
            
            ],
          ),
        ),
      ),
    );
  }
}
