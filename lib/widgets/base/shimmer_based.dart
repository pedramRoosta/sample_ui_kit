import 'package:flutter/widgets.dart';

abstract class ShimmerBased extends StatelessWidget {
  const ShimmerBased({
    required this.isLoading,
    super.key,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return renderShimmerWidget();
    } else {
      return renderWidgt();
    }
  }

  Widget renderShimmerWidget();
  Widget renderWidgt();
}
