import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

class Toaster {
  Toaster._();

  static const _defaultDuration = Duration(seconds: 4);
  static const _toastMargin = 16.0;
  static const _toastPadding = EdgeInsets.only(left: 5, right: 9);
  static const _fontName = 'Taz';

  static void showToast({
    required BuildContext context,
    required String message,
    String? caption,
    Duration duration = _defaultDuration,
    bool isPositionFixed = false,
    bool hasDismissOption = true,
    FlashPosition? position,
    double? width,
  }) {
    showFlash(
      context: context,
      duration: !isPositionFixed ? duration : null,
      builder: (
        context,
        controller,
      ) {
        return Flash.bar(
          backgroundColor: Colors.grey.shade200,
          behavior:
              isPositionFixed ? FlashBehavior.fixed : FlashBehavior.floating,
          position: position ?? FlashPosition.bottom,
          borderRadius: BorderRadius.circular(10),
          controller: controller,
          margin: const EdgeInsets.all(_toastMargin),
          child: _buildToastContent(
            controller: controller,
            message: message,
            caption: caption,
            hasDismissOption: hasDismissOption,
          ),
        );
      },
    );
  }

  static Widget _buildToastContent({
    required FlashController controller,
    required String message,
    required bool hasDismissOption,
    String? caption,
  }) {
    return Padding(
      padding: _toastPadding,
      child: FlashBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: RichText(
                text: TextSpan(
                  children: [
                    if (caption != null)
                      TextSpan(
                        text: '$caption   ',
                        style: const TextStyle(
                            fontFamily: _fontName,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    TextSpan(
                      text: message,
                      style: const TextStyle(
                        fontFamily: _fontName,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        shouldIconPulse: false,
        primaryAction: hasDismissOption
            ? _buildDismissOption(
                controller: controller,
              )
            : null,
      ),
    );
  }

  static Widget _buildDismissOption({
    required FlashController controller,
  }) {
    return GestureDetector(
      onTap: () => controller.dismiss(),
      child: const Icon(
        Icons.close,
        color: Colors.black,
      ),
    );
  }
}
