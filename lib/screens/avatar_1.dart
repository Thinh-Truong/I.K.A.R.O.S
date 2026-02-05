import 'package:flutter/material.dart';
import 'package:ikaros/data_model/animation.dart';
import 'package:ikaros/widgets/animation_object_widget.dart';

class Avatar1 extends StatefulWidget {
  const Avatar1({super.key});

  @override
  State<Avatar1> createState() => _Avatar1State();
}

class _Avatar1State extends State<Avatar1> {
  late String animation;
  late bool cameraControls;
  late bool autoRotate;
  late bool autoPlay;

  Key widgetKey = UniqueKey();

  void recreateWidget() {
    setState(() {
      widgetKey = UniqueKey();
    });
  }

  @override
  void initState() {
    animation = "Idle";
    cameraControls = true;
    autoRotate = false;
    autoPlay = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: AnimationObjectWidget(
                  key: widgetKey,
                  animationName: animation,
                  cameraControls: cameraControls,
                  autoRotate: autoRotate,
                  autoPlay: autoPlay,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
