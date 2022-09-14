import 'package:bahag_ui_kit/widgets/app_dialog.dart';
import 'package:flutter/material.dart';

abstract class DialogHelper {
  static void show<T>({
    required BuildContext context,
    String? title,
    String barrierLabel = '',
    Widget? body,
    Widget? header,
    Widget? image,
    double? maxHeight,
    double? width,
    bool isDismissible = true,
    bool? isEnable,
    Alignment? alignment,
    bool Function()? canDismiss,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: isDismissible,
      barrierLabel: barrierLabel,
      pageBuilder: (context, _, __) {
        return WillPopScope(
          onWillPop: () {
            if (canDismiss != null) {
              return Future.value(canDismiss.call());
            } else {
              return Future.value(true);
            }
          },
          child: AppDialog(
            header: header,
            title: title,
            body: body,
            maxHeight: maxHeight,
            width: width,
            alignment: alignment ?? Alignment.center,
          ),
        );
      },
    );
  }
}
