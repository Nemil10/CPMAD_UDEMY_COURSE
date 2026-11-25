import 'package:flutter_test/flutter_test.dart';

import 'package:ecom_app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const EcomApp());
    expect(find.text('Ecom App'), findsOneWidget);
    await tester.pumpAndSettle();
  });
}
