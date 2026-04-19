import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

class TripStep {
  final String label;
  final bool isCompleted;
  final int stepNumber;

  TripStep({
    required this.label,
    required this.isCompleted,
    required this.stepNumber,
  });
}

class TripProgressTimeline extends StatelessWidget {
  final List<TripStep> steps;

  const TripProgressTimeline({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color.fromRGBO(254, 254, 254, 1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color.fromRGBO(245, 245, 245, 1),
          width: 0.8,
        ),
      ),
      child: Column(
        children: List.generate(steps.length, (index) {
          final step = steps[index];
          final isLast = index == steps.length - 1;

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    // Circle
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: step.isCompleted
                                ? const Color.fromRGBO(236, 253, 245, 1)
                                : Colors.transparent,
                          ),
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: step.isCompleted
                                ? Color.fromRGBO(16, 185, 129, 1)
                                : const Color.fromRGBO(229, 231, 235, 1),
                          ),
                          child: Center(
                            child: step.isCompleted
                                ? const Icon(
                                    Icons.check,
                                    size: 16,
                                    color: Colors.white,
                                  )
                                : Text(
                                    step.stepNumber.toString(),
                                    style: Styles.urbanistSize12w600Orange
                                        .copyWith(
                                          color: const Color.fromRGBO(
                                            107,
                                            114,
                                            128,
                                            1,
                                          ),
                                        ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                    // Line
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 1,
                          color: const Color.fromRGBO(243, 244, 246, 1),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 20),
                        child: Text(
                          step.label,
                          style: Styles.urbanistSize16w600White.copyWith(
                            color: step.isCompleted
                                ? const Color.fromRGBO(5, 150, 105, 1)
                                : const Color.fromRGBO(107, 114, 128, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
