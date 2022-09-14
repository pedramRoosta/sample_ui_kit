import 'package:bahag_ui_kit/bahag_ui_kit.dart';
import 'package:bahag_ui_kit/widgets/base/shimmer_based.dart';
import 'package:flutter/material.dart';

class AppListTile extends ShimmerBased {
  const AppListTile({
    required String title,
    String? subtitle,
    IconData leadingicon = Icons.chevron_right,
    bool isLoading = false,
    void Function()? onTap,
    super.key,
  })  : _title = title,
        _subTitle = subtitle,
        _leadingIcon = leadingicon,
        _onTap = onTap,
        super(isLoading: isLoading);

  factory AppListTile.withShimmer() {
    return const AppListTile(
      title: 'coverTitle',
      isLoading: true,
    );
  }

  final String _title;
  final String? _subTitle;
  final void Function()? _onTap;
  final IconData _leadingIcon;

  @override
  Widget renderShimmerWidget() {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 120,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade600,
          ),
        ),
      ),
      child: ListTile(
        title: AppText.withShimmer(),
        subtitle: AppText.withShimmer(),
      ),
    );
  }

  @override
  Widget renderWidgt() {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 120,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade600,
          ),
        ),
      ),
      child: ListTile(
        title: AppText(text: _title),
        subtitle: _subTitle != null ? AppText(text: _subTitle!) : null,
        onTap: _onTap,
        trailing: Icon(_leadingIcon),
      ),
    );
  }
}
