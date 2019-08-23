import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuque/model/article_page_event.dart';
import 'package:yuque/pages/provider_pages.dart';
import 'package:yuque/pages/webview_page.dart';
import 'package:yuque/widget/loading_widget.dart';

class ArticlePage extends StatelessWidget {
  final String repositoryName;
  final String nameSpace;

  ArticlePage(this.repositoryName, this.nameSpace);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ArticlePageModel>(context);
    model.setNameSpace(nameSpace);
    model.setContext(context);
    return Scaffold(
      key: model.scaffoldKey,
      appBar: AppBar(
        title: Text(repositoryName),
      ),
      body: Container(
        child: model.loadingFlag != LoadingFlag.success
            ? LoadingWidget(
                text: "文章列表加载中...",
                errorCallBack: model.logic.getRepoDirList,
                flag: model.loadingFlag,
              )
            : ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: model.repoDirList.length,
                itemBuilder: (context, index) {
                  final data = model.repoDirList[index];
                  final depth = data.depth.toInt();
//                  debugPrint("深度:$depth");

                  return Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: InkWell(
                            onTap: data.slug == "#"
                                ? null
                                : () {
                              if(data.slug.contains("http")){
                                Navigator.of(context).push(new CupertinoPageRoute(builder: (context) {
                                  return WebViewPage(data.slug);
                                }));
                                return;
                              }
                                    double screenWidth =
                                        MediaQuery.of(context).size.width;
                                    int num = (screenWidth / 2 / 40).toInt();
                                    Navigator.of(context).push(
                                        new CupertinoPageRoute(
                                            builder: (context) {
                                      model.logic.articleListPushAndSave(
                                          model.repoDirList[index].title,
                                          model.repoDirList[index].slug,
                                          model.nameSpace,
                                          number: num);
                                      return ProviderPages.getInstance()
                                          .getArticleDetailPage(
                                              model.repoDirList[index].title,
                                              model.repoDirList[index].slug,
                                              model.nameSpace);
                                    }));
                                  },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: (20 * (depth - 1).toDouble() + 10), right: 10, top: 10,bottom: 10),
                              child: Text(
                                data.title,
                                textAlign: TextAlign.left,
                                style: data.slug == "#"
                                    ? TextStyle(
                                        fontSize: 16, color: Colors.black54)
                                    : TextStyle(
                                        fontSize: 16,
                                      ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          flex: 9,
                        ),
                        Expanded(
                            flex: 1,
                            child: data.slug == "#"
                                ? SizedBox()
                                : Icon(Icons.keyboard_arrow_right))
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

}
