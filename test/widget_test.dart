import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gde/app/app.dart';
import 'package:gde/features/events/domain/entities/event.dart';
import 'package:gde/features/events/presentation/providers/events_providers.dart';
import 'package:gde/features/categories/domain/entities/category.dart';
import 'package:gde/features/categories/presentation/providers/categories_providers.dart';

void main() {
  testWidgets('App renders without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          eventsProvider(null).overrideWith((ref) async => <Event>[]),
          categoriesProvider.overrideWith((ref) async => <Category>[]),
        ],
        child: const App(),
      ),
    );

    // Первичный pump — строим первый фрейм
    await tester.pump();

    // Проверяем, что App смонтирован
    expect(find.byType(MaterialApp), findsOneWidget);

    // Прогоняем таймер SplashScreen (2 секунды)
    await tester.pump(const Duration(seconds: 3));

    // Завершаем все анимации
    await tester.pumpAndSettle();
  });
}
