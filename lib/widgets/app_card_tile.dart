import 'package:bahag_ui_kit/bahag_ui_kit.dart';
import 'package:bahag_ui_kit/constants/uikit_constants.dart';
import 'package:bahag_ui_kit/widgets/base/shimmer_based.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppCardTile extends ShimmerBased {
  const AppCardTile({
    required String coverTitle,
    String? coverImage,
    String? title,
    String? subTitle,
    bool isLoading = false,
    super.key,
  })  : _coverImage = coverImage,
        _coverTitle = coverTitle,
        _title = title,
        _subTitle = subTitle,
        super(isLoading: isLoading);

  factory AppCardTile.withShimmer() {
    return const AppCardTile(
      coverTitle: 'coverTitle',
      isLoading: true,
    );
  }

  final String? _coverImage;
  final String? _coverTitle;
  final String? _title;
  final String? _subTitle;

  @override
  Widget renderWidgt() {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 200,
        maxWidth: 200,
      ),
      child: Card(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      _coverImage ?? UiKitConstants.imageNotFound,
                      package: _coverImage == null
                          ? UiKitConstants.packageName
                          : null,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(text: _coverTitle ?? ''),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: AppText(
                                      text: _title ?? '',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  AppText(
                                    text: _subTitle ?? '',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          AppButton.withIcon(icon: Icons.shopping_cart),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget renderShimmerWidget() {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 200,
        maxWidth: 200,
      ),
      child: Card(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.white,
                child: Container(
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.only(
                          top: 2,
                        ),
                        child: AppText.withShimmer()),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 2, right: 3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Flexible(
                                  child: AppText.withShimmer(),
                                ),
                                AppText.withShimmer(),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(
                                top: 3,
                                bottom: 3,
                                right: 3,
                              ),
                              child: AppButton.withShimmer(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
