import 'package:flutter/material.dart';

class NIDButton extends StatelessWidget {
  const NIDButton({super.key, required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => ElevatedButton(onPressed: onPressed, child: Text(label));
}

class NIDTextField extends StatelessWidget {
  const NIDTextField({super.key, required this.controller, required this.label});
  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) => TextField(controller: controller, decoration: InputDecoration(labelText: label));
}

class GlassPanel extends StatelessWidget {
  const GlassPanel({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white24),
        ),
        padding: const EdgeInsets.all(12),
        child: child,
      );
}

class NIDAvatar extends StatelessWidget {
  const NIDAvatar({super.key, this.radius = 24});
  final double radius;

  @override
  Widget build(BuildContext context) => CircleAvatar(
        radius: radius,
        backgroundColor: const Color(0xFF2EC5FF),
        child: const Icon(Icons.person, color: Colors.black),
      );
}

class NIDEarthBackground extends StatelessWidget {
  const NIDEarthBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          colors: [Color(0xFF113366), Colors.black],
          center: Alignment(0, 0.8),
          radius: 1.2,
        ),
      ),
      child: child,
    );
  }
}
