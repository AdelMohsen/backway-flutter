import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_form_field.dart';

class RateDriverCommentField extends StatelessWidget {
  final TextEditingController controller;

  const RateDriverCommentField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Add your comment",
              style: Styles.urbanistSize14w500Orange.copyWith(
                color: const Color.fromRGBO(64, 64, 64, 1),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(249, 249, 249, 1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: DefaultFormField(
              textAlign: TextAlign.start,
              controller: controller,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Write your review",
                hintStyle: Styles.urbanistSize12w400Orange.copyWith(
                  color: const Color.fromRGBO(148, 163, 184, 1),
                ),
                contentPadding: const EdgeInsets.all(16),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
