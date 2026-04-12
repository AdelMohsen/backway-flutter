import '../../../assets/app_images.dart';
import '../../../theme/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/colors/styles.dart';

class SearchFieldWidget extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function()? onTap;
  const SearchFieldWidget({
    super.key,
    this.hintText,
    this.onTap,
    this.onChanged,
    this.controller,
  });

  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_updateClearIcon);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_updateClearIcon);
    super.dispose();
  }

  void _updateClearIcon() {
    final hasText = widget.controller?.text.isNotEmpty ?? false;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: TextFormField(
        onTap: widget.onTap,
        controller: widget.controller,
        textAlign: TextAlign.right,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: widget.hintText,
          hintStyle: AppTextStyles.cairoW400Size14.copyWith(
            color: AppColors.KgreySearchText,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Image.asset(
              AppImages.searchIcon,
              color: AppColors.KgreySearch,
            ),
          ),
          suffixIcon: _hasText
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: AppColors.KgreySearch,
                    size: 20,
                  ),
                  onPressed: () {
                    widget.controller?.clear();
                    widget.onChanged?.call('');
                  },
                )
              : null,
          focusColor: Colors.red,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: const BorderSide(
              color: Color.fromRGBO(230, 206, 188, 1),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: const BorderSide(
              color: Color.fromRGBO(230, 206, 188, 1),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: const BorderSide(
              color: Color.fromRGBO(230, 206, 188, 1),
            ),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
