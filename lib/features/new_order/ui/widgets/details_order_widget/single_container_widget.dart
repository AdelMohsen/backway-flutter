import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

class SingleContainerWidget extends StatelessWidget {
  final String? title;
  final Widget? contentChild;
  const SingleContainerWidget({Key? key, this.contentChild, this.title})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            offset: Offset(0, 4),
            blurRadius: 18,
          ),
        ],
      ),
      width: double.infinity,

      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(title ?? "", style: AppTextStyles.ibmPlexSansSize16w600Black),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
            child: contentChild,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
