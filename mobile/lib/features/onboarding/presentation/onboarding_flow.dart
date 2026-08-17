import 'package:flutter/material.dart';
import 'package:nid_mobile/core/widgets/nid_components.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final mobile = TextEditingController();
  final otp = TextEditingController();
  final publicId = TextEditingController();
  final privateId = TextEditingController();
  final name = TextEditingController();
  int step = 0;

  @override
  void dispose() {
    mobile.dispose();
    otp.dispose();
    publicId.dispose();
    privateId.dispose();
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NIDEarthBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: GlassPanel(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_titles[step], style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 16),
                  Expanded(child: _body()),
                  Row(
                    children: [
                      if (step > 0) TextButton(onPressed: () => setState(() => step--), child: const Text('Back')),
                      const Spacer(),
                      NIDButton(
                        label: step == 6 ? 'Enter NID' : 'Continue',
                        onPressed: () {
                          if (step < 6) {
                            setState(() => step++);
                          } else {
                            Navigator.pushReplacementNamed(context, '/home');
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _body() {
    switch (step) {
      case 1:
        return NIDTextField(controller: mobile, label: 'Mobile Number');
      case 2:
        return NIDTextField(controller: otp, label: 'OTP Verification');
      case 3:
        return NIDTextField(controller: publicId, label: 'Public NID ID (username.nid)');
      case 4:
        return NIDTextField(controller: privateId, label: 'Private NID Mail (username@email.nid)');
      case 5:
        return NIDTextField(controller: name, label: 'Profile Name');
      case 6:
        return const Center(child: Text('NID Ready'));
      default:
        return const Center(child: Text('Welcome to NID'));
    }
  }
}

const _titles = [
  'Welcome',
  'Mobile Number',
  'OTP Verification',
  'Create Public NID ID',
  'Create Private NID Mail ID',
  'Create Profile',
  'NID Ready',
];
