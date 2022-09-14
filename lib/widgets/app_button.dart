import 'package:bahag_ui_kit/bahag_ui_kit.dart';
import 'package:bahag_ui_kit/widgets/base/shimmer_based.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppButton extends ShimmerBased {
  const AppButton({
    String? title,
    IconData? icon,
    bool isLoading = false,
    Color color = Colors.red,
    void Function()? onTap,
    super.key,
  })  : assert(title != null || icon != null,
            'One of the Title or icon should be set'),
        _icon = icon,
        _title = title,
        _color = color,
        _onTap = onTap,
        super(isLoading: isLoading);

  factory AppButton.withIcon({
    required IconData icon,
    Color? color,
  }) {
    return AppButton(
      icon: icon,
      color: color ?? Colors.red,
    );
  }
  factory AppButton.withShimmer() {
    return const AppButton(
      title: _template,
      isLoading: true,
    );
  }

  final IconData? _icon;
  final String? _title;
  final Color? _color;
  final void Function()? _onTap;
  static const String _template = 'Template';

  @override
  Widget renderShimmerWidget() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      child: Container(
        color: Colors.white,
        child: ElevatedButton(
          onPressed: null,
          child: _icon != null
              ? Icon(_icon)
              : AppText(
                  text: _title ?? _template,
                ),
        ),
      ),
    );
  }

  @override
  Widget renderWidgt() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _color,
      ),
      onPressed: _onTap ?? () {},
      child: _icon != null
          ? Icon(_icon)
          : AppText(
              text: _title ?? '',
            ),
    );
  }
}
