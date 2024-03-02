import 'package:flutter/material.dart';

class PulseBayTheme {
  static const Color primaryColor = Color(0xff2A79C5);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color bgColor = Color(0xffF7F7F7);
  static const Color transparent = Colors.transparent;
  static const Color textColor = black;

  static const String primaryFontFamily = 'Montserrat';
  static const String secondaryFontFamily = 'Barlow';

  static InputDecoration pbInputDecoration({
    String hint = '',
    String? helperText,
    TextStyle? hintStyle,
    TextStyle? errorStyle,
    bool showBorder = true,
    double borderRadius = 8,
    double borderWidth = 1,
    Color borderColor = const Color(0xffE1E1E1),
    Color focusedBorderColor = primaryColor,
    EdgeInsets padding =
        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
    Widget? suffix,
    Widget? prefix,
    Color? fillColor,
    BoxConstraints? suffixIconConstraints,
  }) =>
      InputDecoration(
        filled: fillColor != null,
        fillColor: fillColor,
        isDense: true,
        suffixIconConstraints: suffixIconConstraints,
        prefixIconConstraints: prefix == null
            ? const BoxConstraints(
                maxWidth: 15,
                minWidth: 15,
              )
            : const BoxConstraints(
                maxWidth: 50,
                minWidth: 50,
              ),
        suffixIcon: suffix,
        prefixIcon: prefix == null
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: prefix,
              ),
        counterText: '',
        contentPadding: padding,
        hintText: hint,
        errorStyle: errorStyle ??
            const TextStyle(
              fontSize: 12,
              color: Colors.red,
            ),
        hintStyle: hintStyle ??
            const TextStyle(
              fontSize: 12,
              color: Color(0xffC5C5C5),
            ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        disabledBorder: showBorder
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  color: const Color(0xffE1E1E1).withOpacity(0.5),
                  width: borderWidth,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              )
            : OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
        enabledBorder: showBorder
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor,
                  width: borderWidth,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              )
            : OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
        focusedBorder: showBorder
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  color: focusedBorderColor,
                  width: borderWidth,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              )
            : OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(
                  borderRadius,
                )),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: borderWidth,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xffE1E1E1),
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      );
}
