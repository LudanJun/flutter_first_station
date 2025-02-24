import 'package:flutter/material.dart';

import '../models/image_option.dart';

class ImageOptionPanel extends StatelessWidget {
  //  ImageOptionPanel类，用于显示图片选项面板
  final List<ImageOption> imageOptions; //  图片选项列表
  final ValueChanged<int> onSelect; //  选项选择回调函数
  final int activeIndex; //  当前激活的选项索引

  const ImageOptionPanel({
    //  构造函数
    Key? key,
    required this.imageOptions,
    required this.activeIndex,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle labelStyle =
        TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    const EdgeInsets padding =
        EdgeInsets.symmetric(horizontal: 8.0, vertical: 16);
    return Material(
      child: SizedBox(
        height: 300,
        child: Column(
          children: [
            Container(
                //  标签
                height: 46,
                alignment: Alignment.center,
                child: const Text(
                  "选择木鱼",
                  style: labelStyle,
                )),
            Expanded(
                //  可扩展的子组件
                child: Padding(
              padding: padding,
              child: Row(
                children: [
                  Expanded(child: _buildByIndex(0)), //  根据索引构建子组件
                  const SizedBox(width: 10),
                  Expanded(child: _buildByIndex(1)),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

// 根据索引构建选项
  Widget _buildByIndex(int index) {
    bool active = index == activeIndex; //  判断当前索引是否为活动索引
    return GestureDetector(
      //  返回一个可点击的选项项
      onTap: () => onSelect(index), //  点击事件
      child: ImageOptionItem(
        //  选项项
        option: imageOptions[index], //  选项
        active: active, //  是否活动
      ),
    );
  }
}

class ImageOptionItem extends StatelessWidget {
  //  选项项
  final ImageOption option; //  选项
  final bool active; //  是否活动

  const ImageOptionItem({
    //  构造函数
    super.key,
    required this.option,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    const Border activeBorder = //  定义一个活动边框
        Border.fromBorderSide(BorderSide(color: Colors.blue));
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8), //  设置容器内边距
      decoration: BoxDecoration(
        //  设置容器装饰，包括圆角和边框
        borderRadius: BorderRadius.circular(8),
        border: !active ? null : activeBorder,
      ),
      child: Column(
        //  设置容器子组件
        children: [
          Text(option.name, style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            //  设置图片，水平内边距为8
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Image.asset(option.src),
            ),
          ),
          Text('每次功德 +${option.min}~${option.max}', //  设置功德描述，灰色字体，字体大小为12
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
