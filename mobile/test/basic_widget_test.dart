import 'package:flutter_test/flutter_test.dart';
import 'package:nid_mobile/main.dart';
import 'package:nid_mobile/core/state/app_session.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('NID app boots', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppSession(),
        child: const NIDApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Welcome to NID'), findsOneWidget);
  });
}
