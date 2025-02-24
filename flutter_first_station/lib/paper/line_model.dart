import 'package:flutter/widgets.dart';

class Line {
  List<Offset> points;
  Color color;
  double strokeWidth;

  Line({required this.points, required this.color, required this.strokeWidth});
}

// class LineModel {
//   List<Line> lines = [];

//   void addLine(Line line) {
//     lines.add(line);
//   }

//   void clear() {
//     lines.clear();
//   }
// }
