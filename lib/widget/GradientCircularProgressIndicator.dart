import 'dart:math';

import 'package:flutter/material.dart';

class GradientCircularProgressIndicator extends StatelessWidget {
    const GradientCircularProgressIndicator({
    this.strokeWidth = 1.0,
    required this.radius,
     this.colors =const [ Color(0x00ff00ff)],
     this.stops =const[ 0.5],
    this.strokeCapRound = false,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.totalAngle = 2 * pi,
    required this.value
  });

  //粗细
  final double strokeWidth;

  //圆的半径
  final double radius;

  //两端是否为圆角
  final bool strokeCapRound;

  //当前进度，取值范围[0.0-1.0]
  final double value;

  //进度条背景色
  final Color backgroundColor;

  //进度条总弧度
  final double totalAngle;

  //渐变色数组
  final List<Color> colors;

  //渐变色的终点，对应colors属性
  final List<double> stops;

  @override
  Widget build(BuildContext context) {
    double _offset = 0.0;
    if (strokeCapRound) {
      _offset = asin(strokeWidth / (radius * 2 - strokeWidth));
    }
    var _colors = colors;
    if (_colors == null) {
      Color color = Theme
          .of(context)
          .accentColor;
      _colors = [color, color];
    }


    return Transform.rotate(
      angle: -pi / 2.0 - _offset,
      child:CustomPaint(
        size: Size.fromRadius(radius),
        painter: _GradientCircularProgressPainter(
          colors: _colors,
          stops: stops,
          strokeCapRound: strokeCapRound,
          backgroundColor: backgroundColor,
          value: value,
          total: totalAngle,
          radius: radius,
        ),
      ),
    );
  }
}
class _GradientCircularProgressPainter extends CustomPainter{
  _GradientCircularProgressPainter({
    this.strokeWidth =4.0,
    this.strokeCapRound =false,
    this.backgroundColor  = const Color(0xFFEEEEEE),
    required this.radius,
    this.total =2*pi,
    required this.colors,
    required this.stops,
    required this.value
});
  final double strokeWidth;
  final bool strokeCapRound;
  final double value;
  final Color backgroundColor;
  final List<Color>colors;
  final double total;
  final double radius;
  final List<double> stops;


  @override
  void paint(Canvas canvas, Size size) {
    size = Size.fromRadius(radius);
    double _offset = strokeWidth/2.0;
    double _value = value;
    _value = _value.clamp(.0, 1.0)*total;
    double _start = .0;

    if(strokeCapRound){
      _start = asin(strokeWidth/ (size.width - strokeWidth));
    }
    Rect rect = Offset(_offset, _offset) & Size(size.width-strokeWidth,
        size.height -strokeWidth);
    var paint = Paint()
    ..strokeCap = strokeCapRound?StrokeCap.round:StrokeCap.butt
    ..style =PaintingStyle.stroke
    ..isAntiAlias = true
    ..strokeWidth =strokeWidth;

    if(backgroundColor!=Colors.transparent){
      paint.color = backgroundColor;
      canvas.drawArc(rect, _start, total, false, paint);
    }
// 再画前景，应用渐变
    if (_value > 0) {
      paint.shader = SweepGradient(
        startAngle: 0.0,
        endAngle: _value,
        colors: colors,
        stops: stops,
      ).createShader(rect);

      canvas.drawArc(
          rect,
          _start,
          _value,
          false,
          paint
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>true;

}
