import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final Color progressColor;
  final Color textColor;
  final double textSize;
  final String text;
  final String emptyText;
  final String errorText;
  final LoadingFlag flag;
  final VoidCallback errorCallBack;

  LoadingWidget(
      {this.progressColor,
      this.textColor,
      this.textSize = 16,
      this.text = "加载中...",
      this.flag = LoadingFlag.loading,
      this.errorCallBack, this.emptyText, this.errorText})
      : assert(errorCallBack != null),
        assert(flag != null);

  @override
  Widget build(BuildContext context) {
    switch (flag) {
      case LoadingFlag.loading:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 70,
                  width: 70,
                  child: FlareActor(
                "flrs/aura.flr",
                animation: "Aura",
                fit: BoxFit.cover,
              )),
              SizedBox(
                height: 5,
              ),
              Text(
                text,
                style: TextStyle(
                    fontSize: textSize, color: progressColor ?? Colors.black),
              )
            ],
          ),
        );
        break;
      case LoadingFlag.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.error,
                color: Colors.redAccent,
                size: 30,
              ),
              SizedBox(
                height: 5,
              ),
              FlatButton(
                  onPressed: errorCallBack,
                  child: Text(
                    errorText??"重新加载",
                    style: TextStyle(fontSize: 20, color: Colors.redAccent),
                  )),
            ],
          ),
        );
        break;
      case LoadingFlag.success:
        return SizedBox();
        break;
      case LoadingFlag.empty:
        return Center(
          child: Text(
            emptyText??"空空如也",
            style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),
          ),
        );
        break;
    }
  }
}

enum LoadingFlag { loading, error, success, empty }
