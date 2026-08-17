import 'package:flutter_test/flutter_test.dart';
import 'package:nid_mobile/main.dart';

void main() {
  testWidgets('NID app boots', (tester) async {
    await tester.pumpWidget(const NIDApp());
    await tester.pumpAndSettle();
    expect(find.text('Welcome'), findsOneWidget);
  });
}
