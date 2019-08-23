import 'package:flutter/material.dart';
import 'package:yuque/model/repository_page_event.dart';
import 'package:yuque/json/group_repository_bean.dart';
import 'package:yuque/json/local_repolist_bean.dart';
import 'package:yuque/public/api_service.dart';
import 'package:yuque/utils/shared_util.dart';
import 'package:yuque/widget/loading_widget.dart';

class RepositoryPageLogic{

  final RepositoryPageModel _model;

  RepositoryPageLogic(this._model);
  
  void getRepoList() async{
    _model.setLoadingFlag(LoadingFlag.loading);
    String token = await SharedUtil.instance.getString(Keys.xToken);
    ApiService.getInstance().getGroupRepo(token, _model.groupId, (data){
      GroupRepositoryBean bean = GroupRepositoryBean.fromMap(data);
      _model.dataList.clear();
      _model.dataList.addAll(bean.data);
      _model.loadingFlag = LoadingFlag.success;
      _model.refresh();
    }, (msg){
      _model?.setLoadingFlag(LoadingFlag.error);
      _model?.scaffoldKey?.currentState?.showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            "出错了  -.-",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          )));
    });
  }


  void repoListReadAndSave(String teamName, String repositoryName, String nameSpace, String groupLoginId, String groupAvatar) async{
    LocalRepoListBean repoListBean = LocalRepoListBean(
        teamName: teamName,
        repoName: repositoryName,
        nameSpace: nameSpace,
        groupLoginId: groupLoginId,
        groupAvatarUrl: groupAvatar,
        articleBeans: [],
    );
    List<String> stringList = await SharedUtil().getListWithToken(Keys.recentRepo)??[];
    List<LocalRepoListBean> repoLists = LocalRepoListBean.fromStringList(stringList);

    if(!LocalRepoListBean.containsRepoByNameSpace(repoListBean, repoLists)){
      repoLists.add(repoListBean);
    }
    List<String> newStringList =  LocalRepoListBean.fromBeanList(repoLists);
    SharedUtil().saveListWithToken(Keys.recentRepo, newStringList);
  }



}