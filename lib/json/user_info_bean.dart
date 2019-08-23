class UserInfoBean {

  /**
   * data : {"id":274963,"type":"User","space_id":0,"account_id":136961,"login":"newfish","name":"李子晨(安卓)","avatar_url":"https://cdn.nlark.com/yuque/0/2019/png/274963/1557302684519-avatar/d4247287-5306-455d-8162-9b9411416870.png","large_avatar_url":"https://cdn.nlark.com/yuque/0/2019/png/274963/1557302684519-avatar/d4247287-5306-455d-8162-9b9411416870.png?x-oss-process=image/resize,m_fill,w_320,h_320","medium_avatar_url":"https://cdn.nlark.com/yuque/0/2019/png/274963/1557302684519-avatar/d4247287-5306-455d-8162-9b9411416870.png?x-oss-process=image/resize,m_fill,w_160,h_160","small_avatar_url":"https://cdn.nlark.com/yuque/0/2019/png/274963/1557302684519-avatar/d4247287-5306-455d-8162-9b9411416870.png?x-oss-process=image/resize,m_fill,w_80,h_80","books_count":0,"public_books_count":0,"followers_count":0,"following_count":0,"public":1,"description":null,"created_at":"2019-02-25T14:48:11.000Z","updated_at":"2019-05-08T08:04:47.000Z","_serializer":"v2.user_detail"}
   */

  DataBean data;

  static UserInfoBean fromMap(Map<String, dynamic> map) {
    UserInfoBean user_info_bean = new UserInfoBean();
    user_info_bean.data = DataBean.fromMap(map['data']);
    return user_info_bean;
  }

  static List<UserInfoBean> fromMapList(dynamic mapList) {
    List<UserInfoBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}

class DataBean {

  /**
   * type : "User"
   * login : "newfish"
   * name : "李子晨(安卓)"
   * avatar_url : "https://cdn.nlark.com/yuque/0/2019/png/274963/1557302684519-avatar/d4247287-5306-455d-8162-9b9411416870.png"
   * large_avatar_url : "https://cdn.nlark.com/yuque/0/2019/png/274963/1557302684519-avatar/d4247287-5306-455d-8162-9b9411416870.png?x-oss-process=image/resize,m_fill,w_320,h_320"
   * medium_avatar_url : "https://cdn.nlark.com/yuque/0/2019/png/274963/1557302684519-avatar/d4247287-5306-455d-8162-9b9411416870.png?x-oss-process=image/resize,m_fill,w_160,h_160"
   * small_avatar_url : "https://cdn.nlark.com/yuque/0/2019/png/274963/1557302684519-avatar/d4247287-5306-455d-8162-9b9411416870.png?x-oss-process=image/resize,m_fill,w_80,h_80"
   * created_at : "2019-02-25T14:48:11.000Z"
   * updated_at : "2019-05-08T08:04:47.000Z"
   * _serializer : "v2.user_detail"
   * id : 274963
   * space_id : 0
   * account_id : 136961
   * books_count : 0
   * public_books_count : 0
   * followers_count : 0
   * following_count : 0
   * public : 1
   */

  String type;
  String login;
  String name;
  String avatar_url;
  String large_avatar_url;
  String medium_avatar_url;
  String small_avatar_url;
  String created_at;
  String updated_at;
  String _serializer;
  int id;
  int space_id;
  int account_id;
  int books_count;
  int public_books_count;
  int followers_count;
  int following_count;
  int public;

  static DataBean fromMap(Map<String, dynamic> map) {
    DataBean dataBean = new DataBean();
    dataBean.type = map['type'];
    dataBean.login = map['login'];
    dataBean.name = map['name'];
    dataBean.avatar_url = map['avatar_url'];
    dataBean.large_avatar_url = map['large_avatar_url'];
    dataBean.medium_avatar_url = map['medium_avatar_url'];
    dataBean.small_avatar_url = map['small_avatar_url'];
    dataBean.created_at = map['created_at'];
    dataBean.updated_at = map['updated_at'];
    dataBean._serializer = map['_serializer'];
    dataBean.id = map['id'];
    dataBean.space_id = map['space_id'];
    dataBean.account_id = map['account_id'];
    dataBean.books_count = map['books_count'];
    dataBean.public_books_count = map['public_books_count'];
    dataBean.followers_count = map['followers_count'];
    dataBean.following_count = map['following_count'];
    dataBean.public = map['public'];
    return dataBean;
  }

  static List<DataBean> fromMapList(dynamic mapList) {
    List<DataBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
