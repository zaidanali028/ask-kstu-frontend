import 'package:flutter/cupertino.dart';
import 'package:glassmorphism/glassmorphism.dart';

class CustomGlassmorphicContainer extends StatelessWidget {
  const CustomGlassmorphicContainer(
      {super.key, this.width, this.height, this.borderRadius = 20, required this.child});
  final double? width;
  final double? height;
  final double? borderRadius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: width!,
      height: height!,
      borderRadius: borderRadius!,
      border: 2,
      blur: 20,
      linearGradient: LinearGradient(colors: [
        const Color(0xFFffffff).withOpacity(0.1),
        const Color(0xFFFFFFFF).withOpacity(0.05)
      ]),
      borderGradient: LinearGradient(colors: [
        const Color(0xFFffffff).withOpacity(0.1),
        const Color(0xFFFFFFFF).withOpacity(0.05)
      ]),
      child: child,
    );
  }
}
