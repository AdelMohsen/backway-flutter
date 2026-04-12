import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/colors/styles.dart';

class EmojiRatingWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onRatingSelected;

  const EmojiRatingWidget({
    Key? key,
    required this.selectedIndex,
    required this.onRatingSelected,
  }) : super(key: key);

  static const List<String> _emojis = ['😍', '🙂', '😐', '😒', '😖'];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(_emojis.length, (index) {
        return GestureDetector(
          onTap: () => onRatingSelected(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selectedIndex == index
                  ? AppColors.primaryGreenHub
                  : Colors.transparent,
              border: Border.all(
                color: selectedIndex == index
                    ? AppColors.primaryGreenHub
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: Text(_emojis[index], style: const TextStyle(fontSize: 32)),
          ),
        );
      }),
    );
  }
}
