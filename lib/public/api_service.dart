import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'public_header.dart';

class ApiService {
  static ApiService _instance;

  static ApiService getInstance() {
    if (_instance == null) {
      _instance = ApiService._internal();
    }
    return _instance;
  }

  ApiService._internal();

  //获取用户信息
  void getUserInfo(String token, Function success, Function error) {
    HttpService(headers: {"X-Auth-Token": token})
        .get("user", onSuccess: success, onError: error);
  }

  //获取用户所在的组列表
  void getUserGroups(
      String token, String userId, Function success, Function error) {
    HttpService(headers: {"X-Auth-Token": token})
        .get("users/${userId}/groups", onSuccess: success, onError: error);
  }

  //获取某个组的仓库列表
  void getGroupRepo(
      String token, String groupId, Function success, Function error) {
    HttpService(headers: {"X-Auth-Token": token})
        .get("groups/${groupId}/repos", onSuccess: success, onError: error);
  }

  //获取某个用户的仓库列表
  void getPersonRepo(
      String token, String loginId, Function success, Function error) {
    HttpService(headers: {"X-Auth-Token": token})
        .get("users/${loginId}/repos", onSuccess: success, onError: error);
  }

  //获取某个仓库中的文章列表
  void getRepoArticles(
      String token, String nameSpace, Function success, Function error) {
    HttpService(headers: {"X-Auth-Token": token})
        .get("repos/${nameSpace}/docs", onSuccess: success, onError: error);
  }

  //获取某个仓库的目录结构
  void getRepoDirectory(
      String token, String nameSpace, Function success, Function error) {
    HttpService(headers: {"X-Auth-Token": token})
        .get("repos/${nameSpace}/toc", onSuccess: success, onError: error);
  }

  //获取某篇文章的详细信息
  void getArticleDetail(String token, String nameSpace, String articleSlug,
      Function success, Function error) {
    HttpService(headers: {"X-Auth-Token": token}).get(
        "repos/${nameSpace}/docs/${articleSlug}",
        onSuccess: success,
        onError: error);
  }

  //意见反馈
  void postFeedback(
    String message,
    String connectWay,
    Function success,
    Function error,
  ) {
    HttpService(basicUrl: "https://fd39c609.ap.ngrok.io/feedback").post("",
        onSuccess: success,
        onError: error,
        params: {"message": message, "email": connectWay});
  }

  //检测更新接口
  void getCheckUpdate(String token, Function success, Function error){
    HttpService(basicUrl: "https://www.easy-mock.com/mock/5ce268ea90fc7e1f09bce004/serverless/dique-update").get(
        "",
        params: {"_":md5.convert(Utf8Encoder().convert(token))},
        onSuccess: success,
        onError: error);
  }
}
