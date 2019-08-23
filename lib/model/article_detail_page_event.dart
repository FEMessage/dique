import 'package:flutter/material.dart';
import 'package:yuque/json/article_detail_bean.dart';
import 'package:yuque/logic/article_detail_page_logic.dart';
import 'package:yuque/widget/loading_widget.dart';
class ArticleDetailPageModel extends ChangeNotifier{

  ArticleDetailPageLogic logic;
  BuildContext context;
  LoadingFlag loadingFlag = LoadingFlag.loading;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String nameSpace;
  String articleSlug;
  ArticleDetailBean bean;


  ArticleDetailPageModel(){
    logic = ArticleDetailPageLogic(this);
  }

  void setContext(BuildContext context){
    if(this.context == null){
        this.context = context;
        logic.getArticleDetail();
    }
  }

  @override
  void dispose(){
    super.dispose();
    scaffoldKey?.currentState?.dispose();
    debugPrint("ArticleDetailPageEvent销毁了");
  }

  void refresh(){
    notifyListeners();
  }

  void setInitialData(String nameSpace, String articleSlug) {
    this.nameSpace = nameSpace;
    this.articleSlug = articleSlug;
  }

  void setArticleDetailBean(ArticleDetailBean bean){
    if(this.bean == null){
      this.bean = bean;
      refresh();
    }
  }

  void setLoadingFlag(LoadingFlag flag) {
    if (this.loadingFlag != flag) {
      this.loadingFlag = flag;
      notifyListeners();
    }
  }

}