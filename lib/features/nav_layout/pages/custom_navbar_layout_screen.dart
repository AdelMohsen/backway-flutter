import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../user/logic/user_cubit.dart';
import '../cubit/navbar_layout_cubit.dart';
import '../cubit/navbar_layout_state.dart';
import 'custom_navbar_layout_mobile_screen.dart';

class CustomNavbarLayoutScreen extends StatefulWidget {
  final int? initialIndex;
  const CustomNavbarLayoutScreen({super.key, this.initialIndex});

  @override
  State<CustomNavbarLayoutScreen> createState() =>
      _CustomNavbarLayoutScreenState();
}

class _CustomNavbarLayoutScreenState extends State<CustomNavbarLayoutScreen> {
  Timer? _notificationTimer;

  @override
  void initState() {
    super.initState();
    // Fetch user profile data when navbar layout is first loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialIndex != null) {
        context.read<NavbarLayoutCubit>().changeIndex(widget.initialIndex!);
      }
      context.read<UserCubit>().getUserProfile();

      // Fetch notifications initially
      //   context.read<NotificationCubit>().getNotifications(isRefresh: true);

      // Setup periodic timer to fetch notifications every 1 minute
      _notificationTimer = Timer.periodic(const Duration(minutes: 1), (_) {
        //   context.read<NotificationCubit>().fetchUnreadCountSilently();
      });
    });
  }

  @override
  void dispose() {
    _notificationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarLayoutCubit, NavbarLayoutState>(
      buildWhen: (previous, current) =>
          previous.currentIndex != current.currentIndex,
      builder: (context, state) {
        return const CustomNavbarLayoutMobilePortraitDesignScreen();
      },
    );
  }
}
