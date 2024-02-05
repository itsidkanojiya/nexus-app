import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  AppTextField(
      {Key? key,
      this.removeBorder = false,
      this.hintText,
      this.maxLine,
      this.minLine,
      this.bordercolor,
      this.allpading,
      this.symmetricpadding,
      this.textsize,
      this.titaltextcolor,
      this.titalfontsize,
      this.fillcolor,
      this.boxwidth,
      this.prefixIcon,
      this.boxheight,
      this.keyboardType,
      this.maxLength,
      required this.controller,
      this.borderRadius,
      this.validator,
      this.readonly,
      this.maxwidth,
      this.prefixText,
      this.textInputAction,
      this.focusNode,
      this.inputFormatters,
      this.counterStyle,
      this.onChanged,
      this.focusBorder,
      this.enableBorder,
      this.errorBorder,
      this.focusedErrorBorder,
      this.disabledBorder,
      this.fontWeight,
      this.contentpadding,
      this.initialvalue,
      this.hintTextSize,
      this.suffixText,
      this.suffixIcon,
      this.hintColor,
      this.enabled,
      this.onTap})
      : super(key: key);
  final bool removeBorder;
  final String? hintText;
  final int? maxLength;
  final double? boxwidth;
  final double? boxheight;
  final Color? fillcolor;
  final double? symmetricpadding;
  final double? textsize;
  final double? titalfontsize;
  final Color? titaltextcolor;
  final Color? bordercolor;
  final double? maxwidth;
  final EdgeInsetsGeometry? allpading;
  final EdgeInsetsGeometry? contentpadding;
  final int? maxLine;
  final int? minLine;
  final BorderRadius? borderRadius;
  final TextInputType? keyboardType;
  final bool? enabled;
  final Function()? onTap;
  Widget? prefixIcon;
  Widget? suffixIcon;
  bool? condition;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool? readonly;
  final String? prefixText;
  final String? suffixText;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? counterStyle;
  final Function(String)? onChanged;
  final InputBorder? focusBorder;
  final InputBorder? enableBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? disabledBorder;
  final FontWeight? fontWeight;
  final String? initialvalue;
  final double? hintTextSize;
  final Color? hintColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
            maxWidth: maxwidth ?? 500, maxHeight: boxheight ?? double.infinity),
        child: TextFormField(
          minLines: minLine,
          enabled: enabled,
          onChanged: onChanged,
          focusNode: focusNode,
          initialValue: initialvalue,
          inputFormatters: inputFormatters,
          textInputAction: textInputAction,
          readOnly: readonly ?? false,
          validator: validator,
          maxLength: maxLength,
          keyboardType: keyboardType,
          controller: controller,
          maxLines: maxLine ?? 1,
          style: TextStyle(
            fontSize: textsize ?? 17,
            fontWeight: fontWeight ?? FontWeight.bold,
          ),
          decoration: InputDecoration(
            contentPadding: contentpadding,
            counterStyle: counterStyle,
            errorStyle: TextStyle(
              color: Theme.of(context).colorScheme.error,
            ),
            focusedBorder: focusBorder ??
                OutlineInputBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(10),
                  borderSide: removeBorder
                      ? BorderSide.none
                      : const BorderSide(color: Colors.grey, width: 2),
                ),
            enabledBorder: enableBorder ??
                OutlineInputBorder(
                    borderRadius: borderRadius ?? BorderRadius.circular(10),
                    borderSide: removeBorder
                        ? BorderSide.none
                        : const BorderSide(color: Colors.grey, width: 2)),
            errorBorder: errorBorder ??
                OutlineInputBorder(
                    borderRadius: borderRadius ?? BorderRadius.circular(10),
                    borderSide: removeBorder
                        ? BorderSide.none
                        : const BorderSide(color: Colors.grey, width: 2)),
            focusedErrorBorder: focusedErrorBorder ??
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: removeBorder
                        ? BorderSide.none
                        : const BorderSide(color: Colors.grey, width: 2)),
            disabledBorder: disabledBorder ??
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: removeBorder
                        ? BorderSide.none
                        : const BorderSide(color: Colors.grey, width: 2)),
            fillColor: fillcolor ?? Colors.white,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(
                color: hintColor ?? Colors.grey, fontSize: hintTextSize),
            prefixIcon: prefixIcon,
            prefixText: prefixText,
            suffixIcon: suffixIcon,
            suffixText: prefixText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
