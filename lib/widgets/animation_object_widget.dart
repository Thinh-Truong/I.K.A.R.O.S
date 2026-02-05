import 'package:flutter/material.dart';
import 'package:o3d/o3d.dart';

class AnimationObjectWidget extends StatelessWidget {
  final String animationName;
  final bool cameraControls;
  final bool autoRotate;
  final bool autoPlay;

  const AnimationObjectWidget({
    super.key,
    required this.animationName,
    this.cameraControls = false,
    required this.autoRotate,
    required this.autoPlay,
  });

  @override
  Widget build(BuildContext context) {
    return O3D(
      src: 'assets/mahiro.glb',
      ar: false,
      autoPlay: autoPlay,
      autoRotate: autoRotate,
      autoRotateDelay: 0,
      animationName: animationName,
      cameraControls: cameraControls,
      cameraTarget: CameraTarget(0, 4.0, 0),
      cameraOrbit: CameraOrbit(0, 55, 0),
    );
  }
}
