import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_dropdown_form_field.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_form_field.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_username_form_field.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/core/utils/widgets/misc/graident_heaader_layout.dart';

class PaymentDetailsScreen extends StatefulWidget {
  const PaymentDetailsScreen({super.key});

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  String? _selectedPaymentMethod = 'madaCard';

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
      child: CustomScaffoldWidget(
        needAppbar: false,
        child: GradientHeaderLayout(
          title: AppStrings.payment.tr,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 40,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // All fields wrapped in green bordered container
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Color.fromRGBO(243, 243, 243, 1),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultUsernameFormField(
                                hintColor: const Color.fromRGBO(
                                  152,
                                  152,
                                  152,
                                  1,
                                ),
                                hintFontSize: 12,
                                hintFontWeight: FontWeight.w500,
                                hintText: AppStrings.nameOnCard.tr,
                                fillColor: const Color(0xFFF9F9F9),
                                borderRadious: 25,
                                contentPadding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                      20,
                                      15,
                                      20,
                                      22,
                                    ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppStrings.paymentMethod.tr,
                                    style: AppTextStyles
                                        .ibmPlexSansSize10w600White
                                        .copyWith(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                  ),
                                  Text(
                                    AppStrings.change.tr,
                                    style: AppTextStyles
                                        .ibmPlexSansSize10w600White
                                        .copyWith(
                                          color: AppColors.primaryGreenHub,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              DefaultDropdownFormField(
                                prefixIcon: Image.asset(
                                  AppImages.payment,
                                  width: 20,
                                  height: 20,
                                ),
                                value: _selectedPaymentMethod,
                                items: [
                                  DropdownMenuItem(
                                    value: 'madaCard',
                                    child: Text(AppStrings.madaCard.tr),
                                  ),
                                  DropdownMenuItem(
                                    value: 'visaMastercard',
                                    child: Text(AppStrings.visaMastercard.tr),
                                  ),
                                ],
                                onChanged: (val) {
                                  setState(() {
                                    _selectedPaymentMethod = val;
                                  });
                                },
                                fillColor: const Color(0xFFF9F9F9),
                                borderRadious: 45,
                              ),
                              const SizedBox(height: 16),
                              DefaultUsernameFormField(
                                hintText: AppStrings.cardNumber.tr,
                                hintColor: const Color.fromRGBO(
                                  152,
                                  152,
                                  152,
                                  1,
                                ),
                                hintFontSize: 12,
                                hintFontWeight: FontWeight.w500,
                                fillColor: const Color(0xFFF9F9F9),
                                borderRadious: 25,
                                contentPadding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                      20,
                                      15,
                                      20,
                                      22,
                                    ),
                              ),
                              const SizedBox(height: 16),
                              DefaultUsernameFormField(
                                hintText: AppStrings.cvvCode.tr,
                                hintColor: const Color.fromRGBO(
                                  152,
                                  152,
                                  152,
                                  1,
                                ),
                                hintFontSize: 12,
                                hintFontWeight: FontWeight.w500,
                                fillColor: const Color(0xFFF9F9F9),
                                borderRadious: 25,
                                contentPadding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                      20,
                                      15,
                                      20,
                                      22,
                                    ),
                              ),
                              const SizedBox(height: 16),
                              DefaultUsernameFormField(
                                hintText: AppStrings.expiryDate.tr,
                                hintColor: const Color.fromRGBO(
                                  152,
                                  152,
                                  152,
                                  1,
                                ),
                                hintFontSize: 12,
                                hintFontWeight: FontWeight.w500,
                                fillColor: const Color(0xFFF9F9F9),
                                borderRadious: 25,
                                contentPadding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                      20,
                                      15,
                                      20,
                                      22,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        const SizedBox(height: 40),
                        // Button outside the container
                        DefaultButton(
                              height: 56,
                              onPressed: () {
                                // Final payment action
                              },
                              backgroundColor: AppColors.primaryGreenHub,
                              borderRadiusValue: 25,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppStrings.next.tr,
                                    style: AppTextStyles
                                        .ibmPlexSansSize16w700Black
                                        .copyWith(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.kLightGreen,
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: AppColors.kWhite,
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .animate()
                            .fadeIn(duration: 350.ms, delay: 700.ms)
                            .slideY(
                              begin: 0.5,
                              end: 0.0,
                              curve: Curves.fastOutSlowIn,
                            ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
