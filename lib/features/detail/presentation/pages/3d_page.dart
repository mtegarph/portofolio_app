import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class Page3D extends StatelessWidget {
  const Page3D({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Flutter3DController();
    return Scaffold(
      body: Flutter3DViewer(
        controller: controller,
        src: 'assets/avaters/glasses.glb',
      ),
    );
  }
}
