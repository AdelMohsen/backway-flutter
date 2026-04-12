// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// // ignore: depend_on_referenced_packages
// import 'package:path/path.dart';
// import '../common/custom_images.dart';
// import '../core/utils/widgets/buttons/custom_btn.dart';
// import '../core/utils/widgets/image_pickers/image_picker_helper.dart';
// import '../core/utils/extensions/media_query_helper.dart';
// import '../core/theme/colors/styles.dart';
// import '../utility/extensions.dart';

// class UploadImage extends StatefulWidget {
//   final ValueChanged? updatedImage;

//   final ValueChanged? updateFile;

//   final String? label;

//   final File? selectedImage;

//   const UploadImage({super.key, required this.updatedImage, this.label, this.selectedImage, this.updateFile});

//   @override
//   State<UploadImage> createState() => _UploadImageState();
// }

// class _UploadImageState extends State<UploadImage> {
//   File? image;

//   @override
//   void initState() {
//     if (widget.selectedImage != null) image = widget.selectedImage;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           child: Container(
//             height: image != null ? 192 : 140,
//             width: MediaQueryHelper.width,
//             decoration: BoxDecoration(
//               color: AppColors.kPrimary.withOpacity(.1),
//               borderRadius: BorderRadius.circular(15.0),
//               image: DecorationImage(
//                   image: Image.asset('assets/images/${image != null ? "uploaded_image" : "upload_image"}.png').image,
//                   fit: BoxFit.fill),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     ImagePickerHelper.showOption(onGet: (file) async {
//                       setState(() => image = file);
//                       var multipartImage = await MultipartFile.fromFile(image!.path);
//                       widget.updatedImage!(multipartImage);
//                       if (widget.updateFile != null) widget.updateFile!(image);
//                     });
//                   },
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(8.0),
//                     child: Container(
//                       height: 44,
//                       width: 44,
//                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
//                       child: image != null
//                           ? Image.file(
//                               image!,
//                               fit: BoxFit.fill,
//                             )
//                           : customImageIconSVG(imageName: 'blue_gallery'),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 6,
//                 ),
//                 Text(
//                   image != null
//                       ? "${"Uploaded".tr}!"
//                       : widget.label != null
//                           ? widget.label!
//                           : 'Upload Image'.tr,
//                   style: const TextStyle(color: AppColors.HEADER, fontSize: 13, fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(
//                   height: 6,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                   child: RichText(
//                     text: TextSpan(
//                         text: image != null ? basename(image!.path) : 'must be less than'.tr,
//                         style: const TextStyle(color: AppColors.SUB_HEADER, fontSize: 11, fontWeight: FontWeight.w500),
//                         children: [
//                           TextSpan(
//                               text: image != null ? '' : ' 6MB',
//                               style:
//                                   const TextStyle(color: AppColors.HEADER, fontSize: 11, fontWeight: FontWeight.w600))
//                         ]),
//                     textAlign: TextAlign.center,
//                     maxLines: 2,
//                   ),
//                 ),
//                 Visibility(
//                   visible: image != null,
//                   child: Column(
//                     children: [
//                       const SizedBox(
//                         height: 16.0,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           CustomBtn(
//                             text: 'Change'.tr,
//                             btnHeight: 31,
//                             btnWidth: 84,
//                             txtFontSize: 12,
//                             onTap: () {
//                               ImagePickerHelper.showOption(onGet: (file) async {
//                                 setState(() => image = file);
//                                 var multipartImage = await MultipartFile.fromFile(image!.path);
//                                 widget.updatedImage!(multipartImage);
//                                 if (widget.updateFile != null) {
//                                   widget.updateFile!(image);
//                                 }
//                               });
//                             },
//                             color: AppColors.kPrimary,
//                           ),
//                           const SizedBox(
//                             width: 8.0,
//                           ),
//                           CustomBtn(
//                             btnWidth: 84,
//                             text: 'Remove'.tr,
//                             btnHeight: 31,
//                             txtFontSize: 12,
//                             onTap: () {
//                               setState(() => image = null);
//                               widget.updatedImage!(null);
//                               if (widget.updateFile != null) {
//                                 widget.updateFile!(null);
//                               }
//                             },
//                             color: AppColors.IN_ACTIVE.withOpacity(.1),
//                             txtColor: AppColors.IN_ACTIVE,
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
