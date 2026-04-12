// // custom_head_widget.dart
// import 'package:flutter/material.dart';
// import '../../theme/text_styles/text_styles.dart';
// import '../../utils/constant/app_strings.dart';
// import '../../utils/extensions/extensions.dart';
// import '../../utils/widgets/form_fields/search_field_widget.dart';

// import '../../utils/widgets/tab_bar/main_tab_bar.dart';

// class CustomHeadWidget extends StatelessWidget {
//   final Widget? leftIcon;
//   final Widget? rightIcon;
//   final String? title;
//   final bool needContainerTitle;
//   final bool? needSearchBar;
//   final bool needSizedBox;
//   final double? customHeight;
//   final double? itemSpacing;
//   final bool? needSegmentLine;
//   final bool? neddSizedHeightOnBoarding;
//   final bool? needSegmentBar;
//   final List<String>? segmentItems;
//   final void Function(int index)? onSegmentTap;
//   final TabController? tabController;
//   final TextStyle? titleStyle;
//   final TextEditingController? searchController;
//   final void Function(String)? onSearchChanged;
//   final bool? shouldAutoScrollToTab;

//   const CustomHeadWidget({
//     super.key,
//     this.leftIcon,
//     this.itemSpacing,
//     this.needSearchBar,
//     this.neddSizedHeightOnBoarding,
//     this.rightIcon,
//     this.title,
//     this.needSegmentLine,
//     this.needContainerTitle = false,
//     this.needSizedBox = false,
//     this.customHeight,
//     this.needSegmentBar,
//     this.segmentItems,
//     this.onSegmentTap,
//     this.tabController,
//     this.titleStyle,
//     this.searchController,
//     this.onSearchChanged,
//     this.shouldAutoScrollToTab,
//   });

//   @override
//   Widget build(BuildContext context) {
//     var ScreenWidth = MediaQuery.of(context).size.width;
//     return Stack(
//       alignment: Alignment.bottomCenter,
//       children: [
//         Column(
//           children: [
//             neddSizedHeightOnBoarding == true
//                 ? const SizedBox(height: 24)
//                 : const SizedBox.shrink(),
//             // Top row: right icon, search bar, title, left icon
//             Padding(
//               padding: const EdgeInsets.only(left: 16, right: 16, top: 30),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   rightIcon ?? const SizedBox(),

//                   if (needSearchBar == true)
//                     Flexible(
//                       child: Padding(
//                         padding: const EdgeInsets.only(right: 4, left: 4),
//                         child: SearchFieldWidget(
//                           controller:
//                               searchController ?? TextEditingController(),
//                           hintText: AppStrings.searchCategories.tr,
//                           onChanged: onSearchChanged,
//                         ),
//                       ),
//                     ),

//                   needContainerTitle == true
//                       ? Text(
//                           title ?? '',
//                           textAlign: TextAlign.center,
//                           style:
//                               titleStyle ??
//                               AppTextStyles.cairoW600Size16.copyWith(
//                                 color: const Color.fromRGBO(93, 93, 93, 1),
//                               ),
//                         )
//                       : const SizedBox(),
//                   leftIcon ?? const SizedBox(),
//                 ],
//               ),
//             ),

//             // Optional spacing
//             needSizedBox == true
//                 ? const SizedBox(height: 30)
//                 : const SizedBox(),

//             // Segment buttons
//             needSegmentBar == true
//                 ? _buildSegmentBar(
//                     screenWidth: ScreenWidth,
//                     needSegmentLine: needSegmentLine,
//                   )
//                 : const SizedBox(),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildSegmentBar({screenWidth, needSegmentLine}) {
//     if (segmentItems == null || segmentItems!.isEmpty) return const SizedBox();

//     return Column(
//       children: [
//         needSegmentLine == true
//             ? Container(
//                 decoration: const BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       blurRadius: 0.5,
//                       color: Color.fromRGBO(225, 225, 225, 1),
//                     ),
//                   ],

//                   color: Color.fromRGBO(225, 225, 225, 1),
//                 ),
//                 width: screenWidth,
//                 height: 0.5,
//               )
//             : const SizedBox.shrink(),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 4),
//           child: CustomSegmentTextOnly(
//             items: segmentItems!,
//             tabController: tabController,
//             onTap: onSegmentTap,
//             scrollable: true,
//             shouldAutoScroll: shouldAutoScrollToTab ?? false,
//             itemSpacing: itemSpacing ?? 14,
//             selectedTextStyle: AppTextStyles.cairoW700Size20.copyWith(
//               color: const Color.fromRGBO(244, 158, 93, 1),
//               fontSize: 16,
//             ),
//             unselectedTextStyle: AppTextStyles.cairoW600Size16.copyWith(
//               color: const Color.fromRGBO(106, 106, 106, 1),
//             ),
//             dividerSpacing: 1,
//           ),
//         ),
//       ],
//     );
//   }
// }
