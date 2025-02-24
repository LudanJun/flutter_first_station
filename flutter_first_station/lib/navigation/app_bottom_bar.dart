import 'package:flutter/material.dart';

class MenuData {
  /// 标签
  final String title;
  // 图标数据
  final IconData icon;

  const MenuData({
    required this.title,
    required this.icon,
  });
}

class AppBottomBar extends StatelessWidget {
  final int currentIndex;
  final List<MenuData> menus;
  final ValueChanged<int>? onItemTap;
  AppBottomBar({
    super.key,
    required this.menus,
    this.currentIndex = 0,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      onTap: onItemTap,
      currentIndex: currentIndex,
      elevation: 3,
      type: BottomNavigationBarType.fixed,
      iconSize: 22,
      selectedItemColor: Theme.of(context).primaryColor,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      showUnselectedLabels: true,
      showSelectedLabels: true,
      items: menus.map(_buildItemByMenuData).toList(),
    );
  }

  BottomNavigationBarItem _buildItemByMenuData(MenuData menuData) {
    return BottomNavigationBarItem(
      icon: Icon(menuData.icon),
      label: menuData.title,
    );
  }
}
