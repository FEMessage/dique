class JPushBean {

  /**
   * alert : "推送内容"
   * title : "文章标题"
   * extras : {"cn.jpush.android.ALERT_TYPE":-1,"cn.jpush.android.NOTIFICATION_ID":536281999,"cn.jpush.android.MSG_ID":58546804879130989,"cn.jpush.android.ALERT":"推送内容","cn.jpush.android.EXTRA":{"nameSpace":"deepexi-serverless/dev-doc","slug":"engxg1"}}
   */

  String alert;
  String title;
  var extras;
  EXTRABean extraBean;

  static JPushBean fromMap(Map<String, dynamic> map) {
    JPushBean jpush_bean = new JPushBean();
    jpush_bean.alert = map['alert'];
    jpush_bean.title = map['title'];
    jpush_bean.extras = map['extras'];
    var data = jpush_bean.extras['cn.jpush.android.EXTRA'];
    jpush_bean.extraBean = EXTRABean.fromMap(data);
    return jpush_bean;
  }

  static List<JPushBean> fromMapList(dynamic mapList) {
    List<JPushBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}

class ExtrasBean {

  /**
   * cn.jpush.android.ALERT : "推送内容"
   * cn.jpush.android.ALERT_TYPE : -1
   * cn.jpush.android.NOTIFICATION_ID : 536281999
   * cn.jpush.android.MSG_ID : 58546804879130989
   * cn.jpush.android.EXTRA : {"nameSpace":"deepexi-serverless/dev-doc","slug":"engxg1"}
   */

  var extra;

  static ExtrasBean fromMap(Map<String, dynamic> map) {
    ExtrasBean extrasBean = new ExtrasBean();

    extrasBean.extra = EXTRABean.fromMap(map['cn.jpush.android.EXTRA']);
    return extrasBean;
  }

  static List<ExtrasBean> fromMapList(dynamic mapList) {
    List<ExtrasBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class EXTRABean {

  /**
   * nameSpace : "deepexi-serverless/dev-doc"
   * slug : "engxg1"
   */

  String nameSpace;
  String slug;

  static EXTRABean fromMap(Map<String, dynamic> map) {
    EXTRABean bean = new EXTRABean();
    bean.nameSpace = map['nameSpace'];
    bean.slug = map['slug'];
    return bean;
  }

}



