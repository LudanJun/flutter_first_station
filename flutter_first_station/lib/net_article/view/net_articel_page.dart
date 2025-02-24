import 'package:flutter/material.dart';
import 'package:flutter_first_station/net_article/view/article_content.dart';

class NetArticelPage extends StatefulWidget {
  const NetArticelPage({super.key});

  @override
  State<NetArticelPage> createState() => _NetArticelPageState();
}

class _NetArticelPageState extends State<NetArticelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('网络请求测试'),
      ),
      body: ArticleContent(),
    );
  }
}
