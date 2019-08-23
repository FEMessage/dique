import 'dart:math';

import 'package:flutter/material.dart';

class HideAnimWidget extends StatefulWidget {

  final Widget child;
  final bool start;
  final VoidCallback onComplete;
  final String tag;

  HideAnimWidget({this.child, this.start, this.onComplete, this.tag});

  @override
  _HideAnimWidgetState createState() => _HideAnimWidgetState();
}

class _HideAnimWidgetState extends State<HideAnimWidget> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = new Tween(begin: 0.0, end: 1.0).animate(controller);
    controller.addStatusListener((status){
      debugPrint("当前动画状态：${status}");
      if (status == AnimationStatus.completed) {
        //动画执行结束时反向执行动画
        widget.onComplete();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    debugPrint("动画销毁 ${widget.tag}");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
      animation: animation,
      child: widget.child,
      builder: (BuildContext ctx, Widget child) {
        if(widget.start){
          controller.forward();
        } else {
          controller.reverse();
        }
//        debugPrint("value${animation.value} + tag:${widget.tag}   start:${widget.start}");
        return Transform.scale(
          scale: (1 - (animation.value)),
          child: new Transform.rotate(
            angle: (animation.value) * pi * 4,
            child: child,
          ),
        );
      },
    );
  }
}

