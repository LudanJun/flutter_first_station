import 'package:flutter/material.dart';
import 'package:flutter_first_station/guess/guess_page.dart';
import 'package:flutter_first_station/muyu/muyu_page.dart';
import 'package:flutter_first_station/navigation/app_bottom_bar.dart';
import 'package:flutter_first_station/net_article/view/net_articel_page.dart';
import 'package:flutter_first_station/paper/paper_page.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int _index = 0;
  final PageController _ctrl = PageController();
  final List<MenuData> _menus = const [
    MenuData(
      title: "猜数字",
      icon: Icons.question_mark,
    ),
    MenuData(
      title: "电子木鱼",
      icon: Icons.my_library_music_outlined,
    ),
    MenuData(
      title: '白板绘制',
      icon: Icons.palette_outlined,
    ),
    MenuData(
      title: '网络文章',
      icon: Icons.article_outlined,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(),
      bottomNavigationBar: AppBottomBar(
        currentIndex: _index,
        onItemTap: _onChangePage,
        menus: _menus,
      ),
    );
  }

  void _onChangePage(int index) {
    _ctrl.jumpToPage(index);
    setState(() {
      _index = index;
    });
  }

  Widget _buildContent() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _ctrl,
      onPageChanged: (index) {
        setState(() {
          _index = index;
        });
      },
      children: const [
        GuessPage(),
        MuyuPage(),
        PaperPage(),
        NetArticelPage(),
      ],
    );
  }
}
