// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shimmer/shimmer.dart';

// import '../../../shared/blocs/main_app_bloc.dart';
// import '../../../theme/colors/styles.dart';
// import '../../../theme/text_styles/text_styles.dart';
// import '../../../utils/widgets/text/main_text.dart';
// import '../cubit/app_settings_cubit.dart';
// import '../cubit/app_settings_state.dart';

// enum StaticPageType { terms, privacy, aboutUs }

// class StaticPageDialog extends StatefulWidget {
//   final StaticPageType pageType;

//   const StaticPageDialog({super.key, required this.pageType});

//   static Future<void> show(BuildContext context, StaticPageType pageType) {
//     return showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (context) => StaticPageDialog(pageType: pageType),
//     );
//   }

//   @override
//   State<StaticPageDialog> createState() => _StaticPageDialogState();
// }

// class _StaticPageDialogState extends State<StaticPageDialog>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );

//     _scaleAnimation = CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeOutBack,
//     );

//     _fadeAnimation = CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeOut,
//     );

//     _animationController.forward();

//     // Refresh settings when dialog opens
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<AppSettingsCubit>().refreshSettings();
//     });
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   String _getTitle() {
//     final isArabic = mainAppBloc.isArabic;
//     switch (widget.pageType) {
//       case StaticPageType.terms:
//         return isArabic ? 'الشروط والأحكام' : 'Terms & Conditions';
//       case StaticPageType.privacy:
//         return isArabic ? 'سياسة الخصوصية' : 'Privacy Policy';
//       case StaticPageType.aboutUs:
//         return isArabic ? 'من نحن' : 'About Us';
//     }
//   }

//   IconData _getIcon() {
//     switch (widget.pageType) {
//       case StaticPageType.terms:
//         return Icons.description_outlined;
//       case StaticPageType.privacy:
//         return Icons.shield_outlined;
//       case StaticPageType.aboutUs:
//         return Icons.info_outline;
//     }
//   }

//   String _getContent(AppSettingsCubit cubit) {
//     switch (widget.pageType) {
//       case StaticPageType.terms:
//         return cubit.terms;
//       case StaticPageType.privacy:
//         return cubit.privacy;
//       case StaticPageType.aboutUs:
//         return cubit.aboutUs;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     final isTablet = screenSize.width > 600;
//     final dialogWidth = isTablet
//         ? screenSize.width * 0.6
//         : screenSize.width - 32;
//     final dialogHeight = screenSize.height * 0.75;

//     return FadeTransition(
//       opacity: _fadeAnimation,
//       child: ScaleTransition(
//         scale: _scaleAnimation,
//         child: Dialog(
//           backgroundColor: Colors.transparent,
//           insetPadding: const EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 24,
//           ),
//           child: Container(
//             width: dialogWidth,
//             height: dialogHeight,
//             decoration: BoxDecoration(
//               color: AppColors.kWhite,
//               borderRadius: BorderRadius.circular(24),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.15),
//                   blurRadius: 20,
//                   offset: const Offset(0, 10),
//                 ),
//               ],
//             ),
//             child: Column(
//               children: [
//                 _buildHeader(),
//                 Expanded(child: _buildContent()),
//                 _buildFooter(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             AppColors.primary.withOpacity(0.1),
//             AppColors.primary.withOpacity(0.05),
//           ],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: AppColors.primary.withOpacity(0.15),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(_getIcon(), color: AppColors.primary, size: 24),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: MainText(
//               text: _getTitle(),
//               style: AppTextStyles.cairoW700Size20.copyWith(
//                 color: AppColors.Kblue,
//                 fontSize: 18,
//               ),
//             ),
//           ),
//           InkWell(
//             onTap: () => Navigator.pop(context),
//             borderRadius: BorderRadius.circular(20),
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.grey.withOpacity(0.1),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.close,
//                 color: AppColors.textGrey,
//                 size: 20,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildContent() {
//     return BlocBuilder<AppSettingsCubit, AppSettingsState>(
//       builder: (context, state) {
//         if (state is AppSettingsLoading) {
//           return _buildLoadingShimmer();
//         }

//         if (state is AppSettingsError) {
//           return _buildErrorState(state.errorEntity.message);
//         }

//         final cubit = context.read<AppSettingsCubit>();
//         final content = _getContent(cubit);

//         if (content.isEmpty) {
//           return _buildEmptyState();
//         }

//         return _buildContentText(content);
//       },
//     );
//   }

//   Widget _buildContentText(String content) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(20),
//       physics: const BouncingScrollPhysics(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.grey.withOpacity(0.05),
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: Colors.grey.withOpacity(0.1)),
//             ),
//             child: SelectableText(
//               content,
//               style: AppTextStyles.cairoW400Size14.copyWith(
//                 color: AppColors.kHintText,
//                 height: 1.8,
//                 fontSize: 14,
//               ),
//               textAlign: mainAppBloc.isArabic
//                   ? TextAlign.right
//                   : TextAlign.left,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLoadingShimmer() {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Shimmer.fromColors(
//         baseColor: Colors.grey[300]!,
//         highlightColor: Colors.grey[100]!,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: List.generate(
//             8,
//             (index) => Padding(
//               padding: const EdgeInsets.only(bottom: 12),
//               child: Container(
//                 height: 16,
//                 width: index % 3 == 0 ? double.infinity : double.infinity * 0.8,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildErrorState(String message) {
//     final isArabic = mainAppBloc.isArabic;
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(32),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: AppColors.kRed.withOpacity(0.1),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.error_outline,
//                 color: AppColors.kRed,
//                 size: 48,
//               ),
//             ),
//             const SizedBox(height: 16),
//             // MainText(
//             //   text: isArabic ? 'حدث خطأ' : 'An error occurred',
//             //   style: AppTextStyles.cairoW600Size16.copyWith(
//             //     color: AppColors.Kblue,
//             //   ),
//             // ),
//             const SizedBox(height: 8),
//             // MainText(
//             //   text: message,
//             //   style: AppTextStyles.cairoW400Size14.copyWith(
//             //     color: AppColors.textGrey,
//             //   ),
//             //  textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 24),
//             TextButton.icon(
//               onPressed: () {
//                 context.read<AppSettingsCubit>().refreshSettings();
//               },
//               icon: const Icon(Icons.refresh, size: 18),
//               label: MainText(
//                 text: isArabic ? 'إعادة المحاولة' : 'Retry',
//                 style: AppTextStyles.cairoW500Size14.copyWith(
//                   color: AppColors.primary,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyState() {
//     final isArabic = mainAppBloc.isArabic;
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(32),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.grey.withOpacity(0.1),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(_getIcon(), color: Colors.grey, size: 48),
//             ),
//             const SizedBox(height: 16),
//             MainText(
//               text: isArabic ? 'لا يوجد محتوى' : 'No content available',
//               style: AppTextStyles.cairoW600Size16.copyWith(
//                 color: AppColors.textGrey,
//               ),
//             ),
//             const SizedBox(height: 8),
//             MainText(
//               text: isArabic
//                   ? 'المحتوى غير متوفر حالياً'
//                   : 'Content is not available at the moment',
//               style: AppTextStyles.cairoW400Size14.copyWith(
//                 color: AppColors.textGrey,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFooter() {
//     final isArabic = mainAppBloc.isArabic;
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey.withOpacity(0.05),
//         borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: ElevatedButton(
//               onPressed: () => Navigator.pop(context),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primary,
//                 foregroundColor: AppColors.kWhite,
//                 padding: const EdgeInsets.symmetric(vertical: 14),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 elevation: 0,
//               ),
//               child: MainText(
//                 text: isArabic ? 'حسناً' : 'Got it',
//                 style: AppTextStyles.cairoW600Size16.copyWith(
//                   color: AppColors.kWhite,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
