import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tmdb_demo/widgets/text_common.dart';

import '../../utils/color_helper.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorHelper.eaColor,
      highlightColor: Colors.white,
      child: const TextCommon(
        '影视大全',
        fontSize: 30,
        bold: true,
      ),
    );
  }
}
