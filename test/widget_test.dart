import 'package:flutter_test/flutter_test.dart';

import 'package:gde/app/app.dart';

void main() {
  testWidgets('App renders without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    // Проверяем, что приложение запустилось
    expect(find.byType(App), findsOneWidget);
  });
}
