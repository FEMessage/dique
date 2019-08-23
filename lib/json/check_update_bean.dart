class CheckUpdateBean {

  /**
   * android : {"version":"1.0.0","content":"1.新增xxx\n2.优化xxx","isForceUpdate":0,"updateTime":"2019-04-28","downloadLink":"https://work-1256696029.cos.ap-guangzhou.myqcloud.com/apk_download/dique.apk"}
   * ios : {"version":"1.0.0","content":"1.新增xxx\n2.优化xxx","updateTime":"2019-06-12","isForceUpdate":0,"downloadLink":"https://apps.apple.com/cn/app/%E6%BB%B4%E9%9B%80/id1466759938"}
   */

  AndroidBean android;
  IosBean ios;

  static CheckUpdateBean fromMap(Map<String, dynamic> map) {
    CheckUpdateBean check_update_bean = new CheckUpdateBean();
    check_update_bean.android = AndroidBean.fromMap(map['android']);
    check_update_bean.ios = IosBean.fromMap(map['ios']);
    return check_update_bean;
  }

  static List<CheckUpdateBean> fromMapList(dynamic mapList) {
    List<CheckUpdateBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}

class AndroidBean {

  /**
   * version : "1.0.0"
   * content : "1.新增xxx\n2.优化xxx"
   * updateTime : "2019-04-28"
   * downloadLink : "https://work-1256696029.cos.ap-guangzhou.myqcloud.com/apk_download/dique.apk"
   * isForceUpdate : 0
   */

  String version;
  String content;
  String updateTime;
  String downloadLink;
  int isForceUpdate;

  static AndroidBean fromMap(Map<String, dynamic> map) {
    AndroidBean androidBean = new AndroidBean();
    androidBean.version = map['version'];
    androidBean.content = map['content'];
    androidBean.updateTime = map['updateTime'];
    androidBean.downloadLink = map['downloadLink'];
    androidBean.isForceUpdate = map['isForceUpdate'];
    return androidBean;
  }

  static List<AndroidBean> fromMapList(dynamic mapList) {
    List<AndroidBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class IosBean {

  /**
   * version : "1.0.0"
   * content : "1.新增xxx\n2.优化xxx"
   * updateTime : "2019-06-12"
   * downloadLink : "https://apps.apple.com/cn/app/%E6%BB%B4%E9%9B%80/id1466759938"
   * isForceUpdate : 0
   */

  String version;
  String content;
  String updateTime;
  String downloadLink;
  int isForceUpdate;

  static IosBean fromMap(Map<String, dynamic> map) {
    IosBean iosBean = new IosBean();
    iosBean.version = map['version'];
    iosBean.content = map['content'];
    iosBean.updateTime = map['updateTime'];
    iosBean.downloadLink = map['downloadLink'];
    iosBean.isForceUpdate = map['isForceUpdate'];
    return iosBean;
  }

  static List<IosBean> fromMapList(dynamic mapList) {
    List<IosBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
