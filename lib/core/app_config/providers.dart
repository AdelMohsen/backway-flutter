// ignore: implementation_imports
import 'package:flutter_bloc/src/bloc_provider.dart' show BlocProvider;
import 'package:greenhub/features/user/logic/user_cubit.dart';
import 'package:greenhub/features/wallet/logic/cubit/wallet_cubit.dart';

import '../../features/nav_layout/cubit/navbar_layout_cubit.dart';

abstract class ProviderList {
  static List<BlocProvider> providers = [
    BlocProvider<UserCubit>(create: (_) => UserCubit()..getUserProfile()),
    BlocProvider<NavbarLayoutCubit>(create: (_) => NavbarLayoutCubit()),
    BlocProvider<WalletCubit>(
      create: (_) => WalletCubit()..fetchWalletData(type: 'credit'),
    ),
  ];
}
