import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme/colors/styles.dart';

class DefaultTypeDropdownField extends StatefulWidget {
  final List<String> items; // Dropdown items
  final String labelText; // Label text
  final String hintText; // Placeholder text
  final double borderRadious; // Corner radius
  final TextEditingController controller; // Controller to manage text input
  final double? width;
  final TextStyle? hintstyle;
  final double? height;
  final bool? needicon;
  const DefaultTypeDropdownField({
    Key? key,
    required this.items,
    required this.labelText,
    this.width,
    this.needicon,
    this.hintstyle,
    this.height,
    required this.hintText,
    required this.borderRadious,
    required this.controller,
  }) : super(key: key);

  @override
  _DefaultTypeDropdownFieldPersonalState createState() =>
      _DefaultTypeDropdownFieldPersonalState();
}

class _DefaultTypeDropdownFieldPersonalState
    extends State<DefaultTypeDropdownField> {
  bool isOpen = false;
  String? selectedValue; // Holds the value of the selected item

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadious),
        border: Border.all(
          color: isOpen ? AppColors.primary : Colors.grey.shade300,
        ),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          iconEnabledColor: isOpen ? AppColors.primary : Colors.grey.shade300,

          onTap: () {
            setState(() => isOpen = true);
          },

          isExpanded: true,
          value: selectedValue,
          hint: Text(
            widget.hintText,
            style:
                widget.hintstyle ??
                GoogleFonts.cairo(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.Kblue,
                ),
          ),
          dropdownColor: Colors.white,
          style: GoogleFonts.cairo(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.Kblue,
          ),
          focusColor: AppColors.KIcon,

          items: widget.items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item),

                  widget.needicon == true
                      ? const Icon(
                          Icons.edit,
                          size: 18,
                          color: Color.fromRGBO(244, 158, 93, 1),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedValue = newValue;
              widget.controller.text =
                  newValue ?? ''; // Update controller's text
            });
          },
        ),
      ),
    );
  }
}
