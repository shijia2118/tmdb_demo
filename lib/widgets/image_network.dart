import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_demo/ui/constant.dart';

import 'image_asset.dart';

class ImageNetwork extends StatelessWidget {
  final String url;
  final double? size;
  final double width;
  final double height;
  final BoxBorder? border;
  final double? circular;
  final bool circle;
  final BoxFit fit;
  final bool avatar;
  final BorderRadius? borderRadius;

  const ImageNetwork(
    this.url, {
    Key? key,
    this.size,
    this.width = double.infinity,
    this.height = double.infinity,
    this.border,
    this.circular,
    this.circle = false,
    this.fit = BoxFit.cover,
    this.avatar = false,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      kImageBaseUrl + url,
      width: size ?? width,
      height: size ?? height,
      border: border,
      borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(circular ?? 0)),
      shape: circle ? BoxShape.circle : BoxShape.rectangle,
      fit: fit,
      cache: true,
      gaplessPlayback: true,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return Container(
              width: width,
              height: height,
              color: Colors.white,
            );
          case LoadState.failed:
            return avatar
                ? const ImageAsset(
                    "default_avatar",
                    size: 48,
                    circle: true,
                  )
                : ImageAsset(
                    'image_fail',
                    size: size ?? 50,
                    border: border,
                  );
          default:
            return null;
        }
      },
    );
  }
}
