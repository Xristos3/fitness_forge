import 'package:fitness_forge/ui/screen/exercises.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test Countdown Timer Widget', (WidgetTester tester) async {
    // Build our widget
    await tester.pumpWidget(
      MaterialApp(
        home: CountdownTimer(
          title: 'Test Exercise',
          description: 'This is a test exercise description.',
          imagePath: 'path/to/image.png',
          nextScreen: Scaffold(), // You can use any widget here for testing purposes
        ),
      ),
    );

    // Verify that the countdown starts at 40 seconds
    expect(find.text('Countdown: 40 seconds'), findsOneWidget);

    // Tap the "Start" button
    await tester.tap(find.text('Start'));
    await tester.pump(); // Wait for the countdown to start

    // Verify that the countdown is decreasing
    expect(find.text('Countdown: 39 seconds'), findsOneWidget);

    // Wait for 2 seconds to simulate the countdown
    await tester.pump(Duration(seconds: 2));

    // Verify that the countdown is decreased by 2 seconds
    expect(find.text('Countdown: 37 seconds'), findsOneWidget);

    // Tap the "Take a break" button
    await tester.tap(find.text('Take a break'));
    await tester.pump(); // Wait for the countdown to start

    // Verify that the countdown starts at 15 seconds after the break button is pressed
    expect(find.text('Countdown: 15 seconds'), findsOneWidget);

    // Wait for 15 seconds to simulate the break
    await tester.pump(Duration(seconds: 15));

    // Verify that the "Next" button appears after the break
    expect(find.text('Next'), findsOneWidget);
  });
}
