import 'package:flutter/material.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NID Camera')),
      body: Column(
        children: [
          Expanded(child: Container(color: Colors.black54, child: const Center(child: Icon(Icons.camera_alt, size: 72)))) ,
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: const [Icon(Icons.flash_on), Icon(Icons.cameraswitch), Icon(Icons.photo_library)]),
          const SizedBox(height: 8),
          FloatingActionButton(onPressed: () {}, child: const Icon(Icons.radio_button_checked)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
