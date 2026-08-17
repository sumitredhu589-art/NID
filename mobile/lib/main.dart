import 'package:flutter/material.dart';
import 'package:nid_mobile/features/home/presentation/nid_home_shell.dart';
import 'package:nid_mobile/features/onboarding/presentation/onboarding_flow.dart';

void main() {
  runApp(const NIDApp());
}

class NIDApp extends StatelessWidget {
  const NIDApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NID',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2EC5FF), brightness: Brightness.dark),
      ),
      routes: {
        '/': (_) => const OnboardingFlow(),
        '/home': (_) => const NIDHomeShell(),
      },
    );
  }
}
