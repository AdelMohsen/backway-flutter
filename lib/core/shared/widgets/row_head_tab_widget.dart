// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../theme/text_styles/text_styles.dart';
// import '../../../features/new_order/logic/row_head_tab_cubit.dart';

// class RowHeadTabWidget extends StatelessWidget {
//   final List<String> items;

//   final bool showDividers;
//   final bool useExpanded;
//   final double dividerSpacing;
//   final double itemSpacing;

//   const RowHeadTabWidget({
//     super.key,
//     required this.items,
//     this.showDividers = true,
//     this.useExpanded = false, // default = scroll mode
//     this.dividerSpacing = 8,
//     this.itemSpacing = 16,
//   });

//   double _getTextWidth(String text, TextStyle style) {
//     final textPainter = TextPainter(
//       text: TextSpan(text: text, style: style),
//       maxLines: 1,
//       textDirection: TextDirection.ltr,
//     )..layout();
//     return textPainter.size.width;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<RowHeadTabCubit, int>(
//       builder: (context, selectedIndex) {
//         final row = Row(
//           mainAxisAlignment: useExpanded
//               ? MainAxisAlignment.spaceBetween
//               : MainAxisAlignment.start,
//           children: List.generate(items.length * 2 - 1, (index) {
//             /// ───── DIVIDER | ─────
//             if (index.isOdd) {
//               if (!showDividers) return const SizedBox.shrink();

//               return Padding(
//                 padding: EdgeInsets.symmetric(horizontal: dividerSpacing),
//                 child: const Text(
//                   '|',
//                   style: TextStyle(color: Color.fromRGBO(225, 225, 225, 1)),
//                 ),
//               );
//             }

//             /// ───── ITEM ─────
//             final itemIndex = index ~/ 2;
//             final isSelected = itemIndex == selectedIndex;

//             final selectedStyle = AppTextStyles.cairoW700Size20.copyWith(
//               fontSize: 14,
//               color: const Color.fromRGBO(244, 158, 93, 1),
//             );

//             final unSelectedStyle = AppTextStyles.cairoW600Size16.copyWith(
//               color: const Color.fromRGBO(93, 93, 93, 1),
//               fontSize: 14,
//             );

//             Widget item = GestureDetector(
//               onTap: () {
//                 context.read<RowHeadTabCubit>().change(itemIndex);
//               },
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: itemSpacing,
//                   vertical: 8,
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       items[itemIndex],
//                       style: isSelected ? selectedStyle : unSelectedStyle,
//                       textAlign: TextAlign.center,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 4),
//                     AnimatedContainer(
//                       duration: const Duration(milliseconds: 200),
//                       height: 2,
//                       width: isSelected
//                           ? _getTextWidth(items[itemIndex], selectedStyle)
//                           : 0,
//                       color: const Color.fromRGBO(244, 158, 93, 1),
//                     ),
//                   ],
//                 ),
//               ),
//             );

//             /// ✅ Expanded mode (بدون Scroll)
//             if (useExpanded) {
//               item = Expanded(child: item);
//             }

//             return item;
//           }),
//         );

//         /// ✅ اختيار الوضع
//         if (useExpanded) {
//           return row;
//         }

//         /// ✅ Scroll mode
//         return SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           physics: const BouncingScrollPhysics(),
//           child: row,
//         );
//       },
//     );
//   }
// }
