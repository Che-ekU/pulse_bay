import 'package:flutter/material.dart';
import 'package:pulse_bay_task/app/constants/theme.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.onTapFunction,
    required this.buttonText,
    this.borderRadius,
    this.verticalPadding,
    this.enabled = true,
    this.margin,
    this.bgColor = PulseBayTheme.primaryColor,
    this.borderColor = Colors.transparent,
    this.textStyle,
    this.fontSize,
    this.fontColor = PulseBayTheme.bgColor,
    this.fontWeight = FontWeight.w700,
  }) : super(key: key);

  final Function onTapFunction;
  final String buttonText;
  final double? borderRadius;
  final double? verticalPadding;
  final bool enabled;
  final EdgeInsets? margin;
  final Color bgColor;
  final Color borderColor;
  final Color fontColor;
  final FontWeight fontWeight;
  final TextStyle? textStyle;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AbsorbPointer(
          absorbing: !enabled,
          child: Container(
            margin: margin,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              color: enabled ? bgColor : bgColor.withOpacity(0.2),
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 10)),
            ),
            child: Material(
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 10)),
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onTapFunction(),
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRadius ?? 10)),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 32, vertical: verticalPadding ?? 12),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius ?? 10)),
                  ),
                  child: Center(
                    child: Text(
                      buttonText,
                      style: (textStyle ??
                              const TextStyle(
                                fontSize: 12,
                              ))
                          .copyWith(
                        color: fontColor,
                        fontWeight: fontWeight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
