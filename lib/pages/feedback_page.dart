import 'package:flutter/material.dart';
import 'package:yuque/public/api_service.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  String feedBackMessage;
  String connectWay;
  TextEditingController _messageController;
  TextEditingController _connectWayController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _connectWayController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _messageController?.dispose();
    _connectWayController?.dispose();
    scaffoldKey?.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("意见反馈"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                gradient: RadialGradient(//背景径向渐变
                    colors: [
                  Colors.white,
                  Theme.of(context).primaryColorLight.withOpacity(0.8)
                ], center: Alignment.topLeft, radius: .99),
              ),
              child: TextField(
                keyboardType: TextInputType.text,
                textDirection: TextDirection.ltr,
                autofocus: true,
                maxLines: null,
                maxLength: 1000,
                controller: _messageController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.message),
                    hintText: "敢问阁下有何高见",
                    labelText: "建议",
                    border: InputBorder.none,
                    fillColor: Colors.redAccent),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                gradient: RadialGradient(//背景径向渐变
                    colors: [
                  Colors.white,
                  Colors.lightBlueAccent.withOpacity(0.6)
                ], center: Alignment.topLeft, radius: .99),
              ),
              child: TextField(
                keyboardType: TextInputType.text,
                textDirection: TextDirection.ltr,
                maxLines: 1,
                maxLength: 100,
                controller: _connectWayController,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_pin,
                      color: Colors.white,
                    ),
                    hintText: "敢问阁下如何联系",
                    labelText: "联系方式(选填)",
                    labelStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                    fillColor: Colors.redAccent),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              onPressed: isLoading
                  ? null
                  : () {
                      if (_messageController.text.isEmpty) {
                        scaffoldKey.currentState.showSnackBar(SnackBar(
                            backgroundColor: Theme.of(context).primaryColor,
                            content: Text(
                              "建议还没有填哦",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            )));
                        return;
                      }
                      setState(() {
                        isLoading = true;
                      });
                      ApiService.getInstance().postFeedback(_messageController.text, _connectWayController.text??"",
                          (data) {
                        setState(() {
                          isLoading = false;
                        });
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: Text(
                                  "感谢阁下宝贵的意见，我们一定加倍努力，不负所托",
                                ),
                                content: FlatButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "知道了",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color:
                                          Theme.of(context).primaryColor),
                                    )),
                              );
                            });
                      }, (msg) {
                        scaffoldKey.currentState.showSnackBar(SnackBar(
                            backgroundColor: Colors.redAccent,
                            content: Text(
                              "出错了 - .-",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            )));
                        setState(() {
                          isLoading = false;
                        });
                      });
                    },
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(50),
                  gradient: RadialGradient(//背景径向渐变
                      colors: [
                    Colors.white,
                    Colors.deepOrangeAccent.withOpacity(0.8)
                  ], center: Alignment.topLeft, radius: .99),
                ),
                child: isLoading
                    ? CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.white))
                    : Text(
                        "送达",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
