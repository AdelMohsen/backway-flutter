// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:photo_view/photo_view.dart';

import 'customer_scroll_behaviour.dart';

// ignore: must_be_immutable
class ZoomImageScreen extends StatefulWidget {
  final String urlImage;

  const ZoomImageScreen({super.key, required this.urlImage});

  @override
  _ZoomImageScreenState createState() => _ZoomImageScreenState();
}

class _ZoomImageScreenState extends State<ZoomImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ScrollConfiguration(
            behavior: MyCustomScrollBehavior(),
            child: PhotoView(imageProvider: NetworkImage(widget.urlImage)),
          ),
          PositionedDirectional(
            top: 20,
            start: 20,
            child: SafeArea(
              child: IconButton(
                onPressed: () {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  });
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
