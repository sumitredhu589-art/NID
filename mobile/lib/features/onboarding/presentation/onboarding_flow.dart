import 'package:flutter/material.dart';
import 'package:nid_mobile/core/widgets/nid_components.dart';
import 'package:nid_mobile/core/state/app_session.dart';
import 'package:nid_mobile/features/onboarding/data/auth_api.dart';
import 'package:provider/provider.dart';

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
  final authApi = AuthApi();
  int step = 0;
  bool loading = false;
  String? error;

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
                  if (error != null) ...[
                    Text(error!, style: const TextStyle(color: Colors.redAccent)),
                    const SizedBox(height: 8),
                  ],
                  Expanded(child: _body()),
                  Row(
                    children: [
                      if (step > 0) TextButton(onPressed: () => setState(() => step--), child: const Text('Back')),
                      const Spacer(),
                      NIDButton(
                        label: step == 6 ? 'Enter NID' : 'Continue',
                        onPressed: loading ? () {} : _onContinue,
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
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }
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

  Future<void> _onContinue() async {
    setState(() => error = null);
    if (step == 1 && mobile.text.trim().isEmpty) {
      setState(() => error = 'Please enter your mobile number.');
      return;
    }
    if (step == 2 && otp.text.trim().isEmpty) {
      setState(() => error = 'Please enter the OTP.');
      return;
    }

    if (step == 1) {
      setState(() => loading = true);
      final sent = await authApi.sendOtp(mobile.text.trim());
      if (!mounted) return;
      setState(() => loading = false);
      if (!sent) {
        setState(() => error = 'Could not reach backend. Use dev OTP 123456 and continue.');
      }
      setState(() => step++);
      return;
    }

    if (step == 2) {
      setState(() => loading = true);
      final tokens = await authApi.verifyOtp(phoneNumber: mobile.text.trim(), otp: otp.text.trim());
      if (!mounted) return;
      setState(() => loading = false);
      if (tokens == null) {
        setState(() => error = 'OTP verification failed. In dev mode, use 123456.');
        return;
      }
      context.read<AppSession>().setTokens(
            newAccessToken: tokens.accessToken,
            newRefreshToken: tokens.refreshToken,
            newPhoneNumber: mobile.text.trim(),
          );
      setState(() => step++);
      return;
    }

    if (step < 6) {
      setState(() => step++);
      return;
    }

    Navigator.pushReplacementNamed(context, '/home');
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
