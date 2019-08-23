import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yuque/model/login_page_event.dart';
import 'package:yuque/pages/provider_pages.dart';
import 'package:yuque/public/api_service.dart';
import 'package:yuque/json/user_info_bean.dart';
import 'package:yuque/utils/shared_util.dart';


class LoginPageLogic {
  final LoginPageModel _model;

  LoginPageLogic(this._model);

  void onAnimationButtonTap() {
    debugPrint("点击登陆按钮");
    if (_model.currentAnimation == "normal") {
      _model.setCurrentAnimation("loading");
      doLogin(_model.context);
    }
  }

  void animationCallBack(String currentAnimation, BuildContext context) {
    switch (currentAnimation) {
      case "success":
        _model.setCurrentAnimation("normal");
        SharedUtil().saveBoolean(Keys.hasLogged, true);
        Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context){
          return ProviderPages.getInstance().getMainPage();
        }), (router) => router == null);
        break;
      case "fail":
        _model.setCurrentAnimation("normal");
        break;
      case "loading":
//        _event.setCurrentAnimation("loading");
//        doLogin(context);
        break;
    }
  }

  void doLogin(BuildContext context) {
    ApiService.getInstance().getUserInfo(_model.token, (data) {
      UserInfoBean userInfoBean = UserInfoBean.fromMap(data);
      SharedUtil.instance.saveString(Keys.xToken, _model.token);
      SharedUtil.instance.saveString(Keys.username, userInfoBean.data.name);
      SharedUtil.instance.saveString(Keys.userId, userInfoBean.data.login);
      SharedUtil.instance.saveString(
          Keys.userAvatarUrl, userInfoBean.data.medium_avatar_url);
      _model.setCurrentAnimation("success");
    }, (msg) {
      print("网络请求错误:${msg}");
      _model?.setCurrentAnimation("fail");
      _model?.scaffoldKey?.currentState?.showSnackBar(SnackBar(
          backgroundColor: Theme
              .of(context)
              .primaryColor,
          content: Text(
            "出错了  -.-",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          )));
    });
  }

  double isTextOpacity() {
    return _model.currentAnimation == "normal" ? 1 : 0;
  }

  String invalidToken(String token) {
    if (token.isEmpty) {
      return 'token不能为空';
    } else if (token.length > 50) {
      return 'token应该没有这么长吧';
    } else {
      _model.token = token;
      return null;
    }
  }

  getClipboard() async{
    ClipboardData tt = await  Clipboard.getData(Clipboard.kTextPlain);
    debugPrint("粘贴的内容:${tt?.text}");
    _model.textControll.text = tt?.text??"";
    _model.token = tt?.text??"";
  }
}
