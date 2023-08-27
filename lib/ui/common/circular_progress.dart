import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularProgress extends StatefulWidget {
  ///背景圆形色值
  final Color backgroundColor;

  ///当前进度 0-100
  final double progress;

  ///进度条颜色
  final Color progressColor;

  ///圆环宽度
  final double progressWidth;

  ///宽度
  final double width;

  ///高度
  final double height;

  const CircularProgress(
      {Key? key,
      required this.progress,
      this.width = 55,
      this.height = 55,
      this.backgroundColor = Colors.grey,
      this.progressColor = Colors.blue,
      this.progressWidth = 3.0})
      : super(key: key);

  @override
  CircleProgressViewState createState() => CircleProgressViewState();
}

class CircleProgressViewState extends State<CircularProgress> with TickerProviderStateMixin {
  static const double pi = 3.14;
  late Animation<double> animation;
  late AnimationController controller;
  late CurvedAnimation curvedAnimation;
  late Tween<double> tween;
  late double oldProgress;

  @override
  void initState() {
    super.initState();
    oldProgress = widget.progress;
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    curvedAnimation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    tween = Tween();
    tween.begin = 0.0;
    tween.end = oldProgress;
    animation = tween.animate(curvedAnimation);
    animation.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  //这里是在重新赋值进度时，再次刷新动画
  void startAnimation() {
    controller.reset();
    tween.begin = oldProgress;
    tween.end = widget.progress;
    animation = tween.animate(curvedAnimation);
    controller.forward();
    oldProgress = widget.progress;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (oldProgress != widget.progress) {
      startAnimation();
    }
    return Container(
      width: widget.width,
      height: widget.height,
      padding: const EdgeInsets.all(10),
      child: CustomPaint(
        painter: ProgressPaint(
            animation.value / 50 * pi, widget.progressWidth, widget.backgroundColor, widget.progressColor),
        child: Center(
          child: Text.rich(
            TextSpan(
              text: "${animation.value.toInt()}",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '%',
                  style: TextStyle(fontSize: 10.sp),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProgressPaint extends CustomPainter {
  ProgressPaint(
      this.progress, //进度
      this.width, //画笔宽度
      this.backgroundColor, //背景画笔颜色
      this.progressColor) {
    //背景画笔
    paintBg = Paint()
      ..color = backgroundColor
      ..strokeWidth = width
      ..isAntiAlias = true //是否开启抗锯齿
      ..style = PaintingStyle.stroke; // 画笔风格，线
    //进度画笔
    paintProgress = Paint()
      ..color = progressColor
      ..strokeWidth = width
      ..isAntiAlias = true //是否开启抗锯齿
      ..strokeCap = StrokeCap.round // 笔触设置为圆角
      ..style = PaintingStyle.stroke; // 画笔风格，线
  }

  final Color backgroundColor;
  final double progress;
  final Color progressColor;
  final double width;

  Paint paintBg = Paint();
  Paint paintProgress = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    //半径，这里为防止宽高不一致，取较小值的一半作为半径大小
    double radius = size.width > size.height ? size.height / 2 : size.width / 2;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, paintBg);
    Rect rect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: radius);
    canvas.drawArc(rect, 0, progress, false, paintProgress);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
