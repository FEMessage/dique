import 'package:flutter/material.dart';
import 'package:yuque/json/group_repository_bean.dart';
import 'package:yuque/logic/repository_page_logic.dart';
import 'package:yuque/widget/loading_widget.dart';

class RepositoryPageModel extends ChangeNotifier {

  RepositoryPageLogic logic;
  BuildContext context;
  String groupId;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<GroupRepoListBean> dataList = [];
  LoadingFlag loadingFlag = LoadingFlag.loading;


  RepositoryPageModel() {
    logic = RepositoryPageLogic(this);
  }

  void setContext(BuildContext context) {
    if (this.context == null) {
      this.context = context;
      logic.getRepoList();
    }
  }

  @override
  void dispose() {
    super.dispose();
    scaffoldKey?.currentState?.dispose();
    debugPrint("RepositoryEvent销毁了");
  }

  void refresh() {
    notifyListeners();
  }

  void setGroupId(String groupId) {
    this.groupId = groupId;
  }

  void setLoadingFlag(LoadingFlag flag) {
    if (this.loadingFlag != flag) {
      this.loadingFlag = flag;
      notifyListeners();
    }
  }


}