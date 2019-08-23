import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yuque/model/main_page_event.dart';
import 'package:yuque/json/group_repository_bean.dart';
import 'package:yuque/json/local_repolist_bean.dart';
import 'package:yuque/json/user_groups_bean.dart';
import 'package:yuque/pages/provider_pages.dart';
import 'package:yuque/public/api_service.dart';
import 'package:yuque/utils/toast_util.dart';
import 'package:yuque/utils/shared_util.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:yuque/widget/explosion_widget.dart';
import 'package:yuque/widget/hide_anim_widget.dart';
import 'package:yuque/widget/loading_widget.dart';
import 'package:yuque/widget/top_show_widget.dart';

class MainPageLogic {
  final MainPageModel _model;

  MainPageLogic(this._model);

  void getGroups() async {
    String token = await SharedUtil.instance.getString(Keys.xToken);
    String userId = await SharedUtil.instance.getString(Keys.userId);
    _model.setGroupLoadingFlag(LoadingFlag.loading);
    debugPrint("处理数据：${userId}");
    ApiService.getInstance().getUserGroups(token, userId, (data) {
      UserGroupsBean bean = UserGroupsBean.fromMap(data);
      _model.groupsBeans.clear();
      _model.groupsBeans.addAll(bean.data);
      if (_model.groupsBeans.length == 0) {
        _model.groupLoadingFlag = LoadingFlag.empty;
      } else {
        _model.groupLoadingFlag = LoadingFlag.success;
      }
      List<String> groupTag = [];
      for (var o in _model.groupsBeans) {
        groupTag.add(o.id.toString());
        print("tag是:${groupTag}");
      }

      JPush().resumePush();
      JPush().setTags(groupTag);

      if (_model.personRepoLoadingFlag == LoadingFlag.success ||
          _model.personRepoLoadingFlag == LoadingFlag.empty) {
        _model.refreshController.refreshCompleted();
      }
      _model.refresh();
    }, (errorMsg) {
      _model.setGroupLoadingFlag(LoadingFlag.error);
      _model.refreshController.refreshCompleted();
      _model.scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            "出错了  -.-",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          )));
    });
  }

  void getPersonRepos() async {
    String token = await SharedUtil.instance.getString(Keys.xToken);
    String userId = await SharedUtil.instance.getString(Keys.userId);
    _model.setPersonRepoLoadingFlag(LoadingFlag.loading);
    debugPrint("处理数据：${userId}");
    ApiService.getInstance().getPersonRepo(token, userId, (data) {
      GroupRepositoryBean bean = GroupRepositoryBean.fromMap(data);
      _model.personRepoBeans.clear();
      _model.personRepoBeans.addAll(bean.data);
//      List<String> personRepoTag = [];
//      for (var o in _event.groupsBeans) {
//        personRepoTag.add(o.id.toString());
//        print("个人仓库tag是:${o.id}");
//      }
//      JPush().setTags(personRepoTag);
      _model.personRepoLoadingFlag = LoadingFlag.success;
      if (_model.personRepoBeans.length == 0) {
        _model.personRepoLoadingFlag = LoadingFlag.empty;
      } else {
        _model.personRepoLoadingFlag = LoadingFlag.success;
      }
      if (_model.groupLoadingFlag == LoadingFlag.success ||
          _model.groupLoadingFlag == LoadingFlag.empty) {
        _model.refreshController.refreshCompleted();
      }
      _model.refresh();
    }, (errorMsg) {
      _model.setPersonRepoLoadingFlag(LoadingFlag.error);
      _model.refreshController.refreshCompleted();
      _model.scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            "出错了  -.-",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          )));
    });
  }

  Widget _getGroupsItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(new CupertinoPageRoute(builder: (context) {
          return ProviderPages.getInstance().getRepositoryPage(
              _model.groupsBeans[index].name,
              _model.groupsBeans[index].login,
              _model.groupsBeans[index].small_avatar_url);
        }));
      },
      child: Container(
        height: 100,
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 50,
              height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: CachedNetworkImage(
                    imageUrl: _model.groupsBeans[index].small_avatar_url,
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor),
                        ),
                    errorWidget: (context, url, error) => new Icon(
                          Icons.error,
                          color: Colors.redAccent,
                        )),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              _model.groupsBeans[index].name,
              style: TextStyle(
                fontSize: 10,
              ),
              maxLines: 1,
              overflow: TextOverflow.clip,
            )
          ],
        ),
      ),
    );
  }

  Widget _getLocalRepoItem(
      BuildContext context, LocalRepoListBean bean, int index) {
    return GestureDetector(
      onLongPress: () {
        _model.isEditing = true;
        _model.refresh();
        double width = MediaQuery.of(context).size.width;
        int num = (width / 2 / 40).toInt();
        debugPrint("宽度：${width}  个数:${(width / 2 / 40).toInt()}");
      },
      child: HideAnimWidget(
        start: _model.currentExplosionWidget == index,
        tag: index.toString(),
        onComplete: () async {
          _model.currentExplosionWidget = -99;
          final data = await SharedUtil().getListWithToken(Keys.recentRepo);
          List<LocalRepoListBean> beans =
              LocalRepoListBean.fromStringList(data);
          beans.removeAt(index);
          List<String> newStringList = LocalRepoListBean.fromBeanList(beans);
          SharedUtil().saveListWithToken(Keys.recentRepo, newStringList);
          _model.refresh();
        },
        child: Stack(
          children: <Widget>[
            AbsorbPointer(
              absorbing: _model.isEditing,
              child: Card(
                elevation: 5,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(new CupertinoPageRoute(builder: (context) {
                          return ProviderPages.getInstance()
                              .getArticlePage(bean.repoName, bean.nameSpace);
                        }));
                        debugPrint("点击仓库");
                      },
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 10, top: 5, bottom: 5, right: 5),
                              width: 20,
                              height: 20,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: CachedNetworkImage(
                                    imageUrl: bean.groupAvatarUrl,
                                    placeholder: (context, url) =>
                                        new CircularProgressIndicator(
                                          valueColor:
                                              new AlwaysStoppedAnimation<Color>(
                                                  Theme.of(context)
                                                      .primaryColor),
                                        ),
                                    errorWidget: (context, url, error) =>
                                        new Icon(
                                          Icons.error,
                                          color: Colors.redAccent,
                                        )),
                              ),
                            ),
                            flex: 2,
                          ),
                          Expanded(
                              flex: 8,
                              child: Container(
//                            padding: EdgeInsets.all(10),
                                child: Text(
                                  bean.repoName,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                      height: 1,
                      color: Colors.black12,
                    ),
                    Expanded(
                        child: bean.articleBeans.length > 0
                            ? ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: bean.articleBeans.length,
                                itemBuilder: (context, position) {
                                  final articleBea =
                                      bean.articleBeans[position];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          new CupertinoPageRoute(
                                              builder: (context) {
                                        return ProviderPages.getInstance()
                                            .getArticleDetailPage(
                                                articleBea.articleTitle,
                                                articleBea.articleSlug,
                                                articleBea.nameSpace,
                                                isFromMain: true);
                                      }));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                      child: Text(
                                        articleBea.articleTitle,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.7)),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        new CupertinoPageRoute(
                                            builder: (context) {
                                      return ProviderPages.getInstance()
                                          .getArticlePage(
                                              bean.repoName, bean.nameSpace);
                                    }));
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          height: 70,
                                          width: 70,
                                          child: FlareActor(
                                            "flrs/loading_bird.flr",
                                            animation: "loading",
                                            fit: BoxFit.cover,
                                          )),
                                      Text(
                                        "快去仓库看看吧",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                  ],
                ),
              ),
            ),
            _model.isEditing
                ? Container(
                    color: Colors.black.withOpacity(0.05),
                  )
                : SizedBox(),
            Opacity(
              opacity: _model.isEditing ? 1 : 0,
              child: Container(
                alignment: Alignment.bottomRight,
                margin: EdgeInsets.only(bottom: 10),
                child: IconButton(
                    icon: Icon(
                      Icons.vertical_align_top,
                      color: Colors.black,
                    ),
                    onPressed: _model.isEditing
                        ? () async {
                            final data = await SharedUtil()
                                .getListWithToken(Keys.recentRepo);
                            List<LocalRepoListBean> beans =
                                LocalRepoListBean.fromStringList(data);
                            final theBean = beans[index];
                            beans.removeAt(index);
                            beans.insert(0, theBean);
                            List<String> newStringList =
                                LocalRepoListBean.fromBeanList(beans);
                            SharedUtil().saveListWithToken(
                                Keys.recentRepo, newStringList);
                            _model.refresh();
                          }
                        : null),
              ),
            ),
            Opacity(
              opacity: _model.isEditing ? 1 : 0,
              child: Container(
                alignment: Alignment.topRight,
                child: IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.redAccent,
                    ),
                    onPressed: _model.isEditing
                        ? () async {
                            showDialog(
                                context: _model.context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('是否删除《${bean.repoName}》的浏览记录？'),
                                    actions: <Widget>[
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('取消')),
                                      FlatButton(
                                          onPressed: () {
                                            _model.currentExplosionWidget =
                                                index;
                                            _model.refresh();
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            '确定',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          )),
                                    ],
                                  );
                                });
                          }
                        : null),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getLocalRepo(List<LocalRepoListBean> beans) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //横轴2个// 子widget
          crossAxisSpacing: 1),
      padding: EdgeInsets.all(10),
      itemCount: beans.length,
      itemBuilder: (context, index) {
        return _getLocalRepoItem(context, beans[index], index);
      },
    );
  }

  Widget getGroupList() {
    return _model.groupLoadingFlag != LoadingFlag.success
        ? LoadingWidget(
            text: "团队列表获取中...",
            errorCallBack: getGroups,
            flag: _model.groupLoadingFlag,
          )
        : ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(10),
            itemCount: _model.groupsBeans.length,
            itemBuilder: (context, index) {
              return _getGroupsItem(context, index);
            },
          );
  }

  Widget getPersonalRepoList() {
    return _model.personRepoLoadingFlag != LoadingFlag.success
        ? LoadingWidget(
            text: "个人仓库获取中...",
            errorCallBack: getPersonRepos,
            flag: _model.personRepoLoadingFlag,
          )
        : ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(10),
            itemCount: _model.personRepoBeans.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(new CupertinoPageRoute(builder: (context) {
                    return ProviderPages.getInstance().getArticlePage(
                        _model.personRepoBeans[index].name,
                        _model.personRepoBeans[index].namespace);
                  }));
                },
                child: Container(
                  height: 50,
                  width: 100,
                  margin: EdgeInsets.all(5),
                  child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.8)),
                      child: Text(
                        "${_model.personRepoBeans[index].name}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                        maxLines: 3,
                      )),
                ),
              );
            },
          );
  }

  Widget getEditWidget() {
    return _model.isEditing
        ? FlatButton(
            onPressed: () {
              _model.isEditing = false;
              _model.refresh();
            },
            child: Text(
              "完成",
              style: TextStyle(color: Theme.of(_model.context).primaryColor),
            ),
          )
        : IconButton(
            onPressed: () {
              _model.isEditing = true;
              _model.refresh();
            },
            icon: Icon(
              Icons.border_color,
              color: Colors.black38,
              size: 16,
            ));
  }

  void popToLogin() {
    SharedUtil().saveBoolean(Keys.hasLogged, false);
    if (Platform.isAndroid) JPush().stopPush();
    Navigator.of(_model.context).pushAndRemoveUntil(
        new MaterialPageRoute(builder: (context) {
      return ProviderPages.getInstance().getLoginPage();
    }), (router) => router == null);
  }

  void onExitTap() {
    if (Platform.isAndroid) {
      showDialog(
          context: _model.context,
          builder: (context) {
            return AlertDialog(
              title: const Text('是否注销当前账号？'),
              content: const Text(
                '请三思',
              ),
              actions: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: FlatButton(
                      onPressed: popToLogin,
                      child: const Text(
                        '确定',
                        style: TextStyle(color: Colors.grey),
                      )),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('取消')),
                ),
              ],
            );
          });
    } else {
      showCupertinoDialog(
          context: _model.context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Text('是否注销当前账号？'),
              content: const Text(
                '请三思',
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  textStyle: TextStyle(color: Colors.grey),
                  child: const Text('确定'),
                  onPressed: () {
                    // Navigator.pop(context);
                    popToLogin();
                  },
                ),
                CupertinoDialogAction(
                  child: const Text('取消'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    }
  }

  void hideRepository() async {
    bool isHiding = await SharedUtil().getBoolean(Keys.hideRepository) ?? false;
    SharedUtil().saveBoolean(Keys.hideRepository, !isHiding);
    _model.refresh();
  }

  void hideGroups() async {
    bool isHiding = await SharedUtil().getBoolean(Keys.hideGroups) ?? false;
    SharedUtil().saveBoolean(Keys.hideGroups, !isHiding);
    _model.refresh();
  }

  void showOverlay() {
    final size = MediaQuery.of(_model.context).size;
    Widget child = Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: size.width,
        height: 100,
        margin: EdgeInsets.fromLTRB(10, 100, 10, 0),
        child: Card(
          elevation: 10,
          child: Container(
            alignment: Alignment.center,
              child: Text(
            'aaaaaa',
            textAlign: TextAlign.center,
          )),
        ),
      ),
    );
    ToastUtil.getInstance().show(_model.context,
        showWidget: TopAnimationShowWidget(
          child: child,
          distanceY: 100,
        ),duration: Duration(seconds: 4));
  }
}
