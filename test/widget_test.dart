// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_movies/main.dart';

void main() {
  testWidgets('Input test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Check initial texfield content
    expect(find.text("inception"), findsOneWidget);

    // Enter "lord" in textfield
    await tester.showKeyboard(find.byType(TextField));
    await tester.enterText(find.byType(TextField), "lord");
    await tester.pump();

    // Check "lord" is in textfield
    expect(find.text("lord"), findsOneWidget);
  });
}
