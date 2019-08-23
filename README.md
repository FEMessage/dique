![dique](https://user-images.githubusercontent.com/30992818/63570745-c2862d00-c5b0-11e9-87c9-5db9af0082da.png)


[![support](https://img.shields.io/badge/platform-flutter%7Cdart%20vm-ff69b4.svg?style=flat-square)](https://github.com/FEMessage/dique)
[![apkdownload](https://img.shields.io/badge/download-apk-brightgreen)](http://levy.ren/)

# 介绍

【滴雀】app面向所有语雀用户。

它完全使用flutter编写，同时所有内容提供来源接口皆由语雀提供：
[**语雀开发者**](https://www.yuque.com/yuque/developer)

使用只需要提供你的语雀账号token即可！


登录页| 主页 | 文章详情
---|---|---
<img width="250" height="500" src="https://user-images.githubusercontent.com/30992818/63571034-91f2c300-c5b1-11e9-836d-a642becc36c0.png"/> | <img width="250" height="500" src="https://user-images.githubusercontent.com/30992818/63571197-1c3b2700-c5b2-11e9-9548-88e24c472440.png"/> | <img width="250" height="500" src="https://user-images.githubusercontent.com/30992818/63571394-a5eaf480-c5b2-11e9-9797-2462953d6b41.png"/> 


# 项目结构

下面是项目文件结构

<img width="300" height="270" src="https://user-images.githubusercontent.com/30992818/63571781-d1221380-c5b3-11e9-9b0d-a4d7ea636dff.png"/> 



- flr：存放flare动画文件
- images：存放图片文件
- json：存放网络请求json文件
- logic：逻辑操作
- model：数据存放
- pages：所有页面
- public：一些配置类
- utils：工具类
- widgets：自定义Widget



# 第三方库

下面是项目中使用到的第三方库说明

控件 | 说明
---|---
[dio](https://pub.flutter-io.cn/packages/dio) | 网络请求
[shared_preferences](https://pub.flutter-io.cn/packages/shared_preferences) | 本地存储
[provider](https://pub.flutter-io.cn/packages/provider) | 状态管理
[test](https://pub.flutter-io.cn/packages/test) | 单元测试
[cached_network_image](https://pub.flutter-io.cn/packages/cached_network_image) | 图片缓存
[path_provider](https://pub.flutter-io.cn/packages/path_provider) | 路径获取
[package_info](https://pub.flutter-io.cn/packages/package_info) | 获取package信息
[flutter_webview_plugin](https://pub.flutter-io.cn/packages/flutter_webview_plugin) | 网页
[pull_to_refresh](https://pub.flutter-io.cn/packages/pull_to_refresh) | 上拉加载
[photo_view](https://pub.flutter-io.cn/packages/photo_view) | 图片展示
[font_awesome_flutter](https://pub.flutter-io.cn/packages/font_awesome_flutter) | 各种矢量图标
[open_file](https://pub.flutter-io.cn/packages/open_file) | 打开文件，android更新下载安装包用
[flare_flutter](https://pub.flutter-io.cn/packages/flare_flutter) | flare动画
[flutter_html](https://pub.flutter-io.cn/packages/flutter_html) | 解析html
[jpush_flutter](https://pub.flutter-io.cn/packages/jpush_flutter) | 极光推送


# 构建配置

为了避免类似android打包key存放在云端，我们使用的是譬如gitlab的variables功能来通过环境变量提供所需参数：

![](https://user-images.githubusercontent.com/30992818/63574277-fc0f6600-c5b9-11e9-8d4f-c9ceb98c6685.png)

如上面中所配置的这样，项目中有五个参数需要在使用的时候进行配置,可以查看android/app/build.gradle文件：


```
def appKeyPassword = System.getenv('KEY_PASSWORD')
def appStorePassword = System.getenv('STORE_PASSWORD')
def appKeyAlias = System.getenv('KEY_ALIAS')
def appStoreFile = System.getenv('STORE_FILE')
def jPushKey = System.getenv('JPUSH_APP_KEY')
```
前四个参数用于打包android apk，最后的参数是使用极光推送所需要的appkey

## Contributors

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore -->
<table><tr><td align="center"><a href="https://github.com/asjqkkkk"><img src="https://avatars3.githubusercontent.com/u/30992818?v=4" width="100px;" alt="android bro"/><br /><sub><b>android bro</b></sub></a><br /><a href="https://github.com/FEMessage/dique/commits?author=asjqkkkk" title="Code">💻</a> <a href="https://github.com/FEMessage/dique/commits?author=asjqkkkk" title="Documentation">📖</a> <a href="#design-asjqkkkk" title="Design">🎨</a> <a href="#infra-asjqkkkk" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a></td><td align="center"><a href="https://github.com/kira2015"><img src="https://avatars2.githubusercontent.com/u/14231117?v=4" width="100px;" alt="wu_zy"/><br /><sub><b>wu_zy</b></sub></a><br /><a href="https://github.com/FEMessage/dique/commits?author=kira2015" title="Code">💻</a> <a href="https://github.com/FEMessage/dique/commits?author=kira2015" title="Documentation">📖</a> <a href="#content-kira2015" title="Content">🖋</a> <a href="#infra-kira2015" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a></td></tr></table>

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!