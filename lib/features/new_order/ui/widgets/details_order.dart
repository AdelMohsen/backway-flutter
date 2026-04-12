import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_form_field.dart';
import 'package:greenhub/features/new_order/logic/cubit/create_order_cubit.dart';
import 'package:greenhub/features/new_order/logic/state/create_order_state.dart';
import 'package:greenhub/features/new_order/ui/pages/map_picker_screen.dart';
import 'package:greenhub/features/new_order/ui/widgets/details_order_widget/transport_type_section_widget.dart';
import 'package:greenhub/features/new_order/ui/widgets/details_order_widget/shipment_data_section_widget.dart';
import 'package:greenhub/features/new_order/ui/widgets/details_order_widget/address_section_widget.dart';
import 'package:greenhub/features/new_order/ui/widgets/details_order_widget/image_upload_section_widget.dart';
import 'package:greenhub/features/new_order/ui/widgets/details_order_widget/notes_section_widget.dart';

class DetailsOrderWidget extends StatefulWidget {
  final int step;
  final int? orderType;
  final VoidCallback onNextStep;

  const DetailsOrderWidget({
    Key? key,
    required this.step,
    this.orderType,
    required this.onNextStep,
  }) : super(key: key);

  @override
  State<DetailsOrderWidget> createState() => _DetailsOrderWidgetState();
}

class _DetailsOrderWidgetState extends State<DetailsOrderWidget> {
  final FocusNode phoneFocusNode = FocusNode();
  bool showExtraFields = false;
  bool isFirstOptionSelected = true; // transport selected by default

