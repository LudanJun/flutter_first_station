import 'package:flutter/material.dart';
import 'package:flutter_first_station/net_article/model/article.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailPage extends StatefulWidget {
  final Article article;

  const ArticleDetailPage({Key? key, required this.article}) : super(key: key);

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  //  声明一个WebViewController类型的变量
  late WebViewController controller;
  @override //  重写initState方法
  void initState() {
    super.initState();
    controller = WebViewController() //  初始化WebViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted) //  设置JavaScript模式为不限制
      ..setBackgroundColor(const Color(0x00000000)) //  设置背景颜色为透明
      ..loadRequest(Uri.parse(widget.article.url)); //  加载指定URL的请求
  }

  @override //  重写build方法
  Widget build(BuildContext context) {
    return Scaffold(
      //  返回一个Scaffold，其中包含一个AppBar和一个WebViewWidget
      appBar: AppBar(title: Text(widget.article.title)), //  设置AppBar的标题为文章的标题
      body: WebViewWidget(
          controller: controller), //  设置WebViewWidget的控制器为controller
    );
  }
}
