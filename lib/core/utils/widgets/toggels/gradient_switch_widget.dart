import 'package:flutter/material.dart';

class CustomGradientSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? activeColor;
  final Color inactiveColor;
  final String activeText;
  final String inactiveText;
  final Color activeTextColor;
  final Color inactiveTextColor;

  const CustomGradientSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.inactiveColor = Colors.grey,
    this.activeText = '',
    this.inactiveText = '',
    this.activeTextColor = Colors.white70,
    this.inactiveTextColor = Colors.white70,
  });

  @override
  _CustomGradientSwitchState createState() => _CustomGradientSwitchState();
}

class _CustomGradientSwitchState extends State<CustomGradientSwitch>
    with SingleTickerProviderStateMixin {
  late Animation _circleAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.linear));
  }

  @override
  void dispose() {
    if (mounted) {
      _animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController.isCompleted) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
            widget.value == false
                ? widget.onChanged(true)
                : widget.onChanged(false);
          },
          child: Container(
            width: 70.0,
            height: 30.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: _circleAnimation.value == Alignment.centerLeft
                  ? widget.inactiveColor
                  : widget.activeColor,
              gradient: LinearGradient(
                begin: AlignmentDirectional.topEnd,
                end: AlignmentDirectional.bottomStart,
                colors: widget.value
                    ? [
                        const Color(0xff4C2588),
                        const Color(0xff4C2588).withOpacity(0.8),
                        const Color(0xff4C2588).withOpacity(0.7),
                        const Color(0xff4C2588).withOpacity(0.6),
                      ]
                    : [
                        const Color.fromRGBO(191, 191, 191, 1),
                        const Color.fromRGBO(191, 191, 191, .9),
                        const Color.fromRGBO(191, 191, 191, .8),
                        const Color.fromRGBO(191, 191, 191, .7),
                        const Color.fromRGBO(191, 191, 191, .6),
                      ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 4.0, bottom: 4.0, right: 4.0, left: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _circleAnimation.value == Alignment.centerRight
                      ? Padding(
                          padding: const EdgeInsets.only(left: 34.0, right: 0),
                          child: Text(
                            widget.activeText,
                            style: TextStyle(
                                color: widget.activeTextColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 16.0),
                          ),
                        )
                      : Container(),
                  Align(
                    alignment: _circleAnimation.value,
                    child: Container(
                      width: 25.0,
                      height: 25.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.value
                            ? const Color(0xff4C2588)
                            : Colors.white,
                        gradient: const LinearGradient(
                            begin: AlignmentDirectional.topEnd,
                            end: AlignmentDirectional.bottomStart,
                            colors: [
                              Color.fromRGBO(226, 226, 226, 1),
                              Color.fromRGBO(255, 255, 255, 0.7),
                              Color.fromRGBO(255, 255, 255, 0.3),
                            ]
                            // widget.value
                            //     ? [
                            //         const Color(0xff4C2588),
                            //         const Color(0xff4C2588).withOpacity(0.4),
                            //         const Color(0xff4C2588).withOpacity(0.5),
                            //         const Color(0xff4C2588).withOpacity(0.6),
                            //         const Color(0xff4C2588).withOpacity(0.7),
                            //         const Color(0xff4C2588).withOpacity(0.8),
                            //       ]
                            //     : [
                            //         const Color.fromRGBO(226, 226, 226, 1),
                            //         const Color.fromRGBO(255, 255, 255, 0.7),
                            //         const Color.fromRGBO(255, 255, 255, 0.3),
                            //         const Color.fromRGBO(255, 255, 255, 0),
                            //       ],
                            ),
                      ),
                    ),
                  ),
                  _circleAnimation.value == Alignment.centerLeft
                      ? Padding(
                          padding: const EdgeInsets.only(left: 0, right: 34.0),
                          child: Text(
                            widget.inactiveText,
                            style: TextStyle(
                                color: widget.inactiveTextColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 16.0),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
