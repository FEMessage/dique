import 'dart:convert';

class LocalRepoListBean {

  /**
   * teamName : "teamName"
   * repoName : "repoName"
   * groupLoginId : "groupLoginId"
   * groupAvatarUrl : "groupAvatarUrl"
   */

  String teamName;
  String repoName;
  String groupLoginId;
  String groupAvatarUrl;
  String nameSpace;
  List<ArticleBean> articleBeans;

  static LocalRepoListBean fromMap(Map<String, dynamic> map) {
    LocalRepoListBean local_repolist_bean = new LocalRepoListBean();
    local_repolist_bean.teamName = map['teamName'];
    local_repolist_bean.repoName = map['repoName'];
    local_repolist_bean.groupLoginId = map['groupLoginId'];
    local_repolist_bean.groupAvatarUrl = map['groupAvatarUrl'];
    local_repolist_bean.nameSpace = map['nameSpace'];
    local_repolist_bean.articleBeans = ArticleBean.fromMapList(map['articles']);
    return local_repolist_bean;
  }

  static List<LocalRepoListBean> fromMapList(dynamic mapList) {
    List<LocalRepoListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  LocalRepoListBean({this.teamName, this.repoName, this.groupLoginId,
    this.groupAvatarUrl, this.nameSpace, this.articleBeans});

 static List<LocalRepoListBean> fromStringList(List<String> repoList){
   List<LocalRepoListBean> list = new List(repoList.length);
   List<LocalRepoListBean> newList = List.from(list);
   for (int i = 0; i < repoList.length; i++) {
     var data = jsonDecode(repoList[i]);
     newList[i] = fromMap(data);
   }
   return newList;
 }

 static List<String> fromBeanList(List<LocalRepoListBean> beans){
   List<String> list = new List(beans.length);
   List<String> newList = List.from(list);
   for (int i = 0; i < beans.length; i++) {
     var data = toJson(beans[i]);
     newList[i] = jsonEncode(data);
   }
   return newList;
 }

 static bool containsRepoByNameSpace(LocalRepoListBean bean, List<LocalRepoListBean> beans){
   bool isContain = false;
   for(LocalRepoListBean repo in beans){
     if(bean.nameSpace == repo.nameSpace){
       isContain = true;
     }
   }
   return isContain;
 }

//  static bool containsRepoByName(LocalRepoListBean bean, List<LocalRepoListBean> beans){
//    bool isContain = false;
//    for(LocalRepoListBean repo in beans){
//      print("仓库名字：${bean.nameSpace} ____ 列表${repo.nameSpace}");
//      if(bean.repoName == repo.repoName){
//        isContain = true;
//      }
//    }
//    return isContain;
//  }

  static bool containArticle(ArticleBean bean, List<ArticleBean> beans){
    bool isContain = false;
    for(ArticleBean article in beans){
      if(bean.articleSlug == article.articleSlug){
        isContain = true;
      }
    }
    return isContain;
  }


 static Map<String, dynamic> toJson(LocalRepoListBean bean) =>{
   'teamName': bean.teamName,
   'repoName': bean.repoName,
   'groupLoginId': bean.groupLoginId,
   'groupAvatarUrl': bean.groupAvatarUrl,
   'nameSpace': bean.nameSpace,
   'articles': ArticleBean.toJsonList(bean.articleBeans),
 };


}


class ArticleBean{
  String articleTitle;
  String articleSlug;
  String nameSpace;


  ArticleBean({this.articleTitle, this.articleSlug, this.nameSpace});

  static ArticleBean fromMap(Map<String, dynamic> map) {
    ArticleBean articleBean = new ArticleBean();
    articleBean.articleTitle = map['articleTitle'];
    articleBean.articleSlug = map['articleSlug'];
    articleBean.nameSpace = map['nameSpace'];
    return articleBean;
  }


  static List<ArticleBean> fromMapList(dynamic mapList) {
    List<ArticleBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  static Map<String, dynamic> toJson(ArticleBean bean) =>{
    'articleTitle': bean.articleTitle,
    'articleSlug': bean.articleSlug,
    'nameSpace': bean.nameSpace,
  };

  static List<dynamic> toJsonList(List<ArticleBean> beans){
    List<dynamic> list = new List(beans.length);
    for (int i = 0; i < list.length; i++) {
      list[i] = toJson(beans[i]);
    }
    return list;
  }
}
