class UserGroupsBean {

  /**
   * data : [{"id":210644,"login":"deepexi-company","name":"滴普科技","avatar_url":"https://cdn.nlark.com/yuque/0/2018/png/210635/1542683667591-aae0cf37-d163-439c-b1f4-289231a4df7c.png","large_avatar_url":"https://cdn.nlark.com/yuque/0/2018/png/210635/1542683667591-aae0cf37-d163-439c-b1f4-289231a4df7c.png?x-oss-process=image/resize,m_fill,w_320,h_320","medium_avatar_url":"https://cdn.nlark.com/yuque/0/2018/png/210635/1542683667591-aae0cf37-d163-439c-b1f4-289231a4df7c.png?x-oss-process=image/resize,m_fill,w_160,h_160","small_avatar_url":"https://cdn.nlark.com/yuque/0/2018/png/210635/1542683667591-aae0cf37-d163-439c-b1f4-289231a4df7c.png?x-oss-process=image/resize,m_fill,w_80,h_80","books_count":26,"public_books_count":0,"topics_count":0,"public_topics_count":0,"members_count":315,"public":0,"description":"公司全员","created_at":"2018-11-20T03:14:33.000Z","updated_at":"2019-05-14T06:39:45.000Z","_serializer":"v2.group"},{"id":313927,"login":"deepexi-serverless","name":"DEEPEXI Serverless","avatar_url":"https://cdn.nlark.com/yuque/0/2019/png/160590/1556430655844-avatar/51841d71-b69f-46fd-9a42-3a71d717922f.png","large_avatar_url":"https://cdn.nlark.com/yuque/0/2019/png/160590/1556430655844-avatar/51841d71-b69f-46fd-9a42-3a71d717922f.png?x-oss-process=image/resize,m_fill,w_320,h_320","medium_avatar_url":"https://cdn.nlark.com/yuque/0/2019/png/160590/1556430655844-avatar/51841d71-b69f-46fd-9a42-3a71d717922f.png?x-oss-process=image/resize,m_fill,w_160,h_160","small_avatar_url":"https://cdn.nlark.com/yuque/0/2019/png/160590/1556430655844-avatar/51841d71-b69f-46fd-9a42-3a71d717922f.png?x-oss-process=image/resize,m_fill,w_80,h_80","books_count":4,"public_books_count":0,"topics_count":0,"public_topics_count":0,"members_count":10,"public":0,"description":null,"created_at":"2019-04-10T12:11:58.000Z","updated_at":"2019-05-09T02:10:57.000Z","_serializer":"v2.group"}]
   */

  List<UserGroupListBean> data;

  static UserGroupsBean fromMap(Map<String, dynamic> map) {
    UserGroupsBean user_groups_bean = new UserGroupsBean();
    user_groups_bean.data = UserGroupListBean.fromMapList(map['data']);
    return user_groups_bean;
  }

  static List<UserGroupsBean> fromMapList(dynamic mapList) {
    List<UserGroupsBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}

class UserGroupListBean {

  /**
   * login : "deepexi-company"
   * name : "滴普科技"
   * avatar_url : "https://cdn.nlark.com/yuque/0/2018/png/210635/1542683667591-aae0cf37-d163-439c-b1f4-289231a4df7c.png"
   * large_avatar_url : "https://cdn.nlark.com/yuque/0/2018/png/210635/1542683667591-aae0cf37-d163-439c-b1f4-289231a4df7c.png?x-oss-process=image/resize,m_fill,w_320,h_320"
   * medium_avatar_url : "https://cdn.nlark.com/yuque/0/2018/png/210635/1542683667591-aae0cf37-d163-439c-b1f4-289231a4df7c.png?x-oss-process=image/resize,m_fill,w_160,h_160"
   * small_avatar_url : "https://cdn.nlark.com/yuque/0/2018/png/210635/1542683667591-aae0cf37-d163-439c-b1f4-289231a4df7c.png?x-oss-process=image/resize,m_fill,w_80,h_80"
   * description : "公司全员"
   * created_at : "2018-11-20T03:14:33.000Z"
   * updated_at : "2019-05-14T06:39:45.000Z"
   * _serializer : "v2.group"
   * id : 210644
   * books_count : 26
   * public_books_count : 0
   * topics_count : 0
   * public_topics_count : 0
   * members_count : 315
   * public : 0
   */

  String login;
  String name;
  String avatar_url;
  String large_avatar_url;
  String medium_avatar_url;
  String small_avatar_url;
  String description;
  String created_at;
  String updated_at;
  String _serializer;
  int id;
  int books_count;
  int public_books_count;
  int topics_count;
  int public_topics_count;
  int members_count;
  int public;

  static UserGroupListBean fromMap(Map<String, dynamic> map) {
    UserGroupListBean dataListBean = new UserGroupListBean();
    dataListBean.login = map['login'];
    dataListBean.name = map['name'];
    dataListBean.avatar_url = map['avatar_url'];
    dataListBean.large_avatar_url = map['large_avatar_url'];
    dataListBean.medium_avatar_url = map['medium_avatar_url'];
    dataListBean.small_avatar_url = map['small_avatar_url'];
    dataListBean.description = map['description'];
    dataListBean.created_at = map['created_at'];
    dataListBean.updated_at = map['updated_at'];
    dataListBean._serializer = map['_serializer'];
    dataListBean.id = map['id'];
    dataListBean.books_count = map['books_count'];
    dataListBean.public_books_count = map['public_books_count'];
    dataListBean.topics_count = map['topics_count'];
    dataListBean.public_topics_count = map['public_topics_count'];
    dataListBean.members_count = map['members_count'];
    dataListBean.public = map['public'];
    return dataListBean;
  }

  static List<UserGroupListBean> fromMapList(dynamic mapList) {
    List<UserGroupListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
