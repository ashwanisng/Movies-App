import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final Size size;
  final double? width;
  final double? height;
  final double radius;
  const ShimmerWidget({super.key, required this.size, this.width, this.height, this.radius = 5.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[900]!,
        highlightColor: Colors.black54,
        child: Container(
          decoration: BoxDecoration(color: Colors.grey[900]!, borderRadius: BorderRadius.all(Radius.circular(radius))),
        ),
      ),
    );
  }
}
