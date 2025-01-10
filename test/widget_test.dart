import 'package:ai_chatbot/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'firebase_mock_helper.dart'; // Import the mock helper

void main() {
  setUpAll(() async {
    // Mock Firebase initialization
    await mockFirebaseInitialization();
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build and render your app or widget
    await tester.pumpWidget(MyApp());

    // Find the widget with initial text
    expect(find.text('0'), findsOneWidget);

    // Simulate button press
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify the counter increments
    expect(find.text('1'), findsOneWidget);
  });
}
