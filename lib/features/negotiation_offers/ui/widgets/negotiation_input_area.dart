import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_form_field.dart';
import 'package:image_picker/image_picker.dart';

import '../../logic/cubit/negotiation_offers_cubit.dart';
import '../../logic/state/negotiation_offers_state.dart';

class NegotiationInputArea extends StatefulWidget {
  final int orderId;

  const NegotiationInputArea({Key? key, required this.orderId})
    : super(key: key);

  @override
  State<NegotiationInputArea> createState() => _NegotiationInputAreaState();
}

class _NegotiationInputAreaState extends State<NegotiationInputArea> {
  final TextEditingController _controller = TextEditingController();
  File? _selectedImage;
  bool _isSending = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  void _sendMessage() {
    final message = _controller.text.trim();

    // Must have either text or image
    if (message.isEmpty && _selectedImage == null) return;

    final cubit = context.read<NegotiationOffersCubit>();
    cubit.sendMessage(
      orderId: widget.orderId,
      message: message,
      attachment: _selectedImage,
    );

    _controller.clear();
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NegotiationOffersCubit, NegotiationOffersState>(
      listener: (context, state) {
        if (state is NegotiationOffersSendingMessage) {
          setState(() => _isSending = true);
        } else {
          if (_isSending) setState(() => _isSending = false);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ─── Image Preview ───
          if (_selectedImage != null) _buildImagePreview(),

          // ─── Input Row ───
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  offset: const Offset(0, -4),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Row(
              children: [
                // Text Field
                Expanded(
                  child: DefaultFormField(
                    controller: _controller,
                    textAlign: TextAlign.start,
                    fillColor: Colors.white,
                    borderRadious: 30,
                    borderColor: const Color.fromRGBO(214, 245, 241, 1),
                    needValidation: false,
                    hintText: AppStrings.yourNotes.tr,
                    hintStyle: AppTextStyles.ibmPlexSansSize14w400Grey.copyWith(
                      color: const Color.fromRGBO(138, 138, 138, 1),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: _pickImage,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(AppSvg.attachFile),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Send Button
                InkWell(
                  onTap: _isSending ? null : _sendMessage,
                  borderRadius: BorderRadius.circular(22),
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: _isSending
                          ? AppColors.primaryGreenHub.withOpacity(0.5)
                          : AppColors.primaryGreenHub,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(11),
                    child: _isSending
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Transform.rotate(
                            angle: mainAppBloc.isArabic ? 0 : -3.1,
                            child: SvgPicture.asset(
                              AppSvg.sendChat,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePreview() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 12),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              _selectedImage!,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 68,
            child: GestureDetector(
              onTap: _removeImage,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: Colors.red.shade400,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
