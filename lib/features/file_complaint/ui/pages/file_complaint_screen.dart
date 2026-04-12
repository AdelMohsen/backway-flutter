import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/core/utils/widgets/misc/graident_heaader_layout.dart';
import 'package:greenhub/features/file_complaint/ui/widgets/complaint_title_field.dart';
import 'package:greenhub/features/file_complaint/ui/widgets/complaint_description_field.dart';
import 'package:greenhub/features/file_complaint/ui/widgets/complaint_image_upload.dart';
import 'package:greenhub/features/file_complaint/ui/widgets/complaint_submit_button.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/services/toast/toast_service.dart';
import '../../../../core/utils/widgets/bottom_sheets/success_bottom_sheet.dart';
import '../../logic/cubit/file_complaint_cubit.dart';
import '../../logic/state/file_complaint_state.dart';
import 'package:image_picker/image_picker.dart';

class FileComplaintScreen extends StatelessWidget {
  const FileComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FileComplaintCubit(),
      child: const _FileComplaintView(),
    );
  }
}

class _FileComplaintView extends StatelessWidget {
  const _FileComplaintView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FileComplaintCubit>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      child: BlocConsumer<FileComplaintCubit, FileComplaintState>(
        listener: (context, state) {
          if (state is FileComplaintSuccess) {
            SuccessBottomSheet.show(
              context,
              title: AppStrings.complaintCreatedSuccessfully.tr,
              onDismiss: () {
                CustomNavigator.push(Routes.NAV_LAYOUT, clean: true);
              },
            );
          } else if (state is FileComplaintError) {
            ToastService.showError(state.error.message, context);
          }
        },
        builder: (context, state) {
          return CustomScaffoldWidget(
            needAppbar: false,
            backgroundColor: AppColors.kWhite,
            child: Form(
              key: cubit.formKey,
              child: Column(
                children: [
                  Expanded(
                    child: GradientHeaderLayout(
                      showAction: true,
                      title: AppStrings.submitComplaintTitle.tr,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                            start: 16,
                            end: 16,
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 30),
                              ComplaintTitleField(
                                controller: cubit.titleController,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return AppStrings.thisFieldIsRequired.tr;
                                  }
                                  if (value.trim().length < 5) {
                                    return AppStrings.complaintTitleMinLength.tr;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              ComplaintDescriptionField(
                                controller: cubit.detailsController,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return AppStrings.thisFieldIsRequired.tr;
                                  }
                                  if (value.trim().length < 10) {
                                    return AppStrings.complaintDetailsMinLength.tr;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              ComplaintImageUpload(
                                selectedImages: cubit.selectedImages,
                                onTap: () =>
                                    cubit.pickImage(ImageSource.gallery),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ComplaintSubmitButton(
                      onPressed: cubit.submitComplaint,
                      isLoading: state is FileComplaintLoading,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
