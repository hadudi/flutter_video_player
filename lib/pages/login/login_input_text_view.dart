import 'package:flutter/cupertino.dart';

class LoginInputTextView extends StatefulWidget {
  const LoginInputTextView({
    Key? key,
    this.controller,
    this.placeholder,
    this.maxLength,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? placeholder;
  final int? maxLength;
  final ValueChanged<String>? onChanged;

  @override
  _LoginInputTextViewState createState() => _LoginInputTextViewState();
}

class _LoginInputTextViewState extends State<LoginInputTextView> {
  late bool hasInput = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: widget.controller,
      cursorHeight: 18,
      cursorColor: const Color(0xfffb6060),
      clearButtonMode: OverlayVisibilityMode.editing,
      maxLength: widget.maxLength,
      padding:
          hasInput ? EdgeInsets.zero : const EdgeInsets.symmetric(vertical: 6),
      textAlignVertical: TextAlignVertical.top,
      textAlign: TextAlign.left,
      decoration: null,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        letterSpacing: 2,
        color: Color(0xff32383a),
      ),
      placeholder: widget.placeholder,
      placeholderStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Color(0xffadb6c2),
        height: 1.5,
      ),
      onChanged: (value) {
        setState(() {
          hasInput = value.isNotEmpty;
        });
        widget.onChanged?.call(value);
      },
    );
  }
}
