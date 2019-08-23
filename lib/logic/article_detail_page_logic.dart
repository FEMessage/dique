import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:yuque/model/article_detail_page_event.dart';
import 'package:yuque/json/article_detail_bean.dart';
import 'package:yuque/pages/webview_page.dart';
import 'package:yuque/public/api_service.dart';
import 'package:yuque/utils/shared_util.dart';
import 'package:yuque/widget/loading_widget.dart';
import 'package:html/dom.dart' as dom;

class ArticleDetailPageLogic {
  final ArticleDetailPageModel _model;

  ArticleDetailPageLogic(this._model);

  void getArticleDetail() async {
    _model.setLoadingFlag(LoadingFlag.loading);
    String token = await SharedUtil.instance.getString(Keys.xToken);
    ApiService.getInstance()
        .getArticleDetail(token, _model.nameSpace, _model.articleSlug, (data) {
      ArticleDetailBean bean = ArticleDetailBean.fromMap(data);
      debugPrint("获取到的数据:${bean.data.body_html}");
      _model.loadingFlag = LoadingFlag.success;
      _model.setArticleDetailBean(bean);
    }, (msg) {
      _model?.setLoadingFlag(LoadingFlag.error);
      _model?.scaffoldKey?.currentState?.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "出错了  -.-",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          )));
    });
  }

  //获取无序列表
  Widget getUlWidget(dom.Node node) {
    final children = node.children;

    if (node.attributes.keys.contains('data-lake-indent')) {
      int indentLevel = 0;
      indentLevel = int.parse(node.attributes['data-lake-indent']);

      return Container(
        width: MediaQuery.of(_model.context).size.width,
        margin: EdgeInsets.only(left: 20 * indentLevel.toDouble()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(children.length, (index) {
            return _getUlSpan(children[index], true);
          }),
        ),
      );
    }

    return Container(
      width: MediaQuery.of(_model.context).size.width,
      margin: EdgeInsets.only(left: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(children.length, (index) {
          return _getUlSpan(children[index], false);
        }),
      ),
    );
  }

  //获取有序列表
  Widget getOlWidget(dom.Node node) {
    final children = node.children;

    int start = int.parse((node.attributes['start']) ?? "1");

    if (node.attributes.keys.contains('data-lake-indent')) {
      int indentLevel = 0;
      indentLevel = int.parse(node.attributes['data-lake-indent']);

      return Container(
        width: MediaQuery.of(_model.context).size.width,
        margin: EdgeInsets.only(left: 20 * indentLevel.toDouble()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(children.length, (index) {
            return _getOlSpan(children, index, start);
          }),
        ),
      );
    }

    return Container(
      width: MediaQuery.of(_model.context).size.width,
      margin: EdgeInsets.only(left: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(children.length, (index) {
//          debugPrint("attr:${node.children}");
          return _getOlSpan(children, index, start);
        }),
      ),
    );
  }

  //获取有序列表span的style属性
  Widget _getOlSpan(List<dom.Element> children, int index, int start) {
    List<dom.Node> childNodes = children[index].nodes.toList();

    return Text.rich(TextSpan(
      text: "${start + index}. ",
      children: List.generate(childNodes.length, (position) {
        String style = childNodes[position].attributes['style'];
        String color = style?.replaceAll("color: ", "")?.replaceAll(";", "");
        String href = childNodes[position].attributes['href'];
        return TextSpan(
          text: "${childNodes[position].text}",
          style: TextStyle(
              color: color != null
                  ? parseColor(color)
                  : (href == null) ? Colors.black : Colors.blue,
              height: 1.2),
            recognizer: new TapGestureRecognizer()..onTap = ((href == null)?null:() => _onLinkTap(_model.context, href)),
        );
      }),
    ));
  }

  //获取无序列表span的style属性
  Widget _getUlSpan(dom.Element child, bool isInner) {
    List<dom.Node> childNodes = child.nodes.toList();

    return Text.rich(TextSpan(
      text: "${isInner ? "৹" : "•"} ",
      children: List.generate(childNodes.length, (position) {
        String style = childNodes[position].attributes['style'];
        String color = style?.replaceAll("color: ", "")?.replaceAll(";", "");
        String src = childNodes[position].attributes['src'];
        debugPrint("span:${childNodes[position].attributes['src']}");
        return TextSpan(
            text: "${childNodes[position].text}",
            style: TextStyle(
                color: color != null ? parseColor(color) : Colors.black,
                height: 1.2));
      }),
    ));
  }

  _onLinkTap(BuildContext context, String url) {
    print('$url');
    if (url != null && url.contains('http')) {
      Navigator.of(context).push(new CupertinoPageRoute(builder: (context) {
        return WebViewPage(url);
      }));
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Container(
                  height: 20, alignment: Alignment(0, 0), child: Text('超链接识别有误')),
              contentTextStyle: TextStyle(color: Colors.black54, fontSize: 17),
            );
          });
    }
  }
}

