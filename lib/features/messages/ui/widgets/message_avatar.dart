import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/assets/app_svg.dart';

class MessageAvatar extends StatelessWidget {
  final bool showStatus;
  final String? avatarUrl;

  const MessageAvatar({
    Key? key,
    this.showStatus = false,
    this.avatarUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color.fromRGBO(240, 255, 253, 1),
              width: 2,
            ),
          ),

          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: avatarUrl != null && avatarUrl!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: avatarUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Icon(Icons.person, color: Colors.grey),
                    errorWidget: (context, url, error) => Image.asset(
                      AppImages.imageCarriers,
                      fit: BoxFit.cover,
                    ),
                  )
                : Image.asset(
                    AppImages.imageCarriers,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        if (showStatus)
          SvgPicture.asset(
            width: 20,
            height: 20,
            AppSvg.doneChat,
            fit: BoxFit.cover, // Assuming this is the handshake/done icon
          ),
      ],
    );
  }
}
