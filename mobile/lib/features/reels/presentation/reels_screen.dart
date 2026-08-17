import 'package:flutter/material.dart';

class ReelsScreen extends StatelessWidget {
  const ReelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (_, i) => Stack(
          fit: StackFit.expand,
          children: [
            Container(color: Colors.black87, child: Center(child: Text('Reel ${i + 1}'))),
            Positioned(
              right: 12,
              bottom: 90,
              child: Column(children: const [Icon(Icons.favorite_border), SizedBox(height: 12), Icon(Icons.comment), SizedBox(height: 12), Icon(Icons.share), SizedBox(height: 12), Icon(Icons.bookmark_border)]),
            ),
            Positioned(left: 12, bottom: 32, child: Text('@creator${i + 1} • #nid #reel\nOriginal sound', style: const TextStyle(color: Colors.white))),
          ],
        ),
      ),
    );
  }
}
