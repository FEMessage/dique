import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:provider/provider.dart';
import 'package:yuque/model/login_page_event.dart';
import 'package:yuque/pages/explain_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<LoginPageModel>(context);
    model.setContext(context);
    return Scaffold(
      key: model.scaffoldKey,
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 300,
                height: 320,
                child: FlareActor(
                  "flrs/main_logo.flr",
                  animation: "rain",
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                  margin: EdgeInsets.all(5),
                  child: Text(
                    "滴•雀",
                    style: TextStyle(fontSize: 15, color: Colors.black38),
                  )
//                Text.rich(TextSpan(
//                    style: TextStyle(color: Colors.blueAccent, fontSize: 15), text: "滴", children: [
//                      TextSpan(style: TextStyle(color: Colors.black), text: "•"),
//                      TextSpan(style: TextStyle(color: Colors.green), text: "雀"),
//                ]))
                  ),
              Container(
                margin: EdgeInsets.only(left: 40, right: 40),
                child: Form(
                  autovalidate: true,
                  child: TextFormField(
                    controller: model.textControll,
                    keyboardType: TextInputType.text,
                    textDirection: TextDirection.ltr,
                    validator: (token) => model.logic.invalidToken(token),
                    decoration: InputDecoration(
                      suffixIcon: FlatButton(
                          onPressed: model.logic.getClipboard,
                          child: Text(
                            "粘贴",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          )),
                      hintText: "输入你的token",
                      labelText: "Token",
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: model.logic.onAnimationButtonTap,
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(left: 100, right: 100),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        gradient: RadialGradient(//背景径向渐变
                            colors: [
                              Colors.white,
                              Theme.of(context).primaryColor.withOpacity(0.8)
                            ], center: Alignment.topLeft, radius: .99),
                      ),
                      child: Center(
                        child: model.logic.isTextOpacity() == 1? Text(
                          "登   录",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ):SizedBox(),
                      ),
                    ),
                  ),
                  model.logic.isTextOpacity() == 1 ? SizedBox() : Container(
                    height: 60,
                    width: 130,
                    child: FlareActor(
                      "flrs/animation_test.flr",
                      animation: model.currentAnimation,
                      fit: BoxFit.contain,
                      callback: (animationName) => model.logic
                          .animationCallBack(animationName, context),
                    ),
                  ),

                ],
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                      return ExplainHome();
                    }));
                  },
                  child: Text(
                    "如何获取Token?",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
