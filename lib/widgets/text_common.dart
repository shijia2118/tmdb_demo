import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextCommon extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final bool bold;
  final bool softWrap; // 是否自动换行
  final bool center;
  final int? maxLines;
  final double? height;
  final TextDecoration? textDecoration;
  final TextAlign? textAlign;

  const TextCommon(
    this.text, {
    Key? key,
    this.color,
    this.fontSize,
    this.bold = false,
    this.softWrap = false,
    this.center = false,
    this.maxLines,
    this.height,
    this.textDecoration,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: center ? TextAlign.center : (textAlign ?? TextAlign.start),
      maxLines: maxLines,
      overflow: maxLines == null ? TextOverflow.visible : TextOverflow.ellipsis,
      softWrap: softWrap,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: fontSize ?? 14.sp,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        height: height,
        decoration: textDecoration ?? TextDecoration.none,
      ),
    );
  }
}
