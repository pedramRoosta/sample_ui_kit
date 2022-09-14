import 'package:flutter/material.dart';

class AppTextInput extends StatefulWidget {
  const AppTextInput({
    required TextEditingController controller,
    required String label,
    required int maxCharacterLimit,
    String? Function(String)? validator,
    Key? key,
  })  : _controller = controller,
        _label = label,
        _validator = validator,
        _maxCharacterLimit = maxCharacterLimit,
        super(key: key);

  factory AppTextInput.plain({
    required TextEditingController controller,
    required String label,
  }) {
    return AppTextInput(
      controller: controller,
      label: label,
      maxCharacterLimit: 0,
    );
  }

  factory AppTextInput.withLimitation({
    required TextEditingController controller,
    required String label,
    required int maxCharacterLimit,
  }) {
    return AppTextInput(
      controller: controller,
      label: label,
      maxCharacterLimit: maxCharacterLimit,
    );
  }

  factory AppTextInput.withValidation({
    required TextEditingController controller,
    required String label,
    required String? Function(String) validator,
    int maxCharacterLimit = 0,
  }) {
    return AppTextInput(
      controller: controller,
      label: label,
      maxCharacterLimit: maxCharacterLimit,
      validator: validator,
    );
  }

  final TextEditingController _controller;
  final String _label;
  final Function(String)? _validator;
  final int _maxCharacterLimit;

  @override
  State<AppTextInput> createState() => _AppTextInputState();
}

class _AppTextInputState extends State<AppTextInput> {
  static const _singleLineMaxHeight = 80.0;
  static const _contentPadding = EdgeInsets.symmetric(
    vertical: 12,
    horizontal: 13,
  );
  static const _textInputPadding = 15.0;
  final focusNode = FocusNode();

  String? errorMessage;
  late bool isTouched;

  @override
  void initState() {
    isTouched = false;
    super.initState();
    if (widget._controller.text.isNotEmpty) _validate();

    /// for every change in focus, the widget needs to be rebuilt
    /// to reflect color changes for character limitation and label
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        isTouched = true;
        _validate();
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasFocus = focusNode.hasFocus;
    final maxCharacterLimit = widget._maxCharacterLimit;

    return SizedBox(
      height: _singleLineMaxHeight,
      child: TextFormField(
        validator: widget._validator != null
            ? (str) {
                setState(() {
                  errorMessage = widget._validator?.call(str!);
                  isTouched = true;
                });
                return errorMessage;
              }
            : null,
        focusNode: focusNode,
        textAlignVertical: TextAlignVertical.top,
        maxLength: maxCharacterLimit > 0 ? maxCharacterLimit : null,
        buildCounter: (
          context, {
          required int currentLength,
          required bool isFocused,
          required int? maxLength,
        }) {
          return _buildCounter(
            isFocused: isFocused,
            currentLength: currentLength,
            maxLenght: maxLength,
          );
        },
        controller: widget._controller,
        decoration: _getDecoration(
          hasFocus: hasFocus,
          labelColor: Colors.grey,
        ),
        onChanged: (value) {
          isTouched = true;
          _validate();
          setState(() {});
        },
      ),
    );
  }

  void _validate() {
    errorMessage = widget._validator?.call(widget._controller.text);
  }

  InputDecoration _getDecoration({
    required Color labelColor,
    required bool hasFocus,
  }) {
    return InputDecoration(
      suffixIcon: widget._validator != null &&
              (isTouched || widget._controller.text.isNotEmpty)
          ? errorMessage != null
              ? const Icon(
                  Icons.dangerous,
                  color: Colors.red,
                )
              : Icon(
                  Icons.check,
                  color: Colors.purple.shade500,
                )
          : null,
      isDense: false,
      errorText: errorMessage,
      contentPadding: _contentPadding,
      border: const OutlineInputBorder(),
      labelText: widget._label,
      labelStyle: TextStyle(color: labelColor),
      alignLabelWithHint: true,
    );
  }

  Widget _buildCounter({
    required bool isFocused,
    required int currentLength,
    int? maxLenght,
  }) {
    return SizedBox(
      height: _textInputPadding,
      child: maxLenght != null
          ? RichText(
              text: TextSpan(
                text: '$currentLength',
                children: [
                  TextSpan(
                    text: ' / $maxLenght',
                  ),
                ],
              ),
            )
          : null,
    );
  }

  @override
  void dispose() {
    widget._controller.dispose();
    super.dispose();
  }
}
