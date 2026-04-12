import 'package:flutter/material.dart';

import 'customer_scroll_behaviour.dart';

class CustomePopupDialogWidget extends StatefulWidget {
  const CustomePopupDialogWidget({
    super.key,
    this.child,
    this.width,
    this.height,
    this.borderRadius,
    this.needPopupInCenter = true,
    this.decoration,
    this.color,
  });
  final Widget? child;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final bool needPopupInCenter;
  final Decoration? decoration;
  final Color? color;

  @override
  State<StatefulWidget> createState() => CustomePopupDialogWidgetState();
}

class CustomePopupDialogWidgetState extends State<CustomePopupDialogWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.needPopupInCenter
        ? Center(
            child: Material(
            color: Colors.transparent,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: Container(
                decoration: widget.decoration ??
                    ShapeDecoration(
                        color: widget.color ?? Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: widget.borderRadius ??
                                BorderRadius.circular(0.0))),
                child: SizedBox(
                  width: widget.width ?? MediaQuery.of(context).size.width - 50,
                  height:
                      widget.height ?? MediaQuery.of(context).size.height * .5,
                  child: ScrollConfiguration(
                    behavior: MyCustomScrollBehavior(),
                    child: widget.child ??
                        const Padding(
                          padding: EdgeInsets.all(50.0),
                          child: Text('Pull Your Child'),
                        ),
                  ),
                ),
              ),
            ),
          ))
        : Column(
            children: [
              Material(
                color: Colors.transparent,
                child: ScaleTransition(
                  scale: scaleAnimation,
                  child: Container(
                    decoration: widget.decoration ??
                        ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: widget.borderRadius ??
                                    BorderRadius.circular(0.0))),
                    child: SizedBox(
                      width: widget.width ??
                          MediaQuery.of(context).size.width - 50,
                      height: widget.height ??
                          MediaQuery.of(context).size.height * .5,
                      child: ScrollConfiguration(
                        behavior: MyCustomScrollBehavior(),
                        child: widget.child ??
                            const Padding(
                              padding: EdgeInsets.all(50.0),
                              child: Text('Pull Your Child'),
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
