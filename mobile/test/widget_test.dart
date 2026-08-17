import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nid_mobile/core/state/app_session.dart';
import 'package:nid_mobile/features/home/presentation/nid_home_shell.dart';
import 'package:nid_mobile/features/onboarding/data/auth_api.dart';
import 'package:nid_mobile/features/onboarding/presentation/onboarding_flow.dart';
import 'package:nid_mobile/main.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('NID app boots and shows onboarding', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppSession(),
        child: const NIDApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Welcome to NID'), findsOneWidget);
  });

  testWidgets('debug OTP fallback lets onboarding continue offline', (tester) async {
    final session = AppSession();

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: session,
        child: MaterialApp(
          routes: {
            '/': (_) => OnboardingFlow(authApi: _OfflineAuthApi()),
            '/home': (_) => const NIDHomeShell(),
          },
        ),
      ),
    );

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), '5551234567');
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Use dev OTP 123456 and continue.'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '123456');
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(session.isAuthenticated, isTrue);
    expect(session.accessToken, 'dev-access-token');

    for (var i = 0; i < 4; i++) {
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
    }

    expect(find.byIcon(Icons.notifications_none), findsOneWidget);
  });
}

class _OfflineAuthApi extends AuthApi {
  @override
  Future<bool> sendOtp(String phoneNumber) async => false;

  @override
  Future<AuthTokens?> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async =>
      null;
}
