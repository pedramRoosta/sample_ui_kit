import 'package:bahag_ui_kit/bahag_ui_kit.dart';
import 'package:flutter/material.dart';

enum DialogActionType {
  ok,
  cancel,
  yes,
  no,
}

class AppDialog extends StatelessWidget {
  AppDialog({
    String? title,
    Widget? header,
    Widget? body,
    List<DialogAction>? actions,
    double? width,
    double? maxHeight,
    Alignment alignment = Alignment.center,
    Key? key,
  })  : _title = title,
        _header = header,
        _body = body,
        _actions = actions,
        _height = maxHeight,
        _width = width,
        _alignment = alignment,
        assert(
          header != null || (title != null && title.isNotEmpty),
          'Either header or title must be provided',
        ),
        super(key: key);

  final String? _title;
  final Widget? _header;
  final Widget? _body;
  final List<DialogAction>? _actions;
  final double? _height;
  final double? _width;
  final Alignment _alignment;

  static const _titlePadding = EdgeInsets.symmetric(
    vertical: 14,
    horizontal: 16,
  );

  static const _bodyPadding = 16.0;
  static const _actionsHorizontalSpacing = 16.0;
  static const _closeButtonMargin = 6.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(_bodyPadding),
      child: Align(
        alignment: _alignment,
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            width: _width,
            constraints:
                _height != null ? BoxConstraints(maxHeight: _height!) : null,
            child: _buildDialog(
              context: context,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDialog({
    required BuildContext context,
  }) {
    final padding = MediaQuery.of(context).viewInsets;
    return SingleChildScrollView(
      reverse: true,
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            _buildBody(),
            if (_actions != null && _actions!.isNotEmpty) _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      child: _header != null
          ? _header!
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: _titlePadding,
                  child: AppText(
                    text: _title!,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: _closeButtonMargin),
                  child: const CloseButton(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildBody() => Container(
        padding: const EdgeInsets.all(_bodyPadding),
        child: Row(
          children: [
            if (_body != null) Flexible(child: _body!),
          ],
        ),
      );

  Widget _buildFooter() => Column(
        children: [
          const Divider(),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(_bodyPadding),
              child: Wrap(
                alignment: WrapAlignment.end,
                spacing: _actionsHorizontalSpacing,
                children: _actionWidgetsBuilder(),
              ),
            ),
          ),
        ],
      );

  List<Widget> _actionWidgetsBuilder() {
    final actionWidgets = <Widget>[];
    for (var action in _actions!) {
      final actionButton = AppButton(
        title: action.title,
        onTap: action.onAction,
      );
      actionWidgets.add(actionButton);
    }
    return actionWidgets;
  }
}

class DialogAction {
  DialogAction({
    required this.type,
    required this.isBusy,
    required this.title,
    required this.onAction,
  });

  final DialogActionType type;
  final String title;
  final dynamic Function() onAction;
  final bool isBusy;
}

class DialogTypeData {
  DialogTypeData({
    required this.decoration,
    required this.titleColor,
  });

  final Decoration decoration;
  final Color titleColor;
}
