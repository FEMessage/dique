class RepoDetailBean {

  /**
   * abilities : {"update":true,"destroy":false,"doc":{"create":true}}
   * data : {"id":264509,"type":"Book","slug":"dev-doc","name":"开发文档","user_id":313927,"description":"","toc":"- [目标方向](cs0drm \"1535808\")\n- [分工协作](kqdgoa \"1621343\")\n- [小程序]()\n  - [握手计划一期开发总结](gmtoym \"1586267\")\n  - [踩坑记录](aqr6fb \"1498901\")\n- [app]()\n  - [移动端入职培训](zwnmw8 \"1632739\")\n  - [新手入门(flutter)](xbuua2 \"1648131\")\n  - [状态管理之Stream](uqtp1e \"1654687\")\n  - [使用Flare创建2D矢量动画](engxg1 \"1667563\")\n  - [核心技术点](sygy2g \"1610796\")\n  - [Flutter开发记录](lw5wkh \"1500364\")\n  - [移动端-推送](dc74gz \"1700973\")\n  - [测试排版](nsnun2 \"1720691\")\n- [Web]()\n  - [Mobile Safari 下 input 引起的问题总结](fe4iqc \"1610174\")\n- [我们的Github Workflow](qcg9x0 \"1522255\")","toc_yml":"- type: META\n  max_level: 1\n  count: 17\n  base_version_id: 0\n  published: true\n  version_id: 3893616\n- type: DOC\n  title: 目标方向\n  level: 0\n  url: cs0drm\n  id: 1535808\n- type: DOC\n  title: 分工协作\n  level: 0\n  url: kqdgoa\n  id: 1621343\n- type: TITLE\n  title: 小程序\n  level: 0\n- type: DOC\n  title: 握手计划一期开发总结\n  level: 1\n  url: gmtoym\n  id: 1586267\n- type: DOC\n  title: 踩坑记录\n  level: 1\n  url: aqr6fb\n  id: 1498901\n- type: TITLE\n  title: app\n  level: 0\n- type: DOC\n  title: 移动端入职培训\n  level: 1\n  url: zwnmw8\n  id: 1632739\n- type: DOC\n  title: 新手入门(flutter)\n  level: 1\n  url: xbuua2\n  id: 1648131\n- type: DOC\n  title: 状态管理之Stream\n  level: 1\n  url: uqtp1e\n  id: 1654687\n- type: DOC\n  title: 使用Flare创建2D矢量动画\n  level: 1\n  url: engxg1\n  id: 1667563\n- type: DOC\n  title: 核心技术点\n  level: 1\n  url: sygy2g\n  id: 1610796\n- type: DOC\n  title: Flutter开发记录\n  level: 1\n  url: lw5wkh\n  id: 1500364\n- type: DOC\n  title: 移动端-推送\n  level: 1\n  url: dc74gz\n  id: 1700973\n- type: DOC\n  title: 测试排版\n  level: 1\n  url: nsnun2\n  id: 1720691\n- type: TITLE\n  title: Web\n  level: 0\n- type: DOC\n  title: Mobile Safari 下 input 引起的问题总结\n  level: 1\n  url: fe4iqc\n  id: 1610174\n- type: DOC\n  title: 我们的Github Workflow\n  level: 0\n  url: qcg9x0\n  id: 1522255\n","creator_id":160590,"public":0,"items_count":14,"likes_count":0,"watches_count":2,"pinned_at":null,"archived_at":null,"namespace":"deepexi-serverless/dev-doc","user":{"id":313927,"type":"Group","login":"deepexi-serverless","name":"DEEPEXI Serverless","description":null,"avatar_url":"https://cdn.nlark.com/yuque/0/2019/png/160590/1556430655844-avatar/51841d71-b69f-46fd-9a42-3a71d717922f.png","large_avatar_url":"https://cdn.nlark.com/yuque/0/2019/png/160590/1556430655844-avatar/51841d71-b69f-46fd-9a42-3a71d717922f.png?x-oss-process=image/resize,m_fill,w_320,h_320","medium_avatar_url":"https://cdn.nlark.com/yuque/0/2019/png/160590/1556430655844-avatar/51841d71-b69f-46fd-9a42-3a71d717922f.png?x-oss-process=image/resize,m_fill,w_160,h_160","small_avatar_url":"https://cdn.nlark.com/yuque/0/2019/png/160590/1556430655844-avatar/51841d71-b69f-46fd-9a42-3a71d717922f.png?x-oss-process=image/resize,m_fill,w_80,h_80","books_count":4,"public_books_count":0,"followers_count":0,"following_count":0,"created_at":"2019-04-10T12:11:58.000Z","updated_at":"2019-05-09T02:10:57.000Z","_serializer":"v2.user"},"created_at":"2019-04-10T12:12:17.000Z","updated_at":"2019-05-23T08:13:42.000Z","_serializer":"v2.book_detail"}
   */

  AbilitiesBean abilities;
  DataBean data;

  static RepoDetailBean fromMap(Map<String, dynamic> map) {
    RepoDetailBean repo_detail_bean = new RepoDetailBean();
    repo_detail_bean.abilities = AbilitiesBean.fromMap(map['abilities']);
    repo_detail_bean.data = DataBean.fromMap(map['data']);
    return repo_detail_bean;
  }

  static List<RepoDetailBean> fromMapList(dynamic mapList) {
    List<RepoDetailBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}

class AbilitiesBean {

  /**
   * update : true
   * destroy : false
   * doc : {"create":true}
   */

  bool update;
  bool destroy;
  DocBean doc;

  static AbilitiesBean fromMap(Map<String, dynamic> map) {
    AbilitiesBean abilitiesBean = new AbilitiesBean();
    abilitiesBean.update = map['update'];
    abilitiesBean.destroy = map['destroy'];
    abilitiesBean.doc = DocBean.fromMap(map['doc']);
    return abilitiesBean;
  }

  static List<AbilitiesBean> fromMapList(dynamic mapList) {
    List<AbilitiesBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class DataBean {

  /**
   * type : "Book"
   * slug : "dev-doc"
   * name : "开发文档"
   * description : ""
   * toc : "- [目标方向](cs0drm \"1535808\")\n- [分工协作](kqdgoa \"1621343\")\n- [小程序]()\n  - [握手计划一期开发总结](gmtoym \"1586267\")\n  - [踩坑记录](aqr6fb \"1498901\")\n- [app]()\n  - [移动端入职培训](zwnmw8 \"1632739\")\n  - [新手入门(flutter)](xbuua2 \"1648131\")\n  - [状态管理之Stream](uqtp1e \"1654687\")\n  - [使用Flare创建2D矢量动画](engxg1 \"1667563\")\n  - [核心技术点](sygy2g \"1610796\")\n  - [Flutter开发记录](lw5wkh \"1500364\")\n  - [移动端-推送](dc74gz \"1700973\")\n  - [测试排版](nsnun2 \"1720691\")\n- [Web]()\n  - [Mobile Safari 下 input 引起的问题总结](fe4iqc \"1610174\")\n- [我们的Github Workflow](qcg9x0 \"1522255\")"
   * toc_yml : "- type: META\n  max_level: 1\n  count: 17\n  base_version_id: 0\n  published: true\n  version_id: 3893616\n- type: DOC\n  title: 目标方向\n  level: 0\n  url: cs0drm\n  id: 1535808\n- type: DOC\n  title: 分工协作\n  level: 0\n  url: kqdgoa\n  id: 1621343\n- type: TITLE\n  title: 小程序\n  level: 0\n- type: DOC\n  title: 握手计划一期开发总结\n  level: 1\n  url: gmtoym\n  id: 1586267\n- type: DOC\n  title: 踩坑记录\n  level: 1\n  url: aqr6fb\n  id: 1498901\n- type: TITLE\n  title: app\n  level: 0\n- type: DOC\n  title: 移动端入职培训\n  level: 1\n  url: zwnmw8\n  id: 1632739\n- type: DOC\n  title: 新手入门(flutter)\n  level: 1\n  url: xbuua2\n  id: 1648131\n- type: DOC\n  title: 状态管理之Stream\n  level: 1\n  url: uqtp1e\n  id: 1654687\n- type: DOC\n  title: 使用Flare创建2D矢量动画\n  level: 1\n  url: engxg1\n  id: 1667563\n- type: DOC\n  title: 核心技术点\n  level: 1\n  url: sygy2g\n  id: 1610796\n- type: DOC\n  title: Flutter开发记录\n  level: 1\n  url: lw5wkh\n  id: 1500364\n- type: DOC\n  title: 移动端-推送\n  level: 1\n  url: dc74gz\n  id: 1700973\n- type: DOC\n  title: 测试排版\n  level: 1\n  url: nsnun2\n  id: 1720691\n- type: TITLE\n  title: Web\n  level: 0\n- type: DOC\n  title: Mobile Safari 下 input 引起的问题总结\n  level: 1\n  url: fe4iqc\n  id: 1610174\n- type: DOC\n  title: 我们的Github Workflow\n  level: 0\n  url: qcg9x0\n  id: 1522255\n"
   * namespace : "deepexi-serverless/dev-doc"
   * created_at : "2019-04-10T12:12:17.000Z"
   * updated_at : "2019-05-23T08:13:42.000Z"
   * _serializer : "v2.book_detail"
   * id : 264509
   * user_id : 313927
   * creator_id : 160590
   * public : 0
   * items_count : 14
   * likes_count : 0
   * watches_count : 2
   * user : {"id":313927,"type":"Group","login":"deepexi-serverless","name":"DEEPEXI Serverless","description":null,"avatar_url":"https://cdn.nlark.com/yuque/0/2019/png/160590/1556430655844-avatar/51841d71-b69f-46fd-9a42-3a71d717922f.png","large_avatar_url":"https://cdn.nlark.com/yuque/0/2019/png/160590/1556430655844-avatar/51841d71-b69f-46fd-9a42-3a71d717922f.png?x-oss-process=image/resize,m_fill,w_320,h_320","medium_avatar_url":"https://cdn.nlark.com/yuque/0/2019/png/160590/1556430655844-avatar/51841d71-b69f-46fd-9a42-3a71d717922f.png?x-oss-process=image/resize,m_fill,w_160,h_160","small_avatar_url":"https://cdn.nlark.com/yuque/0/2019/png/160590/1556430655844-avatar/51841d71-b69f-46fd-9a42-3a71d717922f.png?x-oss-process=image/resize,m_fill,w_80,h_80","books_count":4,"public_books_count":0,"followers_count":0,"following_count":0,"created_at":"2019-04-10T12:11:58.000Z","updated_at":"2019-05-09T02:10:57.000Z","_serializer":"v2.user"}
   */

  String type;
  String slug;
  String name;
  String description;
  String toc;
  String toc_yml;
  String namespace;
  String created_at;
  String updated_at;
  String _serializer;
  int id;
  int user_id;
  int creator_id;
  int public;
  int items_count;
  int likes_count;
  int watches_count;
  UserBean user;

  static DataBean fromMap(Map<String, dynamic> map) {
    DataBean dataBean = new DataBean();
    dataBean.type = map['type'];
    dataBean.slug = map['slug'];
    dataBean.name = map['name'];
    dataBean.description = map['description'];
    dataBean.toc = map['toc'];
    dataBean.toc_yml = map['toc_yml'];
    dataBean.namespace = map['namespace'];
    dataBean.created_at = map['created_at'];
    dataBean.updated_at = map['updated_at'];
    dataBean._serializer = map['_serializer'];
    dataBean.id = map['id'];
    dataBean.user_id = map['user_id'];
    dataBean.creator_id = map['creator_id'];
    dataBean.public = map['public'];
    dataBean.items_count = map['items_count'];
    dataBean.likes_count = map['likes_count'];
    dataBean.watches_count = map['watches_count'];
    dataBean.user = UserBean.fromMap(map['user']);
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

class DocBean {

  /**
   * create : true
   */

  bool create;

  static DocBean fromMap(Map<String, dynamic> map) {
    DocBean docBean = new DocBean();
    docBean.create = map['create'];
    return docBean;
  }

  static List<DocBean> fromMapList(dynamic mapList) {
    List<DocBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class UserBean {

  /**
   * type : "Group"
   * login : "deepexi-serverless"
   * name : "DEEPEXI Serverless"
   * avatar_url : "https://cdn.nlark.com/yuque/0/2019/png/160590/1556430655844-avatar/51841d71-b69f-46fd-9a42-3a71d717922f.png"
   * large_avatar_url : "https://cdn.nlark.com/yuque/0/2019/png/160590/1556430655844-avatar/51841d71-b69f-46fd-9a42-3a71d717922f.png?x-oss-process=image/resize,m_fill,w_320,h_320"
   * medium_avatar_url : "https://cdn.nlark.com/yuque/0/2019/png/160590/1556430655844-avatar/51841d71-b69f-46fd-9a42-3a71d717922f.png?x-oss-process=image/resize,m_fill,w_160,h_160"
   * small_avatar_url : "https://cdn.nlark.com/yuque/0/2019/png/160590/1556430655844-avatar/51841d71-b69f-46fd-9a42-3a71d717922f.png?x-oss-process=image/resize,m_fill,w_80,h_80"
   * created_at : "2019-04-10T12:11:58.000Z"
   * updated_at : "2019-05-09T02:10:57.000Z"
   * _serializer : "v2.user"
   * id : 313927
   * books_count : 4
   * public_books_count : 0
   * followers_count : 0
   * following_count : 0
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
  int books_count;
  int public_books_count;
  int followers_count;
  int following_count;

  static UserBean fromMap(Map<String, dynamic> map) {
    UserBean userBean = new UserBean();
    userBean.type = map['type'];
    userBean.login = map['login'];
    userBean.name = map['name'];
    userBean.avatar_url = map['avatar_url'];
    userBean.large_avatar_url = map['large_avatar_url'];
    userBean.medium_avatar_url = map['medium_avatar_url'];
    userBean.small_avatar_url = map['small_avatar_url'];
    userBean.created_at = map['created_at'];
    userBean.updated_at = map['updated_at'];
    userBean._serializer = map['_serializer'];
    userBean.id = map['id'];
    userBean.books_count = map['books_count'];
    userBean.public_books_count = map['public_books_count'];
    userBean.followers_count = map['followers_count'];
    userBean.following_count = map['following_count'];
    return userBean;
  }

  static List<UserBean> fromMapList(dynamic mapList) {
    List<UserBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
