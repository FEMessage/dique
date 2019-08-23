import 'package:flutter/material.dart';
import 'package:yuque/logic/login_page_logic.dart';
import 'package:yuque/utils/shared_util.dart';

class LoginPageModel extends ChangeNotifier{

  String currentAnimation = "normal";
  String token = "";
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final textControll = TextEditingController();
  LoginPageLogic logic;
  BuildContext context;


  LoginPageModel(){
    logic = LoginPageLogic(this);
    debugPrint("进入到结构类");
  }

  @override
  void dispose(){
    super.dispose();
    scaffoldKey?.currentState?.dispose();
    textControll?.dispose();
    debugPrint("LoginPageEvent销毁了");
  }

  void refresh(){
    notifyListeners();
  }

  void setCurrentAnimation(String animation){
    if(currentAnimation != animation){
      currentAnimation = animation;
      notifyListeners();
    }
  }

  void setContext(BuildContext context){
    if(this.context == null)
    this.context = context;
  }

}