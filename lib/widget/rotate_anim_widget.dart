import 'dart:math';

import 'package:flutter/material.dart';

class RotateAnimWidget extends StatefulWidget {

  final Widget child;
  final bool stop;

  RotateAnimWidget({this.child, this.stop});

  @override
  _RotateAnimWidgetState createState() => _RotateAnimWidgetState();
}

class _RotateAnimWidgetState extends State<RotateAnimWidget> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = new Tween(begin: -1.0, end: 1.0).animate(controller);
    animation.addStatusListener((status){
      if (status == AnimationStatus.completed) {
        //动画执行结束时反向执行动画
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //动画恢复到初始状态时执行动画（正向）
        controller.forward();
      }
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    debugPrint("动画销毁");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: widget.child,
      builder: (BuildContext ctx, Widget child) {
        if(widget.stop){
          controller.reset();
        };
        return new Transform.rotate(
          angle: widget.stop?0:animation.value * pi / 30,
          child: child,
        );
      },
    );
  }
}

