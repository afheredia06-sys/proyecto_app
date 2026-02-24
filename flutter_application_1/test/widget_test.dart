// test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Agrilux app tiene título', (WidgetTester tester) async {
    // Construye la app
    await tester.pumpWidget(const AgriluxApp());

    // Verifica que el título "AGRILUX" aparece
    expect(find.text('AGRILUX'), findsOneWidget);
    expect(find.text('Tu aliado en el campo'), findsOneWidget);
    expect(find.text('Diagnóstico de Plagas'), findsOneWidget);
  });
}
