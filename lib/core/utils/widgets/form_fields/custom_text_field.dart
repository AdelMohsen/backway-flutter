import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../theme/colors/styles.dart';

import '../text/main_text.dart';

class CustomTextField extends StatefulWidget {
  final bool isReadOnly, isVisibleText, addBorder;
  final String? label,
      /*fontFamily,*/ suffixImage,
      prefixImage,
      hint,
      suffix,
      headLabel;
  final Size? size;
  final TextAlign? textAlign;
  final bool? isFilled;
  final bool? isPassword;
  final bool autoFocus;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final FocusNode? focus;
  final TextInputType? type;
  final TextInputAction keyboardAction;
  final VoidCallback? onTap, onChangeVisibility;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSaved;
  final AutovalidateMode autoValidateMode;
  final TextEditingController? controller;
  final String? Function(String?)? validation;
  final double verticalPadding, horizontalPadding;
  final int? maxLines;
  final int? minLines;
  final double? borderWidth, prefixImageHeight, prefixImageWidth, borderRadius;
  final List<TextInputFormatter>? inputFormatters;
  final Color? color, hintColor;
  final Widget? suffixWidget;
  final String? init;
  final TextStyle? headStyle, hintStyle;
  final bool headStart;
  final double headSpace;

  const CustomTextField({
    super.key,
    this.hint,
    this.init,
    this.onChanged,
    this.onTap,
    this.prefixIcon,
    this.prefixImage,
    this.type,
    this.controller,
    this.focus,
    this.isReadOnly = false,
    this.isVisibleText = true,
    this.keyboardAction = TextInputAction.next,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.suffixImage,
    this.validation,
    this.label,
    // this.fontFamily,
    this.onChangeVisibility,
    this.size,
    this.verticalPadding = 0,
    this.horizontalPadding = 0,
    this.maxLines = 1,
    this.minLines,
    this.color,
    this.inputFormatters,
    this.isFilled,
    this.borderWidth,
    this.autoFocus = false,
    this.suffix,
    this.textAlign,
    this.isPassword,
    this.hintColor,
    this.headLabel,
    this.suffixIcon,
    this.suffixWidget,
    this.addBorder = true,
    this.onSaved,
    this.prefixImageHeight,
    this.prefixImageWidth,
    this.headStyle,
    this.headStart = true,
    this.headSpace = 4,
    this.borderRadius,
    this.hintStyle,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isHidden = true;

  void _visibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.horizontalPadding,
        vertical: widget.verticalPadding,
      ),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          crossAxisAlignment: widget.headStart
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.headLabel != null)
              MainText(
                text: widget.headLabel,
                color:
                    (widget.headLabel!.contains('*') &&
                        widget.validation == null)
                    ? AppColors.kRed
                    : AppColors.kBlack,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                style: widget.headStyle,
              ),
            if (widget.headLabel != null) SizedBox(height: widget.headSpace),
            TextFormField(
              onFieldSubmitted: widget.onSaved,
              textAlign: widget.textAlign ?? TextAlign.start,
              validator: widget.validation,
              autovalidateMode: widget.autoValidateMode,
              controller: widget.controller,
              autofocus: widget.autoFocus,
              autocorrect: false,
              focusNode: widget.focus,
              initialValue: widget.init,
              readOnly: widget.onTap != null ? true : widget.isReadOnly,
              enabled: widget.onTap != null ? false : !widget.isReadOnly,
              minLines: widget.minLines,
              maxLines: widget.maxLines,
              obscureText: widget.isPassword == true ? _isHidden : false,
              keyboardType: widget.type,
              textInputAction: widget.keyboardAction,
              onChanged: (v) {
                setState(() {});
                widget.onChanged?.call(v);
              },
              onTapOutside: (v) => FocusScope.of(context).unfocus(),
              inputFormatters: widget.type == TextInputType.phone
                  ? [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11),
                    ]
                  : widget.inputFormatters,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.kBlack,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                fillColor: widget.color ?? AppColors.kWhite,
                errorStyle: const TextStyle(color: AppColors.kRed),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 15,
                ),
                hintText: widget.hint,
                alignLabelWithHint: true,
                prefixIcon: widget.prefixImage != null
                    ? Padding(
                        padding: const EdgeInsets.only(right: 16, left: 16),
                        child: Image.asset(
                          'assets/images/${widget.prefixImage!}.png',
                          height: widget.prefixImageHeight ?? 24,
                          width: widget.prefixImageWidth ?? 24,
                        ),
                      )
                    : null,
                labelText: widget.label,
                errorMaxLines: 2,
                icon: widget.prefixIcon != null
                    ? Icon(widget.prefixIcon)
                    : null,
                labelStyle: const TextStyle(
                  fontSize: 14,
                  color: AppColors.kBlack,
                  fontWeight: FontWeight.w400,
                ),
                hintStyle:
                    widget.hintStyle ??
                    TextStyle(
                      fontSize: 14,
                      color: widget.hintColor ?? AppColors.kBlack,
                      fontWeight: FontWeight.w400,
                    ),
                suffixIcon:
                    widget.suffixWidget ??
                    (widget.suffix != null
                        ? MainText(
                            text: widget.suffix,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.kPrimary,
                            verPadding: 17,
                          )
                        : widget.suffixIcon != null
                        ? Icon(widget.suffixIcon, size: 25)
                        : widget.suffixImage != null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Image.asset(
                              'assets/images/${widget.suffixImage!}.png',
                              height: 18,
                              width: 18,
                              color: widget.controller!.text.isEmpty
                                  ? AppColors.kPrimary.withOpacity(0.5)
                                  : AppColors.kPrimary,
                            ),
                          )
                        : widget.isPassword == true
                        ? IconButton(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            onPressed: _visibility,
                            alignment: Alignment.center,
                            icon: _isHidden
                                ? Image.asset(
                                    'assets/images/eye.png',
                                    fit: BoxFit.cover,
                                    height: 16.55,
                                    width: 19.59,
                                    color: AppColors.kBlack,
                                  )
                                : Image.asset(
                                    'assets/images/eye.png',
                                    fit: BoxFit.cover,
                                    height: 16.55,
                                    width: 19.59,
                                    color: AppColors.kPrimary,
                                  ),
                          )
                        : null),
                filled: widget.isFilled ?? true,
                // fillColor: color,
                enabledBorder: !widget.addBorder
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(widget.borderRadius ?? 13),
                        ),
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: AppColors.kPrimary.withOpacity(0.45),
                        ),
                      ).copyWith(
                        borderSide: const BorderSide(color: AppColors.kWhite),
                      )
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(widget.borderRadius ?? 13),
                        ),
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: AppColors.kPrimary.withOpacity(0.45),
                        ),
                      ).copyWith(
                        borderSide: BorderSide(
                          color: AppColors.kBlack,
                          width: (widget.controller?.text.isNotEmpty ?? false)
                              ? 1.5
                              : 1,
                          style: widget.borderWidth == 0
                              ? BorderStyle.none
                              : BorderStyle.solid,
                        ),
                      ),
                disabledBorder: !widget.addBorder
                    ? null
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(widget.borderRadius ?? 13),
                        ),
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: AppColors.kPrimary.withOpacity(0.45),
                          width: 1,
                        ),
                      ).copyWith(
                        borderSide: BorderSide(
                          width: widget.borderWidth ?? 1,
                          color: AppColors.kBlack,
                        ),
                      ),
                focusedBorder:
                    OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(widget.borderRadius ?? 13),
                      ),
                      borderSide: BorderSide(
                        style: BorderStyle.solid,
                        color: AppColors.kPrimary.withOpacity(0.45),
                        width: 1,
                      ),
                    ).copyWith(
                      borderSide: widget.addBorder
                          ? null
                          : const BorderSide(width: 0, color: AppColors.kWhite),
                    ),
                errorBorder: !widget.addBorder
                    ? null
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(widget.borderRadius ?? 13),
                        ),
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: AppColors.kPrimary.withOpacity(0.45),
                          width: 1,
                        ),
                      ).copyWith(
                        borderSide: BorderSide(
                          width: widget.borderWidth ?? 1,
                          color: AppColors.kRed,
                        ),
                      ),
                border: !widget.addBorder
                    ? null
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(widget.borderRadius ?? 13),
                        ),
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: AppColors.kPrimary.withOpacity(0.45),
                          width: 1,
                        ),
                      ).copyWith(
                        borderSide: BorderSide(width: widget.borderWidth ?? 1),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
