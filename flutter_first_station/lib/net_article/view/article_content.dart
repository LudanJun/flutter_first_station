import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_station/net_article/api/article_api.dart';
import 'package:flutter_first_station/net_article/model/article.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_first_station/net_article/view/article_detail_page.dart';

class ArticleContent extends StatefulWidget {
  const ArticleContent({super.key});

  @override
  State<ArticleContent> createState() => _ArticleContentState();
}

class _ArticleContentState extends State<ArticleContent> {
  List<Article> _articles = []; // 存储文章列表
  ArticleApi api = ArticleApi(); // 初始化api
  bool _loading = false; // 是否正在加载

  @override
  void initState() {
    super.initState();
    _loadData(); // 初始化时加载数据
  }

  //  异步加载数据
  void _loadData() async {
    _loading = true; //  设置加载状态为true
    setState(() {}); //  更新UI
    _articles = await api.loadArticles(0); //  调用api加载文章数据
    _loading = false; //  设置加载状态为false
    setState(() {}); //  更新UI
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Center(
        child: Wrap(
          spacing: 10, // 水平间距
          direction: Axis.vertical, // 水平排列
          crossAxisAlignment: WrapCrossAlignment.center,
          children: const [
            CupertinoActivityIndicator(),
            Text(
              "数据加载中，请稍后...",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      );
    }
    return EasyRefresh(
      //  设置下拉刷新的头部
      header: const ClassicHeader(
        dragText: "下拉加载", //  下拉时的文本
        armedText: "释放刷新", //  释放时的文本
        readyText: "开始加载", //  准备加载时的文本
        processingText: "正在加载", //  正在加载时的文本
        processedText: "刷新成功", //  加载成功时的文本
      ),
      footer: const ClassicFooter(processingText: "正在加载"), //  设置上拉加载的底部
      onRefresh: _onRefresh, //  下拉刷新的回调函数
      onLoad: _onLoad, //  上拉加载的回调函数
      child: ListView.builder(
        //  子组件，使用ListView.builder构建列表
        itemExtent: 80, //  每个item的高度
        itemCount: _articles.length, //  列表项的数量
        itemBuilder: _buildItemByIndex, //  构建列表项的函数
      ),
    );
  }

//  下拉刷新
  void _onRefresh() async {
    _articles = await api.loadArticles(0); //  从api中加载文章
    setState(() {}); //  更新状态
  }

  //  上拉加载
  void _onLoad() async {
    int nextPage = _articles.length ~/ 20; //  计算下一页的页码
    List<Article> newArticles =
        await api.loadArticles(nextPage); //  从api中加载下一页的文章
    _articles = _articles + newArticles; //  将新加载的文章添加到已有的文章列表中
    setState(() {}); //  更新状态
  }

  //  根据索引构建文章项
  Widget _buildItemByIndex(BuildContext context, int index) {
    return ArticleItem(
      //  返回文章项
      article: _articles[index],
      onTap: _jumpToPage,
    );
  }

//  跳转到指定文章的详情页
  void _jumpToPage(Article article) {
    Navigator.of(context).push(
      //  使用Navigator.of(context)获取当前上下文
      MaterialPageRoute(
        //  使用MaterialPageRoute创建一个路由
        builder: (_) =>
            ArticleDetailPage(article: article), //  路由的builder参数，用于创建路由页面的内容
      ),
    );
  }
}

class ArticleItem extends StatelessWidget {
  final Article article;
  final ValueChanged<Article> onTap;

  const ArticleItem({Key? key, required this.article, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(article),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      article.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // Spacer(),
                  Text(
                    article.time,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    article.url,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
