import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'shimmer.dart';

class HostedImage extends StatelessWidget {
  const HostedImage(
    this.url, {
    super.key,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.enablePreviewing = false,
    this.onImgTap,
    this.errorIcon,
  });

  const HostedImage.square(
    this.url, {
    super.key,
    double? dimension,
    this.fit = BoxFit.cover,
    this.enablePreviewing = false,
    this.onImgTap,
    this.errorIcon,
  })  : height = dimension,
        width = dimension;

  final void Function()? onImgTap;

  /// if [onImgTap] is null this will be ignored
  final bool enablePreviewing;

  final IconData? errorIcon;
  final BoxFit fit;
  final double? height;
  final String url;
  final double? width;

  static ImageProvider provider(
    String url, {
    int? maxHeight,
    int? maxWidth,
  }) {
    return CachedNetworkImageProvider(
      url,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      hoverColor: Colors.transparent,
      onTap: enablePreviewing
          ? () {
              final route = MaterialPageRoute(
                builder: (context) => PhotoView.any(url),
                fullscreenDialog: true,
              );
              Navigator.of(context).push(route);
            }
          : onImgTap,
      child: CachedNetworkImage(
        imageUrl: url,
        height: height,
        width: width,
        fit: fit,
        progressIndicatorBuilder: (context, url, _) =>
            KShimmer.card(height: height ?? 50, width: width ?? 50),
        errorWidget: (context, url, _) => SizedBox(
          height: height ?? 50,
          width: width ?? 50,
          child: Icon(errorIcon ?? Icons.image_not_supported_rounded),
        ),
      ),
    );
  }
}

class PhotoView extends StatelessWidget {
  const PhotoView(this.image, {super.key});

  PhotoView.any(String asset, {super.key}) : image = _anyImage(asset);

  PhotoView.asset(String asset, {super.key})
      : image = ExtendedAssetImageProvider(asset);

  PhotoView.file(File file, {super.key})
      : image = ExtendedFileImageProvider(file);

  PhotoView.network(String url, {super.key})
      : image = ExtendedNetworkImageProvider(url);

  final ImageProvider image;

  static ImageProvider _anyImage(String path) {
    if (path.startsWith('http')) {
      return ExtendedNetworkImageProvider(path);
    }
    if (path.startsWith('assets')) {
      return ExtendedAssetImageProvider(path);
    }

    final file = File(path);
    if (file.existsSync()) return ExtendedFileImageProvider(file);

    throw Exception('File not found');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ExtendedImageGesturePageView.builder(
        itemCount: 1,
        itemBuilder: (ctx, i) => ExtendedImage(
          image: image,
          fit: BoxFit.contain,
          mode: ExtendedImageMode.gesture,
          onDoubleTap: (d) => context.pop(),
          loadStateChanged: (state) {
            if (state.extendedImageLoadState == LoadState.loading) {
              return KShimmer.card(
                padding: const EdgeInsets.all(20),
                height: state.extendedImageInfo?.image.height.toDouble(),
                width: state.extendedImageInfo?.image.width.toDouble(),
              );
            }
            if (state.extendedImageLoadState == LoadState.failed) {
              return const Icon(Icons.image_not_supported_rounded, size: 30);
            }
            return null;
          },
        ),
      ),
    );
  }
}
