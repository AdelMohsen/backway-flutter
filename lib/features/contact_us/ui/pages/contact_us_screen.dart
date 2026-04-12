import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/core/utils/widgets/misc/graident_heaader_layout.dart';
import 'package:greenhub/features/contact_us/ui/widgets/contact_options_widget.dart';
import 'package:greenhub/features/contact_us/ui/widgets/social_media_links_widget.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/features/contact_us/logic/cubit/social_links_cubit.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      child: BlocProvider(
        create: (context) => SocialLinksCubit()..getSocialLinks(),
        child: CustomScaffoldWidget(
          needAppbar: false,
          child: GradientHeaderLayout(
            title: AppStrings.contactUs.tr,
            child: Builder(
              builder: (context) {
                return RefreshIndicator(
                  onRefresh: () => context.read<SocialLinksCubit>().getSocialLinks(),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        const ContactOptionsWidget(),
                        const SizedBox(height: 20),
                        const SocialMediaLinksWidget(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
