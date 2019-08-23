import 'package:flutter/material.dart';
import 'package:yuque/pages/image_page.dart';

class ExplainHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _titleWidget(text) {
      return Container(
        padding: EdgeInsets.only(bottom: 5.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      );
    }

    Widget _describeWidget(text) {
      return Container(
        padding: EdgeInsets.only(bottom: 5.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('滴雀'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//            _titleWidget('什么是Token?'),
//            _describeWidget('Token是语雀平台用于客户端/ API访问用户自己的私密数据!'),
//            SizedBox(
//              height: 25,
//            ),
//            _titleWidget('Token的作用?'),
//            _describeWidget(
//                'Token是语雀平台用于客户端/ API访问用户自己的私密数据，不需要账户密码即可授权访问，信息更安全!'),
//            SizedBox(
//              height: 25,
//            ),
            _titleWidget('如何获取Token?'),
            _describeWidget('按照以下流程即可。(仅限拥有 语雀平台使用账号情况下)'),
            _describeWidget('1)打开浏览器登录语雀账号'),
            _describeWidget('2)点击右上角头像，进入“设置”页面'),
            _describeWidget('3)选择“Token”并点击“新建”'),
            _describeWidget('4)填写好“用途”(推荐写法:App使用-Token)'),
            _describeWidget('5)选择授权范围(推荐全部勾选以免使用时出错，App不会记录任何用户信息，也不侵犯用户隐私)'),
            _describeWidget('6)完成操作，即可复制Token用于登录App啦'),
            GestureDetector(onTap:(){
              showDialog(
                  context: context,
                  builder: (context) {
                    return ImagePage(
                      'images/explain_2.png',
                      isNetwork: false,
                    );
                  });
            },child: Container(height: 200,child: Image.asset('images/explain_2.png'))),
            GestureDetector(onTap:(){
              showDialog(
                  context: context,
                  builder: (context) {
                    return ImagePage(
                        'images/explain.png',
                      isNetwork: false,
                    );
                  });
            },child: Image.asset('images/explain.png')),
            SizedBox(height: 20,),
            Text("注意:请不要忘了给Token添加权限哦！", style: TextStyle(fontWeight: FontWeight.bold),),
            GestureDetector(onTap:(){
              showDialog(
                  context: context,
                  builder: (context) {
                    return ImagePage(
                      'images/token_introduce.png',
                      isNetwork: false,
                    );
                  });
            },child: Image.asset('images/token_introduce.png')),
            Container(
              alignment: Alignment(0, 0),
              child: Text(
                '- 到底了 -',
                style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 13.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
