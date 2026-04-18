import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

class RateDriverFeedbackChips extends StatelessWidget {
  final List<String> tags;
  final List<String> selectedTags;
  final ValueChanged<String> onTagToggle;

  const RateDriverFeedbackChips({
    super.key,
    required this.tags,
    required this.selectedTags,
    required this.onTagToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 32),
        Text(
          "How was the delivery?",
          style: Styles.urbanistSize20w500Orange.copyWith(
            color: const Color.fromRGBO(64, 64, 64, 1),
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 8,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: tags.map((tag) {
            final isSelected = selectedTags.contains(tag);
            return GestureDetector(
              onTap: () => onTagToggle(tag),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color.fromRGBO(245, 243, 255, 1)
                      : const Color.fromRGBO(243, 244, 246, 1),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isSelected
                        ? ColorsApp.kPrimary
                        : const Color.fromRGBO(243, 244, 246, 1),
                    width: isSelected ? 1 : 2,
                  ),
                ),
                child: Text(
                  tag,
                  style: Styles.urbanistSize12w600Orange.copyWith(
                    color: isSelected
                        ? ColorsApp.kPrimary
                        : const Color.fromRGBO(107, 114, 128, 1),
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
