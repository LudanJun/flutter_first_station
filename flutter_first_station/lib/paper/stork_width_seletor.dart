import 'package:flutter/material.dart';

class StorkWidthSelector extends StatelessWidget {
  final List<double> supportStorkWidths; //  支持的柱状图宽度列表
  final ValueChanged<int> onSelect; //  选择事件回调
  final int activeIndex; //  当前激活的索引
  final Color color; //  颜色

  const StorkWidthSelector({
    super.key,
    required this.supportStorkWidths,
    required this.activeIndex,
    required this.onSelect,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.end, //  设置子组件在主轴上的对齐方式
          children: List.generate(
            //  生成一个包含supportStorkWidths长度的子组件列表
            supportStorkWidths.length,
            _buildByIndex, // 根据索引构建子组件
          )),
    );
  }

  Widget _buildByIndex(int index) {
    //  根据索引构建子组件
    bool select = index == activeIndex; //  判断当前索引是否为活动索引
    return GestureDetector(
      onTap: () => onSelect(index), //  点击事件
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2), //  设置子组件的左右边距
        width: 70, //  设置按钮宽度
        height: 18, //  设置按钮高度
        alignment: Alignment.center, //  设置按钮对齐方式
        decoration: BoxDecoration(
            //  设置按钮圆角和边框
            borderRadius: BorderRadius.circular(8),
            border: select ? Border.all(color: Colors.blue) : null),
        child: Container(
          width: 50, //  设置按钮内部容器宽度
          color: color, //  设置按钮内部容器颜色
          height: supportStorkWidths[index], //  设置按钮内部容器高度
        ),
      ),
    );
  }
}
