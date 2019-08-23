import 'package:dio/dio.dart';


class NetManager extends Dio {

  // static const String CONTENT_TYPE_JSON = "application";
  // static const String CONTENT_TYPE_FORM = "x-www-form-urlencoded";
  // static const String CONTENT_CHART_SET = 'utf-8';

  // 工厂模式
  factory NetManager() =>_getInstance();
  static NetManager get instance => _getInstance();
  static NetManager _instance;
  NetManager._internal() {
    // 初始化
  }

  static NetManager _getInstance() {
    if (_instance == null) {
      _instance =  NetManager._internal();
    }
    return _instance;
  }
}