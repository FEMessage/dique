
import 'package:flutter/material.dart';
import 'package:yuque/model/article_page_event.dart';
import 'package:yuque/json/article_list_bean.dart';
import 'package:yuque/json/local_repolist_bean.dart';
import 'package:yuque/json/repo_directory_bean.dart';
import 'package:yuque/public/api_service.dart';
import 'package:yuque/utils/shared_util.dart';
import 'package:yuque/widget/loading_widget.dart';

class ArticlePageLogic{

  final ArticlePageModel _model;

  ArticlePageLogic(this._model);

  void getArticleList() async{
    _model.setLoadingFlag(LoadingFlag.loading);
    String token = await SharedUtil.instance.getString(Keys.xToken);
    ApiService.getInstance().getRepoArticles(token, _model.nameSpace, (data){
      ArticleListBean bean = ArticleListBean.fromMap(data);
      _model.articleList.clear();
      _model.articleList.addAll(bean.data);
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

  void getRepoDirList() async{
    _model.setLoadingFlag(LoadingFlag.loading);
    String token = await SharedUtil.instance.getString(Keys.xToken);
    ApiService.getInstance().getRepoDirectory(token, _model.nameSpace, (data){
      RepoDirectoryBean bean = RepoDirectoryBean.fromMap(data);
      _model.repoDirList.clear();
      _model.repoDirList.addAll(bean.data);
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


  void articleListPushAndSave(String title,String slug,String nameSpace,{int number}) async{
    List<String> stringList = await SharedUtil().getListWithToken(Keys.recentRepo)??[];
    List<LocalRepoListBean> repoLists = LocalRepoListBean.fromStringList(stringList);
    for (var i = 0; i < repoLists.length; i++) {
      if(repoLists[i].nameSpace == nameSpace){
        List<ArticleBean> articleBeans = List.from(repoLists[i].articleBeans);
        var articleBean = ArticleBean(articleTitle: title,articleSlug: slug,nameSpace: nameSpace);
        if(!LocalRepoListBean.containArticle(articleBean, articleBeans)){
          articleBeans.insert(0, articleBean);
        }
        if(articleBeans.length > number) articleBeans.removeRange(number - 1, articleBeans.length - 1);
        repoLists[i].articleBeans = articleBeans;
      }
    }

    List<String> newStringList =  LocalRepoListBean.fromBeanList(repoLists);
    SharedUtil().saveListWithToken(Keys.recentRepo, newStringList);
  }

}