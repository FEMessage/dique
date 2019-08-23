import 'package:flutter/material.dart';
import 'package:yuque/json/article_list_bean.dart';
import 'package:yuque/json/repo_directory_bean.dart';
import 'package:yuque/logic/article_page_logic.dart';
import 'package:yuque/public/NetManager.dart';
import 'package:yuque/widget/loading_widget.dart';


class ArticlePageModel extends ChangeNotifier{

  ArticlePageLogic logic;
  BuildContext context;
  String nameSpace;
  LoadingFlag loadingFlag = LoadingFlag.loading;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<ArticleDataListBean> articleList = [];
  List<RepoDirListBean> repoDirList = [];

  ArticlePageModel(){
    logic = ArticlePageLogic(this);
  }

  void setContext(BuildContext context){
    if(this.context == null){
        this.context = context;
        logic.getRepoDirList();
    }
  }

  @override
  void dispose(){
    super.dispose();
    scaffoldKey?.currentState?.dispose();
    debugPrint("ArticlePageEvent销毁了");
  }

  void refresh(){
    notifyListeners();
  }

  void setNameSpace(String nameSpace) {this.nameSpace = nameSpace;}

  void setLoadingFlag(LoadingFlag flag) {
    if (this.loadingFlag != flag) {
      this.loadingFlag = flag;
      notifyListeners();
    }
  }

}