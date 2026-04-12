import 'package:flutter/material.dart';
import '../../../../core/utils/widgets/shimmer/custom_shimmer.dart';

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 8,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.withOpacity(0.1)),
          ),
          child: Row(
            children: [
              const CustomShimmerContainer(
                width: 56,
                height: 56,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomShimmerText(width: 120),
                    const SizedBox(height: 8),
                    const CustomShimmerText(width: double.infinity),
                    const SizedBox(height: 4),
                    const CustomShimmerText(width: 200),
                    const SizedBox(height: 12),
                    const CustomShimmerContainer(
                      width: 80,
                      height: 22,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
