import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_demo/utils/color_helper.dart';
import 'package:tmdb_demo/widgets/field_common.dart';
import 'package:tmdb_demo/widgets/image_asset.dart';

class OutlineFieldCommon extends StatefulWidget {
  final TextEditingController controller;
  final double? width;
  final double? height;
  final Color borderColor;
  final double? borderCircular;
  final Widget? prefix;
  final Widget? suffix;
  final bool enableShowCleanButton;
  final double left;
  final String? placeholder;
  final TextStyle? placeholderStyle;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final EdgeInsets? margin;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final int? maxLength;
  final bool readOnly;
  final Function()? onTap;
  final int? maxLines;
  final double? fontSize;
  final Color? backgroundColor;
  final bool autofocus;
  final FocusNode? focusNode;
  const OutlineFieldCommon({
    Key? key,
    required this.controller,
    this.width,
    this.height,
    this.borderColor = ColorHelper.b6Color,
    this.borderCircular = 5,
    this.prefix,
    this.suffix,
    this.enableShowCleanButton = false,
    this.left = 5,
    this.placeholder,
    this.placeholderStyle,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.margin,
    this.inputFormatters,
    this.obscureText = false,
    this.readOnly = false,
    this.maxLength,
    this.onTap,
    this.maxLines,
    this.backgroundColor,
    this.fontSize = 14,
    this.autofocus = false,
    this.focusNode,
  }) : super(key: key);

  @override
  State<OutlineFieldCommon> createState() => _OutlineFieldCommonState();
}

class _OutlineFieldCommonState extends State<OutlineFieldCommon> {
  bool isShowing = false;

  @override
  Widget build(BuildContext context) {
    isShowing = widget.controller.text.isNotEmpty;
    return Container(
      margin: widget.margin,
      width: widget.width,
      height: widget.height ?? 40.w,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        border: Border.all(color: widget.borderColor, width: 1),
        borderRadius: BorderRadius.circular(widget.borderCircular!),
      ),
      child: Row(
        children: [
          widget.prefix ?? Container(),
          SizedBox(width: widget.left),
          Expanded(
            child: FieldCommon(
              controller: widget.controller,
              placeholder: widget.placeholder ?? '',
              cursorHeight: 22.w,
              autofocus: widget.autofocus,
              focusNode: widget.focusNode,
              placeholderStyle:
                  widget.placeholderStyle ?? TextStyle(color: ColorHelper.c8Color, fontSize: widget.fontSize),
              height: widget.height,
              onChanged: (text) => onChanged(text),
              onSubmitted: widget.onSubmitted,
              keyboardType: widget.keyboardType,
              style: TextStyle(textBaseline: TextBaseline.alphabetic, fontSize: widget.fontSize),
              inputFormatters: widget.inputFormatters,
              maxLines: widget.maxLines ?? 1,
              maxLength: widget.maxLength,
              obscureText: widget.obscureText,
              readOnly: widget.readOnly,
              onTap: widget.onTap,
            ),
          ),
          _cleanButtonBuild(),
          widget.suffix ?? Container(),
        ],
      ),
    );
  }

  ///后缀图标(清除按钮)
  Widget _cleanButtonBuild() {
    return Visibility(
      visible: widget.enableShowCleanButton && isShowing,
      child: GestureDetector(
        onTap: () {
          widget.controller.clear();
          setState(() {
            isShowing = false;
          });
        },
        child: Container(
          alignment: Alignment.center,
          height: widget.height,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          color: Colors.transparent,
          child: ImageAsset('clear', size: 20.w),
        ),
      ),
    );
  }

  ///输入框内容改变时的回调
  void onChanged(String text) {
    if (text.isEmpty && isShowing) {
      setState(() {
        isShowing = false;
      });
    } else if (text.isNotEmpty && !isShowing) {
      setState(() {
        isShowing = true;
      });
    }
    if (widget.onChanged != null) widget.onChanged!(text);
  }
}
