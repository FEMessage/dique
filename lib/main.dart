import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:yuque/utils/shared_util.dart';
import 'pages/provider_pages.dart';
//import 'package:flutter_bugly/flutter_bugly.dart';

//void main()=>FlutterBugly.postCatchedException((){
//  // 强制竖屏
//  SystemChrome.setPreferredOrientations([
//    DeviceOrientation.portraitUp,
//    DeviceOrientation.portraitDown
//  ]);
//
//  runApp(MyApp());
//}, useLog: false);

void main(){
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    print('极光开启');
    JPush().applyPushAuthority(
      new NotificationSettingsIOS(sound: true, alert: true, badge: true),
    );
    
    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '滴雀',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(106 , 180, 255, 1),
        primaryTextTheme: TextTheme(
          title: TextStyle(color: Colors.white),

        ),
        appBarTheme: AppBarTheme(iconTheme: IconThemeData(
          color: Colors.white,
        )),
        iconTheme: IconThemeData(
          color: Colors.lightBlue,
        )
      ),
      home: FutureBuilder(
          future: SharedUtil.instance.getBoolean(Keys.hasLogged),
          builder: (context, snapshot) {
            bool hasLogged = snapshot?.data ?? false;
            return hasLogged
                ? ProviderPages.getInstance().getMainPage()
                : ProviderPages.getInstance().getLoginPage();
          }),
    );
  }

}
