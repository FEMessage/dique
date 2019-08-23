import 'package:provider/provider.dart';
import 'package:yuque/model/all_model.dart';
import 'all_pages.dart';

class ProviderPages{
  static ProviderPages _instance;

  static ProviderPages getInstance(){
    if(_instance == null){
        _instance = ProviderPages._internal();
    }
    return _instance;
  }

  ProviderPages._internal();

  ChangeNotifierProvider<LoginPageModel> getLoginPage(){
    return ChangeNotifierProvider<LoginPageModel>(
      builder:(context) => LoginPageModel(),
      child: LoginPage(),
    );
  }

  ChangeNotifierProvider<MainPageModel> getMainPage(){
      return ChangeNotifierProvider<MainPageModel>(
        builder:(context) => MainPageModel(),
        child: MainPage(),
      );
  }

  ChangeNotifierProvider<RepositoryPageModel> getRepositoryPage(String name, String id,String avatarUrl){
      return ChangeNotifierProvider<RepositoryPageModel>(
        builder:(context) => RepositoryPageModel(),
        child: RepositoryPage(name, id,avatarUrl),
      );
  }
  
  ChangeNotifierProvider<ArticlePageModel> getArticlePage(String repoName, String nameSpace){
     return ChangeNotifierProvider<ArticlePageModel>(
       builder:(context) => ArticlePageModel(),
       child: ArticlePage(repoName, nameSpace),
     );
   }

   ChangeNotifierProvider<ArticleDetailPageModel> getArticleDetailPage(String articleName, String articleSlug, String nameSpace,{bool isFromMain}){
      return ChangeNotifierProvider<ArticleDetailPageModel>(
        builder:(context) => ArticleDetailPageModel(),
        child: ArticleDetailPage(articleName, articleSlug, nameSpace,isFromMain: isFromMain??false,),
      );
    }
}