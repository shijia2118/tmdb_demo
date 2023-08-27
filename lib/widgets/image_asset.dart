import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImageAsset extends StatelessWidget {
  final String asset;
  final double? size;
  final double width;
  final double height;
  final BoxBorder? border;
  final double? circular;
  final bool circle;
  final BoxFit fit;
  final double? minWidth;
  final Color? color;
  final AlignmentGeometry alignment;

  const ImageAsset(
    this.asset, {
    Key? key,
    this.size,
    this.width = double.infinity,
    this.height = double.infinity,
    this.border,
    this.circular,
    this.circle = false,
    this.fit = BoxFit.cover,
    this.minWidth,
    this.color,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.asset(
      'assets/images/$asset.png',
      width: size ?? width,
      height: size ?? height,
      border: border,
      borderRadius: BorderRadius.all(Radius.circular(circular ?? 0)),
      shape: circle ? BoxShape.circle : BoxShape.rectangle,
      fit: fit,
      color: color,
      alignment: alignment,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.failed:
            return Container(
              alignment: alignment,
              width: size ?? width,
              height: size ?? height,
              child: const ImageAsset('image_fail', size: 50),
            );
          default:
            return null;
        }
      },
    );
  }
}
