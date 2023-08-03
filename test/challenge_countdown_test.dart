import 'package:fitness_forge/app.dart';
import 'package:fitness_forge/ui/screen/challenges_congratulations.dart';
import 'package:fitness_forge/ui/screen/challenges_yoga.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('Test countdown functionality', (WidgetTester tester) async {
    await tester.pumpWidget(Yoga()); // Replace with your main app widget

    // Verify that the initial countdown is displayed as 00:00:00
    expect(find.text('Countdown: 00:00:00'), findsOneWidget);

    // Enter values for the countdown (e.g., 01:30:45)
    await enterTime(tester, '01', '30', '45');

    // Verify that the entered countdown values are displayed correctly
    expect(find.text('Countdown: 01:30:45'), findsOneWidget);

    // Tap the "Start Countdown" button
    await tapStartCountdownButton(tester);

    // Wait for the countdown to complete (e.g., 1 second)
    await tester.pump(Duration(seconds: 1));

    // Verify that the countdown has updated correctly
    expect(find.text('Countdown: 01:30:44'), findsOneWidget);

    // Tap the back button
    await tester.pageBack();

    // Wait for the confirmation dialog to appear
    await tester.pump();

    // Verify that the confirmation dialog is displayed
    expect(find.text('Countdown Active'), findsOneWidget);
    expect(find.text('Are you sure you want to leave this screen? The countdown is active.'), findsOneWidget);

    // Tap the "No" button in the confirmation dialog
    await tapConfirmationDialogButton(tester, 'No');

    // Wait for the dialog to be dismissed
    await tester.pump();

    // Verify that the countdown is still running
    expect(find.text('Countdown: 01:30:44'), findsOneWidget);

    // Tap the back button again
    await tester.pageBack();

    // Wait for the confirmation dialog to appear
    await tester.pump();

    // Verify that the confirmation dialog is displayed again
    expect(find.text('Countdown Active'), findsOneWidget);

    // Tap the "Yes" button in the confirmation dialog
    await tapConfirmationDialogButton(tester, 'Yes');

    // Wait for the dialog to be dismissed
    await tester.pump();

    // Verify that the countdown is stopped and the screen navigates back
    expect(find.text('Countdown: 00:00:00'), findsOneWidget);
    expect(find.byType(ChallengesCongratulationsScreen), findsNothing);
  });
}

// Helper method to enter the time in the TextFormField
Future<void> enterTime(
    WidgetTester tester,
    String hours,
    String minutes,
    String seconds,
    ) async {
  final hoursField = find.widgetWithText(TextFormField, 'Hours');
  final minutesField = find.widgetWithText(TextFormField, 'Minutes');
  final secondsField = find.widgetWithText(TextFormField, 'Seconds');

  await tester.enterText(hoursField, hours);
  await tester.enterText(minutesField, minutes);
  await tester.enterText(secondsField, seconds);
}

// Helper method to tap the button in the confirmation dialog
Future<void> tapConfirmationDialogButton(WidgetTester tester, String buttonText) async {
  final button = find.widgetWithText(TextButton, buttonText);
  await tester.ensureVisible(button); // Ensure the button is visible
  await tester.tap(button);
  await tester.pump(); // Pump the widget tree after tapping the button
}

// Helper method to tap the "Start Countdown" button
Future<void> tapStartCountdownButton(WidgetTester tester) async {
  final startButton = find.widgetWithText(ElevatedButton, 'Start Countdown');
  await tester.ensureVisible(startButton); // Ensure the button is visible
  await tester.tap(startButton);
  await tester.pump(); // Pump the widget tree after tapping the button
}
