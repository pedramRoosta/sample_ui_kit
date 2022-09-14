import 'package:bahag_ui_kit/widgets/base/shimmer_based.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppText extends ShimmerBased {
  const AppText({
    required String text,
    TextStyle? textstyle,
    double? fontSize,
    bool isLoading = false,
    FontWeight? fontWeight,
    super.key,
  })  : _text = text,
        _textStyle = textstyle,
        _fontSize = fontSize,
        _fontWeight = fontWeight,
        super(isLoading: isLoading);

  factory AppText.withShimmer() {
    return const AppText(
      text: 'TemplateText',
      isLoading: true,
    );
  }

  final String _text;
  final TextStyle? _textStyle;
  final double? _fontSize;
  final FontWeight? _fontWeight;
  static const _packageName = 'bahag_ui_kit';
  static const _fontName = 'Taz';

  @override
  Widget renderShimmerWidget() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      child: Container(
        color: Colors.white,
        child: Text(
          _text,
        ),
      ),
    );
  }

  @override
  Widget renderWidgt() {
    return Text(
      _text,
      overflow: TextOverflow.ellipsis,
      style: _textStyle ??
          TextStyle(
            fontSize: _fontSize,
            fontWeight: _fontWeight,
            fontFamily: _fontName,
            package: _packageName,
          ),
    );
  }
}
