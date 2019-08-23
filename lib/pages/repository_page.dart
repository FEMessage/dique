import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuque/model/repository_page_event.dart';
import 'package:yuque/pages/provider_pages.dart';
import 'package:yuque/widget/loading_widget.dart';
import 'package:yuque/widget/custom_book.dart';

class RepositoryPage extends StatelessWidget {
  final String teamName;
  final String groupLoginId;
  final String groupAvatar;

  RepositoryPage(this.teamName, this.groupLoginId, this.groupAvatar);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RepositoryPageModel>(context);
    model.setGroupId(groupLoginId);
    model.setContext(context);
    return Scaffold(
      key: model.scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: SingleChildScrollView(
          child: Text(
            teamName,
            textAlign: TextAlign.end,
          ),
        ),
      ),
      body: Container(
        child: model.loadingFlag != LoadingFlag.success
            ? LoadingWidget(
                text: "仓库列表加载中...",
                errorCallBack: model.logic.getRepoList,
                flag: model.loadingFlag,
              )
            : ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: model.dataList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(new CupertinoPageRoute(builder: (context) {
                        model.logic.repoListReadAndSave(
                            teamName,
                            model.dataList[index].name,
                            model.dataList[index].namespace,
                            groupLoginId,
                            groupAvatar);
                        return ProviderPages.getInstance().getArticlePage(
                            model.dataList[index].name,
                            model.dataList[index].namespace);
                      }));
                    },
                    child: Card(
                      elevation: 5,
                      child: Container(
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child: Icon(
                                      Icons.home,
                                      color:
                                          Theme.of(context).primaryColorLight,
                                    )),
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    "${model.dataList[index].name}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 18,right: 18),
                                child: Text(
                                  model.dataList[index].description ,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 15),
                                  overflow: TextOverflow.ellipsis,
                                )),

                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
