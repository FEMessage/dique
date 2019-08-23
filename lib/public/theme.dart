import 'package:flutter/material.dart';


class AppTheme {
static  Color greyColor = Color(0xFF666666);
static  Color blackColor = Color(0xFF333333);
static  Color lineColor = Color(0xFFEEEEEE);
static  Color redColor = Color(0xFFC53439);
static  Color whiteColor = Color(0xFFFFFFFF);
static  Color backgroundColor = Color(0xFFF6F8FA);

  static ThemeData themData = ThemeData(
    
    textTheme: TextTheme(
      body1: TextStyle(
        fontSize: 15.0
      ),
      display1: TextStyle(
        color: blackColor,
        fontSize: 13.0
      ),
      display2: TextStyle(
        color: blackColor,
        // fontWeight: FontWeight.bold,
        fontSize: 15.0
      ),
      display3: TextStyle(
        color: blackColor,
        // fontWeight: FontWeight.bold,
        fontSize: 17.0
      ),
      display4: TextStyle(
        color: blackColor,
        // fontWeight: FontWeight.bold,
        fontSize: 20.0
      ),
      subtitle: TextStyle(
        color: greyColor,
        fontWeight: FontWeight.normal,
        fontSize: 14.0
      ),
      // title: TextStyle(
      //   color: Colors.yellow
      // )
      
    ),
    //platform: TargetPlatform.iOS,
    iconTheme: IconThemeData(
      size: 30,
      color: blackColor,
      opacity: 0.85,
    ),
    
    // primaryIconTheme 导航栏按钮颜色
    primaryIconTheme: IconThemeData(
      color: blackColor,
    ),
    accentColor: Colors.green,  //强调颜色
    primarySwatch: Colors.red,  //调色板，主题色但会被覆盖
    // primaryColorBrightness: Brightness.light,
    // primaryColor: Color(redColor), // appbar和tabbar：Tint的颜色
    appBarTheme: AppBarTheme(
      brightness: Brightness.light,
      color: whiteColor,
      textTheme: TextTheme(
        
        title: TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.normal
          
        ),
        
      )
    ),
    
    scaffoldBackgroundColor: backgroundColor, // 整体的scaffold背景颜色
  );
}
