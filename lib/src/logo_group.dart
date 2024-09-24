// coverage:ignore-file

import 'package:flutter/material.dart';

/// A widget that arranges a group of logos in a horizontal stack,
/// allowing for customizable overlap and size.
///
/// This widget is particularly useful for displaying multiple logos or
/// icons together, providing a visually appealing layout where the logos
/// can overlap slightly. The overlap and size of the logos can be easily
/// configured, making it flexible for different design requirements.
class LogoGroup extends StatelessWidget {
  /// Creates a [LogoGroup] widget.
  ///
  /// The [children] parameter is required and should contain the list of logos
  /// or widgets to be displayed.
  ///
  /// The [wrap] function allows for customization of how each logo is wrapped.
  /// If not provided, each logo will be displayed as is.
  ///
  /// The [overlap] parameter defines the amount of horizontal overlap between
  /// the logos. It defaults to 6.0.
  ///
  /// The [size] parameter sets the height and width of the logos. It defaults
  /// to 24.0.
  const LogoGroup({
    required this.children,
    this.wrap,
    this.overlap = 6.0,
    this.size = 24.0,
    super.key,
  });

  /// Creates a [LogoGroup] from a list of image URLs, where each URL
  /// is represented as a [CircleImage] widget.
  ///
  /// The [imageUrls] parameter is required and should contain the URLs
  /// of the images to be displayed.
  ///
  /// The [size] parameter sets the height and width of the logos. It defaults
  /// to 24.0, and the [overlap] parameter defines the amount of overlap
  /// between logos.
  factory LogoGroup.withImageUrls(List<String> imageUrls, {double size = 24.0, double overlap = 6.0}) {
    return LogoGroup(
      size: size,
      overlap: overlap,
      children: imageUrls.map((url) => CircleImage(imageUrl: url, size: size)).toList(),
    );
  }

  /// A list of widgets to be displayed as logos.
  final List<Widget> children;

  /// The amount of overlap between each logo in the group.
  /// Defaults to `6.0`.
  final double overlap;

  /// The size (width and height) of each logo.
  /// Defaults to `24.0`.
  final double size;

  /// An optional function to wrap each logo widget.
  /// If provided, this function is called for each logo in [children].
  final Widget Function(Widget)? wrap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: children.length * (size - overlap) + overlap,
      height: size,
      child: Stack(
        children: [
          for (int i = 0; i < children.length; i++)
            Positioned(
              left: i * (size - overlap),
              child: wrap?.call(children[i]) ?? children[i],
            ),
        ],
      ),
    );
  }
}

/// A widget that displays an image in a circular shape.
///
/// The image is fetched from a network URL and is clipped to fit
/// within a circular shape, providing a uniform appearance for logo
/// representations.
class CircleImage extends StatelessWidget {
  /// Creates a [CircleImage] widget.
  ///
  /// The [imageUrl] parameter is required and should contain the URL
  /// of the image to be displayed.
  ///
  /// The [size] parameter sets the height and width of the image.
  const CircleImage({
    required this.imageUrl,
    required this.size,
    super.key,
  });

  /// The URL of the image to be displayed.
  final String imageUrl;

  /// The size (width and height) of the circular image.
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
