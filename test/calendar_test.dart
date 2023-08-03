import 'package:fitness_forge/ui/screen/calendar_screen2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Add Event Button Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: CalendarScreen2()));

    // Tap the "Add Event" button.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify that the AlertDialog is shown.
    expect(find.byType(AlertDialog), findsOneWidget);

    // Enter text in the TextField.
    await tester.enterText(find.byType(TextField), 'Test Event');
    await tester.pump();

    // Tap the "Save" button.
    await tester.tap(find.text('Save'));
    await tester.pump();

    // Verify that the AlertDialog is dismissed.
    expect(find.byType(AlertDialog), findsNothing);

    // Verify that the event is added to the list.
    expect(find.text('Test Event'), findsOneWidget);
  });
}
