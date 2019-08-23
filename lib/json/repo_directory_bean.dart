class RepoDirectoryBean {

  /**
   * data : [{"title":"目标方向","slug":"cs0drm","depth":1},{"title":"分工协作","slug":"kqdgoa","depth":1},{"title":"小程序","slug":"#","depth":1},{"title":"握手计划一期开发总结","slug":"gmtoym","depth":2},{"title":"踩坑记录","slug":"aqr6fb","depth":2},{"title":"app","slug":"#","depth":1},{"title":"移动端入职培训","slug":"zwnmw8","depth":2},{"title":"新手入门(flutter)","slug":"xbuua2","depth":2},{"title":"状态管理之Stream","slug":"uqtp1e","depth":2},{"title":"使用Flare创建2D矢量动画","slug":"engxg1","depth":2},{"title":"核心技术点","slug":"sygy2g","depth":2},{"title":"Flutter开发记录","slug":"lw5wkh","depth":2},{"title":"移动端-推送","slug":"dc74gz","depth":2},{"title":"测试排版","slug":"nsnun2","depth":2},{"title":"Web","slug":"#","depth":1},{"title":"Mobile Safari 下 input 引起的问题总结","slug":"fe4iqc","depth":2},{"title":"我们的Github Workflow","slug":"qcg9x0","depth":1}]
   */

  List<RepoDirListBean> data;

  static RepoDirectoryBean fromMap(Map<String, dynamic> map) {
    RepoDirectoryBean repo_directory_bean = new RepoDirectoryBean();
    repo_directory_bean.data = RepoDirListBean.fromMapList(map['data']);
    return repo_directory_bean;
  }

  static List<RepoDirectoryBean> fromMapList(dynamic mapList) {
    List<RepoDirectoryBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}

class RepoDirListBean {

  /**
   * title : "目标方向"
   * slug : "cs0drm"
   * depth : 1
   */

  String title;
  String slug;
  int depth;

  static RepoDirListBean fromMap(Map<String, dynamic> map) {
    RepoDirListBean dataListBean = new RepoDirListBean();
    dataListBean.title = map['title'];
    dataListBean.slug = map['slug'];
    dataListBean.depth = map['depth'];
    return dataListBean;
  }

  static List<RepoDirListBean> fromMapList(dynamic mapList) {
    List<RepoDirListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
