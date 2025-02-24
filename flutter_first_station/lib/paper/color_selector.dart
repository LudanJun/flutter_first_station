import 'package:flutter/material.dart';

class ColorSelector extends StatelessWidget {
  final List<Color> supportColors;
  final ValueChanged<int> onSelect;
  final int activeIndex;
  const ColorSelector(
      {super.key,
      required this.supportColors,
      required this.onSelect,
      required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      //  返回一个Padding组件，里面包含一个Wrap组件
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Wrap(
        children: List.generate(supportColors.length,
            _buildByIndex), //  使用List.generate方法生成一个包含supportColors长度的列表，每个元素调用_buildByIndex方法
      ),
    );
  }

  Widget _buildByIndex(int index) {
    //  判断当前索引是否等于activeIndex
    bool select = index == activeIndex;
    return GestureDetector(
      //  点击事件，调用onSelect方法，并传入当前索引
      onTap: () => onSelect(index),
      child: Container(
        //  设置Container的左右边距为2
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.all(2), //  设置内边距
        width: 24, //  设置内边距
        height: 24, //  设置宽度
        alignment: Alignment.center, //  设置居中对齐
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            // borderRadius: BorderRadius.circular(8),
            border: select ? Border.all(color: Colors.blue) : null),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: supportColors[index],
          ),
        ),
      ),
    );
  }
}