  // Date controllers for history fields
  final TextEditingController dateController1 = TextEditingController();
  final TextEditingController dateController2 = TextEditingController();
  final TextEditingController dateController3 = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.orderType == 1) {
      showExtraFields = true;
    }
    // Set order type based on orderType parameter
    final cubit = context.read<CreateOrderCubit>();
    cubit.setOrderType(widget.orderType ?? 0);
  }

  @override
  void dispose() {
    dateController1.dispose();
    dateController2.dispose();
    dateController3.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }

  Future<void> _pickDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final initialDate = DateTime.now();
    final firstDate = DateTime(2000);
    final lastDate = DateTime(2100);

    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => Container(
          height: 250,
          color: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: Text(
                      AppStrings.cancel.tr,
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoButton(
                    child: Text(
                      AppStrings.confirm.tr,
                      style: TextStyle(color: AppColors.primaryGreenHub),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Expanded(
                child: CupertinoDatePicker(
                  initialDateTime: initialDate,
                  minimumDate: firstDate,
                  maximumDate: lastDate,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime newDate) {
                    controller.text = DateFormat('yyyy-MM-dd').format(newDate);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.primaryGreenHub,
                onPrimary: Colors.white,
                onSurface: AppColors.kBlack,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primaryGreenHub,
                ),
              ),
            ),
            child: child!,
          );
        },
      );
      if (picked != null) {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      }
    }
  }

  void _openMapPicker({required bool isPickup}) async {
    FocusScope.of(context).unfocus();
    final cubit = context.read<CreateOrderCubit>();
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (_) => MapPickerScreen(
          initialLat: isPickup ? cubit.pickupLat : cubit.deliveryLat,
          initialLng: isPickup ? cubit.pickupLng : cubit.deliveryLng,
        ),
      ),
    );
    FocusManager.instance.primaryFocus?.unfocus();
    if (result != null) {
      final lat = result['lat'] as double;
      final lng = result['lng'] as double;
      final address = result['address'] as String;
      if (isPickup) {
        cubit.setPickupLocation(lat, lng, address);
      } else {
        cubit.setDeliveryLocation(lat, lng, address);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<CreateOrderCubit>();

    return SingleChildScrollView(
      child: Column(
        children: [
          /// Transport Type
          TransportTypeSectionWidget(
            selectedVehicleTypeId: cubit.selectedVehicleTypeId,
            vehicleTypes: cubit.vehicleTypes,
            showExtraFileds: showExtraFields,
            isFirstOptionSelected: isFirstOptionSelected,
            onVehicleTypeChanged: (value) {
              setState(() {
                cubit.setVehicleType(value);
              });
            },
            onFirstOptionTap: () {
              setState(() {
                isFirstOptionSelected = true;
              });
              cubit.setServiceType('transport');
            },
            onSecondOptionTap: () {
              setState(() {
                isFirstOptionSelected = false;
              });
              cubit.setServiceType('installation');
            },
          ),

          const SizedBox(height: 16),

          /// Shipment Data
          ShipmentDataSectionWidget(
            phoneFocusNode: phoneFocusNode,
            showExtraFileds: showExtraFields,
            weightController: cubit.weightController,
            phoneController: cubit.phoneController,
            selectedPackageTypeId: cubit.selectedPackageTypeId,
            packageTypes: cubit.packageTypes,
            selectedPackageSize: cubit.selectedPackageSize,
            vehiclesCount: cubit.vehiclesCount,
            onPackageTypeChanged: (value) {
              setState(() {
                cubit.setPackageType(value);
              });
            },
            onPackageSizeChanged: (value) {
              setState(() {
                cubit.setPackageSize(value);
              });
            },
            onIncrement: () {
              setState(() {
                cubit.incrementVehiclesCount();
              });
            },
            onDecrement: () {
              setState(() {
                cubit.decrementVehiclesCount();
              });
            },
          ),

          const SizedBox(height: 16),

          /// Address
          AddressSectionWidget(
            fromController: cubit.fromController,
            toController: cubit.toController,
            onFromTap: () => _openMapPicker(isPickup: true),
            onToTap: () => _openMapPicker(isPickup: false),
          ),

          const SizedBox(height: 16),

          ImageUploadSectionWidget(
            onUploadTap: () {
              setState(() {
                cubit.pickImages();
              });
            },
            selectedImages: cubit.packageImages,
            onRemoveImage: (index) {
              setState(() {
                cubit.removeImage(index);
              });
            },
          ),

          const SizedBox(height: 16),

          /// Notes
          NotesSectionWidget(notesController: cubit.notesController),

          const SizedBox(height: 16),

          /// Extra Fields
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: showExtraFields
                ? _buildExtraFields()
                : const SizedBox.shrink(),
          ),

          const SizedBox(height: 20),

          /// Button
          BlocBuilder<CreateOrderCubit, CreateOrderState>(
            builder: (context, state) {
              final isLoading = state is CreateOrderLoading;
              return Padding(
                padding: const EdgeInsets.all(5),
                child: DefaultButton(
                  onPressed: isLoading ? null : _onNextPressed,
                  borderRadius: BorderRadius.circular(44),
                  width: double.infinity,
                  height: 56,
                  child: Center(
                    child: isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : Text(
                            AppStrings.next.tr,
                            style: AppTextStyles.ibmPlexSansSize18w600White,
                          ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// ================= Actions =================
  void _onNextPressed() {
    context.read<CreateOrderCubit>().createOrder();
  }

  /// ================= Extra Fields =================
  Widget _buildExtraFields() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            offset: Offset(2, 4),
            blurRadius: 4,
          ),
        ],
      ),
      width: double.infinity,
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            AppStrings.date.tr,
            style: AppTextStyles.ibmPlexSansSize16w600Black,
          ),
          const SizedBox(height: 14),
          _historyField(
            controller: context.read<CreateOrderCubit>().scheduledAtController,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.3, end: 0.0);
  }

  Widget _historyField({required TextEditingController controller}) {
    return DefaultFormField(
      textAlign: TextAlign.start,
      controller: controller,
      readOnly: true,
      onTap: () => _pickDate(context, controller),
      keyboardType: TextInputType.datetime,
      hintText: "YYYY-MM-DD",
      suffixIcon: Padding(
        padding: const EdgeInsets.all(14),
        child: SvgPicture.asset(AppSvg.calendar),
      ),
      hintStyle: AppTextStyles.ibmPlexSansSize10w600White.copyWith(
        color: AppColors.kTitleText,
      ),
      fillColor: const Color.fromRGBO(247, 247, 247, 1),
      borderColor: const Color.fromRGBO(247, 247, 247, 1),
      borderRadious: 25,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      needValidation: false,
    );
  }
}
