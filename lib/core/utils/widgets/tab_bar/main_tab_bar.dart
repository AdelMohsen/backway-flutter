import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/text_styles/text_styles.dart';

class CustomSegmentTextOnly extends StatefulWidget {
  final List<String> items;
  final void Function(int index)? onTap;
  final int initialIndex;

  /// Optional customization
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;
  final double dividerSpacing; // space around "|"
  final double itemSpacing; // horizontal padding around each text
  final bool scrollable; // enable horizontal scroll if true
  final MainAxisAlignment alignment; // alignment when not scrollable
  final TabController? tabController; // optional tabController to sync
  final bool shouldAutoScroll; // whether to auto-scroll to selected item

  const CustomSegmentTextOnly({
    super.key,
    required this.items,
    this.onTap,
    this.initialIndex = 0,
    this.selectedTextStyle,
    this.unselectedTextStyle,
    this.dividerSpacing = 8.0,
    this.itemSpacing = 12.0,
    this.scrollable = true,
    this.alignment = MainAxisAlignment.center,
    this.tabController,
    this.shouldAutoScroll = false,
  });

  @override
  State<CustomSegmentTextOnly> createState() => _CustomSegmentTextOnlyState();
}

class _CustomSegmentTextOnlyState extends State<CustomSegmentTextOnly> {
  late int selectedIndex;
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _itemKeys = [];

  @override
  void initState() {
    super.initState();
    // If tabController is provided, use its current index, otherwise use initialIndex
    selectedIndex = widget.tabController?.index ?? widget.initialIndex;

    // Create keys for each item
    _itemKeys.addAll(List.generate(widget.items.length, (_) => GlobalKey()));

    // Listen to tabController changes
    widget.tabController?.addListener(_tabListener);

    // Only auto-scroll if shouldAutoScroll is true (when navigating with categoryId)
    if (widget.shouldAutoScroll) {
      // Use longer delay to ensure everything is fully rendered
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            _scrollToSelectedItem();
            // Retry after another delay to ensure it worked
            Future.delayed(const Duration(milliseconds: 300), () {
              if (mounted) _scrollToSelectedItem();
            });
          }
        });
      });
    }
  }

  Widget _wrapExpandedIfNeeded({required Widget child}) {
    if (!widget.scrollable && widget.items.length == 2) {
      return Expanded(child: child);
    }
    return child;
  }

  void _tabListener() {
    if (!mounted) return;
    setState(() {
      selectedIndex = widget.tabController!.index;
    });
    // Always scroll when user manually changes tab (via listener)
    _scrollToSelectedItem();
  }

  void _scrollToSelectedItem() {
    if (!widget.scrollable || !mounted) return;
    if (selectedIndex >= _itemKeys.length) {
      print(
        '⚠️ selectedIndex $selectedIndex >= _itemKeys.length ${_itemKeys.length}',
      );
      return;
    }
    if (!_scrollController.hasClients) {
      print('⚠️ ScrollController has no clients, retrying...');
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) _scrollToSelectedItem();
      });
      return;
    }

    try {
      final keyContext = _itemKeys[selectedIndex].currentContext;
      if (keyContext == null) {
        print('⚠️ Key context null for index $selectedIndex, retrying...');
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) _scrollToSelectedItem();
        });
        return;
      }

      final box = keyContext.findRenderObject() as RenderBox?;
      if (box == null) {
        print('⚠️ RenderBox null for index $selectedIndex, retrying...');
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) _scrollToSelectedItem();
        });
        return;
      }

      // Get the position of the item relative to the viewport
      final scrollPosition = _scrollController.position;
      final viewportDimension = scrollPosition.viewportDimension;
      final itemOffset = box.localToGlobal(Offset.zero).dx;
      final itemWidth = box.size.width;

      // Calculate target offset to center the item
      final currentScrollOffset = _scrollController.offset;
      final targetOffset =
          currentScrollOffset +
          itemOffset -
          (viewportDimension / 2) +
          (itemWidth / 2);

      // Clamp the target offset within valid scroll range
      final clampedOffset = targetOffset.clamp(
        scrollPosition.minScrollExtent,
        scrollPosition.maxScrollExtent,
      );

      print(
        '📜 SCROLLING: selectedIndex=$selectedIndex, currentOffset=$currentScrollOffset, targetOffset=$targetOffset, clampedOffset=$clampedOffset, itemOffset=$itemOffset, maxScroll=${scrollPosition.maxScrollExtent}',
      );

      _scrollController
          .animateTo(
            clampedOffset,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
          )
          .then((_) {
            print('✅ Scroll animation completed to $clampedOffset');
          });
    } catch (e) {
      print('❌ Error in _scrollToSelectedItem: $e');
    }
  }

  @override
  void dispose() {
    widget.tabController?.removeListener(_tabListener);
    _scrollController.dispose();
    super.dispose();
  }

  double _getTextWidth(String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size.width;
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: widget.alignment,
          children: List.generate(widget.items.length * 2 - 1, (index) {
            if (index.isOdd) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.dividerSpacing,
                ),
                child: const Text(
                  '|',
                  style: TextStyle(color: Color.fromRGBO(225, 225, 225, 1)),
                ),
              );
            } else {
              final itemIndex = index ~/ 2;
              final isSelected = itemIndex == selectedIndex;

              return GestureDetector(
                key: _itemKeys[itemIndex],
                onTap: () {
                  setState(() {
                    selectedIndex = itemIndex;
                  });
                  if (widget.onTap != null) widget.onTap!(itemIndex);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.itemSpacing,
                    vertical: 4,
                  ),
                  child: Column(
                    children: [
                      Text(
                        widget.items[itemIndex],
                        style: isSelected
                            ? widget.selectedTextStyle ??
                                  AppTextStyles.cairoW700Size20.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: const Color.fromRGBO(
                                      244,
                                      158,
                                      93,
                                      1,
                                    ),
                                  )
                            : widget.unselectedTextStyle ??
                                  GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: const Color.fromRGBO(
                                      106,
                                      106,
                                      106,
                                      1,
                                    ),
                                  ),
                      ),
                      const SizedBox(height: 4),
                      Stack(
                        children: [
                          Container(
                            height: 2,
                            width: isSelected
                                ? _getTextWidth(
                                    widget.items[itemIndex],
                                    widget.selectedTextStyle ??
                                        AppTextStyles.cairoW700Size20
                                            .copyWith(),
                                  )
                                : 0,
                            color: isSelected
                                ? const Color.fromRGBO(244, 158, 93, 1)
                                : Colors.transparent,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
        ),
      ],
    );

    if (widget.scrollable) {
      return SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: content,
      );
    } else {
      return Expanded(child: content);
    }
  }
}
