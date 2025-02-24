import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_first_station/paper/color_selector.dart';
import 'package:flutter_first_station/paper/conform_dialog.dart';
import 'package:flutter_first_station/paper/line_model.dart';
import 'package:flutter_first_station/paper/paper_app_bar.dart';
import 'package:flutter_first_station/paper/stork_width_seletor.dart';

class PaperPage extends StatefulWidget {
  const PaperPage({super.key});

  @override
  State<PaperPage> createState() => _PaperPageState();
}

class _PaperPageState extends State<PaperPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<Line> _lines = []; // 线列表

  int _activeColorIndex = 0; // 颜色激活索引
  int _activeStorkWidthIndex = 0; // 线宽激活索引
  // 支持的颜色
  final List<Color> supportColors = [
    Colors.black,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.pink,
    Colors.grey,
    Colors.redAccent,
    Colors.orangeAccent,
    Colors.yellowAccent,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.indigoAccent,
    Colors.purpleAccent,
    Colors.pinkAccent,
  ];

  // 支持的线粗
  final List<double> supportStorkWidths = [1, 2, 4, 6, 8, 10];
  // 历史线列表
  List<Line> _historyLines = [];

  //  返回上一步
  void _back() {
    Line line =
        _lines.removeLast(); //  从_lines列表中移除最后一个元素，并将其添加到_historyLines列表中
    _historyLines.add(line);
    setState(() {}); //  通知UI更新
  }

  //  撤销上一步
  void _revocation() {
    Line line = _historyLines
        .removeLast(); //  从_historyLines列表中移除最后一个元素，并将其添加到_lines列表中
    _lines.add(line);
    setState(() {}); //  通知UI更新
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PaperAppBar(
        onClear: _showClearDialog,
        onBack: _lines.isEmpty ? null : _back,
        onRevocation: _historyLines.isEmpty ? null : _revocation,
      ),
      body: Stack(
        children: [
          GestureDetector(
            onPanStart: _onPanStart, //  手指按下
            onPanUpdate: _onPanUpdate, //  手指移动
            child: CustomPaint(
              painter: PaperPainter(lines: _lines),
              child: ConstrainedBox(
                constraints: const BoxConstraints.expand(),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                  child: ColorSelector(
                    //  设置子组件为ColorSelector组件
                    supportColors: supportColors, //  设置支持的颜色
                    onSelect: _onSelectColor, //  设置选择颜色的回调函数
                    activeIndex: _activeColorIndex, //  设置当前选中的颜色索引
                  ),
                ),
                StorkWidthSelector(
                  supportStorkWidths: supportStorkWidths,
                  color: supportColors[_activeColorIndex],
                  activeIndex: _activeStorkWidthIndex,
                  onSelect: _onSelectStorkWidth,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showClearDialog() {
    String msg = "您的当前操作会清空绘制内容，是否确定删除!";
    showDialog(
      context: context,
      builder: (ctx) => ConformDialog(
        title: '清空提示',
        conformText: '确定',
        msg: msg,
        onConform: _clear,
      ),
    );
  }

  //  清除函数
  void _clear() {
    _lines.clear(); //  清空_lines列表
    Navigator.of(context).pop(); //  返回上一级页面
    setState(() {}); //  重新构建页面
  }

  //  当开始拖动时调用
  void _onPanStart(DragStartDetails details) {
    //  添加一条新的线，起点为拖动的起始位置
    _lines.add(
      Line(
        points: [details.localPosition],
        //  线的宽度为当前选中的宽度
        strokeWidth: supportStorkWidths[_activeStorkWidthIndex],
        //  线的颜色为当前选中的颜色
        color: supportColors[_activeColorIndex],
      ),
    );
  }

  //  当用户在屏幕上拖动时调用
  void _onPanUpdate(DragUpdateDetails details) {
    //  获取用户拖动的位置
    Offset point = details.localPosition;
    //  计算用户拖动的位置与线条最后一个点的距离
    double distance = (_lines.last.points.last - point).distance;
    //  如果距离大于5
    if (distance > 5) {
      //  将用户拖动的位置添加到线条的最后一个点
      _lines.last.points.add(details.localPosition);
      setState(() {}); //  更新状态
    }
  }

  //  当选择颜色时调用
  void _onSelectColor(int index) {
    //  如果选择的颜色索引与当前活动颜色索引不同
    if (index != _activeColorIndex) {
      setState(() {
        //  更新当前活动颜色索引
        _activeColorIndex = index;
      });
    }
  }

  //  当选择笔触宽度时调用
  void _onSelectStorkWidth(int index) {
    //  如果选择的笔触宽度与当前笔触宽度不同
    if (index != _activeStorkWidthIndex) {
      setState(() {
        //  更新当前笔触宽度
        _activeStorkWidthIndex = index;
      });
    }
  }
}

class PaperPainter extends CustomPainter {
  PaperPainter({
    required this.lines,
  }) {
    _paint = Paint() //  创建画笔
      ..style = PaintingStyle.stroke // 设置画笔样式为描边
      ..strokeCap = StrokeCap.round; //
  }

  late Paint _paint;
  final List<Line> lines;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < lines.length; i++) {
      //  遍历线条列表，绘制每一条线
      drawLine(canvas, lines[i]);
    }
  }

  ///根据点位绘制线
  void drawLine(Canvas canvas, Line line) {
    _paint.color = line.color; //  设置画笔颜色和宽度
    _paint.strokeWidth = line.strokeWidth; //  设置画笔颜色和宽度
    canvas.drawPoints(PointMode.polygon, line.points, _paint); //  绘制线
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true; // 是否需要重绘
}
