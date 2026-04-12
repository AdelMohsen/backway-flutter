// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:greenhub/core/assets/app_svg.dart';
// import 'package:greenhub/core/theme/colors/styles.dart';
// import 'package:greenhub/core/theme/text_styles/text_styles.dart';
// import 'package:greenhub/features/home/ui/widgets/search_home.dart';
// import 'package:greenhub/core/utils/constant/app_strings.dart';
// import 'package:greenhub/core/utils/extensions/extensions.dart';

// class HomeHeaderWidget extends StatelessWidget {
//   const HomeHeaderWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 270,
//       padding: const EdgeInsets.only(bottom: 10),
//       decoration: const BoxDecoration(
//         color: AppColors.primaryGreenHub,
//         gradient: LinearGradient(
//           colors: [AppColors.kLightGreen, AppColors.primaryGreenHub],
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//         ),
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(28),
//           bottomRight: Radius.circular(28),
//         ),
//       ),
//       child: Stack(
//         children: [
//           // Decorative Waves at Top - Layer 1 (Top wave)
//           Positioned(top: 20, left: 5, child: SvgPicture.asset(AppSvg.vector2)),
//           // Decorative Waves at Top - Layer 2 (Bottom wave - under first)
//           Positioned(
//             top: 10,
//             left: -5,
//             child: SvgPicture.asset(AppSvg.vector2),
//           ),
//           // Content
//           SafeArea(
//             bottom: false,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         height: 40,
//                         decoration: BoxDecoration(
//                           color: AppColors.kWhiteOpacity16,
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         child: Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                 right: 12,
//                                 left: 8,
//                               ),
//                               child: Container(
//                                 width: 28,
//                                 height: 28,
//                                 padding: const EdgeInsets.all(6),
//                                 decoration: const BoxDecoration(
//                                   color: AppColors.kLightGreen,
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: SvgPicture.asset(
//                                   AppSvg.location,
//                                   colorFilter: const ColorFilter.mode(
//                                     AppColors.kWhite,
//                                     BlendMode.srcIn,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 2),
//                             Text(
//                               AppStrings.homeLocationAddress.tr,
//                               style: AppTextStyles.ibmPlexSansSize10w500White,
//                             ),
//                             const Icon(
//                               Icons.keyboard_arrow_down,
//                               color: AppColors.kWhite,
//                               size: 20,
//                             ),
//                             SizedBox(width: 4),
//                           ],
//                         ),
//                       ),

//                       Row(
//                         children: [
//                           const SizedBox(width: 12),
//                           _buildCircleIcon(icon: AppSvg.messages),
//                           const SizedBox(width: 8),
//                           _buildCircleIcon(
//                             icon: AppSvg.notification,
//                             hasBadge: true,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 20),

//                   // Title Area
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               AppStrings.homeHeaderTitle.tr,
//                               style: AppTextStyles.ibmPlexSansSize24w700White,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           AppStrings.homeHeaderSubtitle.tr,
//                           style:
//                               AppTextStyles.ibmPlexSansSize12w400WhiteOpacity,
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   // Search Bar & Action Button
//                   Row(
//                     children: [
//                       const Expanded(child: SearchHome()),
//                       const SizedBox(width: 12),
//                       Container(
//                         width: 44,
//                         height: 44,
//                         decoration: const BoxDecoration(
//                           color: AppColors.primaryGreenHub,
//                           shape: BoxShape.circle,
//                         ),
//                         padding: const EdgeInsets.all(8),
//                         child: SvgPicture.asset(
//                           AppSvg.directUp,
//                           colorFilter: const ColorFilter.mode(
//                             AppColors.kWhite,
//                             BlendMode.srcIn,
//                           ),
//                         ),
//                       ),

//                       // Teal Action Button (Separate)
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCircleIcon({required String icon, bool hasBadge = false}) {
//     return Stack(
//       children: [
//         Container(
//           width: 44,
//           height: 44,
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: AppColors.kWhite.withOpacity(0.2),
//             shape: BoxShape.circle,
//           ),
//           child: SvgPicture.asset(icon, color: AppColors.kWhite),
//         ),
//         if (hasBadge)
//           Positioned(
//             top: 10,
//             right: 12,
//             child: Container(
//               width: 8,
//               height: 8,
//               decoration: const BoxDecoration(
//                 color: AppColors.kRed,
//                 shape: BoxShape.circle,
//                 border: Border.fromBorderSide(
//                   BorderSide(color: AppColors.kWhite, width: 1.5),
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }
