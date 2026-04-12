import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultNetworkImage extends StatelessWidget {
  const DefaultNetworkImage(
    this.image, {
    super.key,
    this.height,
    this.width,
    this.fit,
    this.placeholder,
    this.fromSliverList,
    this.loadingSize,
    this.needCache = true,
    this.filterQuality,
    this.needResizeImage = false,
    this.loadingImageSize,
    this.dynamicWidth = false,
    this.errorWidget,
  });

  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Widget Function(BuildContext, String)? placeholder;
  final bool? fromSliverList;
  final double? loadingSize;
  final bool? needCache;
  final FilterQuality? filterQuality;
  final bool needResizeImage;
  final double? loadingImageSize;
  final bool dynamicWidth;
  final Widget Function(BuildContext, String, Object)? errorWidget;

  bool get _isSvg => image.toLowerCase().trim().endsWith('.svg');

  Widget _defaultPlaceholder(BuildContext context, String url) {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _defaultError() {
    return const Icon(Icons.error);
  }

  @override
  Widget build(BuildContext context) {
    final finalHeight =
        height ?? (dynamicWidth ? null : MediaQuery.of(context).size.height);
    final finalWidth =
        width ?? (dynamicWidth ? null : MediaQuery.of(context).size.width);

    /// ---------------- SVG IMAGE ----------------
    if (_isSvg) {
      return SvgPicture.network(
        image,
        height: finalHeight,
        width: finalWidth,
        fit: fit ?? BoxFit.cover,
        placeholderBuilder: (context) =>
            placeholder?.call(context, image) ??
            _defaultPlaceholder(context, image),
      );
    }

    /// ---------------- NORMAL IMAGE ----------------
    if (needCache == true) {
      return CachedNetworkImage(
        imageUrl: image,
        placeholder:
            placeholder ?? (context, url) => _defaultPlaceholder(context, url),
        memCacheHeight: needResizeImage ? height?.toInt() : null,
        memCacheWidth: needResizeImage ? width?.toInt() : null,
        filterQuality: filterQuality ?? FilterQuality.low,
        errorWidget: errorWidget ?? (context, url, error) => _defaultError(),
        height: finalHeight,
        width: finalWidth,
        fit: fit ?? BoxFit.cover,
        fadeInCurve: Curves.ease,
      );
    }

    /// ---------------- NO CACHE ----------------
    return Image.network(
      image,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return _defaultPlaceholder(context, image);
      },
      errorBuilder: (context, error, stackTrace) => _defaultError(),
      height: finalHeight,
      width: finalWidth,
      fit: fit ?? BoxFit.cover,
      filterQuality: filterQuality ?? FilterQuality.low,
    );
  }
}
