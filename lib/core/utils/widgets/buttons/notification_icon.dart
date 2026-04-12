// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';

// import '../../../assets/app_svg.dart';
// import '../../../navigation/custom_navigation.dart';
// import '../../../navigation/routes.dart';

// class NotificationIcon extends StatelessWidget {
//   final void Function()? onTap;

//   const NotificationIcon({super.key, this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//     //    CustomNavigator.push(Routes.NotificationScreen);
//       },
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           Container(
//             width: 36,
//             height: 36,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.white,
//               border: Border.all(
//                 color: const Color.fromRGBO(225, 225, 225, 1),
//               ),
//             ),
//             child: Center(
//               child: SizedBox(
//                 width: 20,
//                 height: 20,
//                 child: SvgPicture.asset(AppSvg.notification),
//               ),
//             ),
//           ),
//           if (unreadCount > 0)
//             Positioned(
//               right: -2,
//               top: -2,
//               child: Container(
//                 padding: EdgeInsets.all(unreadCount > 9 ? 3 : 4),
//                 decoration: BoxDecoration(
//                   color: const Color.fromRGBO(244, 67, 54, 1),
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.white, width: 1.5),
//                 ),
//                 constraints: const BoxConstraints(
//                   minWidth: 18,
//                   minHeight: 18,
//                 ),
//                 child: Center(
//                   child: Text(
//                     unreadCount > 99 ? '99+' : unreadCount.toString(),
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 9,
//                       fontWeight: FontWeight.bold,
//                       height: 1,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
