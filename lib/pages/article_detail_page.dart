import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart'
    as prefix0;
import 'package:html/dom.dart' as dom;
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:yuque/pages/image_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:yuque/pages/provider_pages.dart';
import 'package:yuque/pages/webview_page.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:yuque/public/public_header.dart';
import 'package:yuque/widget/loading_widget.dart';
import 'package:yuque/model/all_model.dart';

class ArticleDetailPage extends StatelessWidget {
  final String articleName;
  final String articleSlug;
  final String nameSpace;
  final bool isFromMain;

  ArticleDetailPage(this.articleName, this.articleSlug, this.nameSpace,
      {this.isFromMain = false});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ArticleDetailPageModel>(context);
    model.setInitialData(nameSpace, articleSlug);
    model.setContext(context);
    //    debugPrint("空间:${nameSpace}");

    return Scaffold(
      appBar: AppBar(
        title: Text(model?.bean?.data?.title ?? articleName??""),
        actions: <Widget>[
          isFromMain
              ? SizedBox()
              : IconButton(
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  })
        ],
      ),
      key: model.scaffoldKey,
      body: Container(
          child: model.loadingFlag != LoadingFlag.success
              ? LoadingWidget(
                  text: "文章加载中...",
                  errorCallBack: model.logic.getArticleDetail,
                  flag: model.loadingFlag,
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: getHtml(context, model),
                )),
    );
  }
}

Widget getHtml(context, event) {
  String htmlContent = event.bean.data.body_html;
  return Html(
      data: htmlContent,
      useRichText: false,
      padding: EdgeInsets.all(10.0),
      onLinkTap: (url) {
        _onLinkTap(context, url);
      },
      customRender: (node, children) {
        try {
          if (node is dom.Element) {
            switch (node.localName) {
              case 'img':
                if (node.attributes['src'] == null) {
                  return null;
                }
                return GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return ImagePage(
                              node.attributes['src'],
                            );
                          });
                    },
                    child: Center(
                      child: CachedNetworkImage(
                          imageUrl: node.attributes['src'],
                          placeholder: (context, url) =>
                              new CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor),
                              ),
                          errorWidget: (context, url, error) => new Icon(
                                Icons.error,
                                color: Colors.redAccent,
                              )),
                    ));

              case 'pre':
                return Container(
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width - 20),
                  color: Colors.grey[200],
                  child: HtmlWidget(
                    node.outerHtml,
                  ),
                );
              case 'blockquote':
                return Stack(
                  children: <Widget>[
                    Container(
                      child: Transform(
                        transform: Matrix4.translationValues(-30, 0, 0),
                        child: HtmlWidget(
                          node.outerHtml,
                          textStyle: AppTheme.themData.textTheme.subtitle,
                          builderCallback: (nn, ee) {
                            if (ee.localName == 'code') {
                              print('----blockquote里面的code---${node.text}');

                              return lazySet(null, buildOp: BuildOp(
                                onPieces: (meta, pieces) {
                                  final text = ' ';

                                  return pieces..first?.block?.addText(text);
                                },
                              ));
                            }

                            return nn;
                          },
                          onTapUrl: (url){
                            _onLinkTap(context, url);
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        color: Colors.grey[300],
                        width: 3,
                      ),
                      left: 0,
                      top: 5,
                      bottom: 5,
                    ),
                  ],
                );
              case 'code':
                return Container(
                  color: Colors.grey[300],
                  child: Text(node.text),
                );
              // case 'table':
              //   return SingleChildScrollView(
              //     // scrollDirection: Axis.horizontal,
              //     child: Container(
              //       width: MediaQuery.of(context).size.width*1.5,
              //         // padding: EdgeInsets.all(5),
              //         child: Html(
              //           data: node.outerHtml,
              //           onLinkTap: (url) {
              //             _onLinkTap(context, url);
              //           },
              //         )),
              //   );
              case 'ol':
              case 'ul':
                return HtmlWidget(
                  node.outerHtml,
                  webView: true,
                  bodyPadding: EdgeInsets.all(0),
                  onTapUrl: (url) {
                    _onLinkTap(context, url);
                  },
                  builderCallback: (nodeData, element) {
                    if (element.classes.contains('lake-list')) {
                      return null;
                    }
                    if (element.localName == 'li' && element.outerHtml.contains('checkbox')&&element.getElementsByTagName('input').length>0) {
                      return lazySet(null, buildOp: BuildOp(
                        onWidgets: (n, w) {
                          return [
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 5),
                                    constraints: BoxConstraints(
                                        maxHeight: 20, maxWidth: 20),
                                    child: AbsorbPointer(
                                      child: Checkbox(
                                        activeColor: Colors.green,
                                        checkColor: Colors.white,
                                        tristate: true,
                                        value: element.outerHtml
                                            .contains('checked'),
                                        onChanged: (checked) {
                                          print(checked);
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text('${element.text}'),
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width -
                                                45),
                                  ),
                                ],
                              ),
                            )
                          ];
                        },
                      ));
                    }
                    return nodeData;
                  },
                );
                    break;
              //文字样式
              case 'span':
                var styleStr = node.attributes['style'];
                var classStr = node.attributes['class'];
                String textColor = '#000000';
                String textBackgroundColor = '#FFFFFF';
                String fontStr = '14';

                if (styleStr != null) {
                  styleStr = styleStr.replaceAll(' ', '');
                  List li = styleStr.split(';');

                  li.forEach((ob) {
                    String obj = ob;
                    if (obj.startsWith('color')) {
                      textColor = obj.split(':').last;
                    }
                    if (obj.startsWith('background-color')) {
                      textBackgroundColor = obj.split(':').last;
                    }
                  });
                  return Text(node.text,
                      style: TextStyle(
                        color: parseColor(textColor),
                        decorationColor: parseColor(textBackgroundColor),
                      ));
                }
                // if (classStr!=null) {
                //  fontStr =  classStr.contains('lake-fontsize-')?classStr.substring(14):'14';
                //   return Text(
                //     node.text,
                //     style: TextStyle(
                //         color: colorParseValue(textColor),
                //         backgroundColor: colorParseValue(textBackgroundColor),
                //         fontSize: double.parse(fontStr)+3
                //   ));
                // }
                break;
            }
          }
        } catch (e) {
          print('解析HTML存在异常--$e');
        }
      });
}

_onLinkTap(context, url) {
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
