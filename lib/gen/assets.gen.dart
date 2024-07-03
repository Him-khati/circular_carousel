/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/abstract_wallpaper_image.jpg
  AssetGenImage get abstractWallpaperImage =>
      const AssetGenImage('assets/images/abstract_wallpaper_image.jpg');

  /// File path: assets/images/brian.png
  AssetGenImage get brian => const AssetGenImage('assets/images/brian.png');

  /// File path: assets/images/hilaichi.jpg
  AssetGenImage get hilaichi =>
      const AssetGenImage('assets/images/hilaichi.jpg');

  /// File path: assets/images/jin_kazama.jpg
  AssetGenImage get jinKazama =>
      const AssetGenImage('assets/images/jin_kazama.jpg');

  /// File path: assets/images/nina.png
  AssetGenImage get nina => const AssetGenImage('assets/images/nina.png');

  /// File path: assets/images/paul.png
  AssetGenImage get paul => const AssetGenImage('assets/images/paul.png');

  /// File path: assets/images/xiaoyo.png
  AssetGenImage get xiaoyo => const AssetGenImage('assets/images/xiaoyo.png');

  /// File path: assets/images/yoshi.png
  AssetGenImage get yoshi => const AssetGenImage('assets/images/yoshi.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        abstractWallpaperImage,
        brian,
        hilaichi,
        jinKazama,
        nina,
        paul,
        xiaoyo,
        yoshi
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
