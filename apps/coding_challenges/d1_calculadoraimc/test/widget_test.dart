import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// The widget you want to test
class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Counter: $_counter'),
        ElevatedButton(
          onPressed: _incrementCounter,
          child: const Text('Increment'),
        ),
      ],
    );
  }
}

void main() {
  testWidgets('CounterWidget increments counter', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: CounterWidget()));

    // Initial counter value
    expect(find.text('Counter: 0'), findsOneWidget);

    // Tap the increment button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify that the counter value has incremented
    expect(find.text('Counter: 1'), findsOneWidget);
  });
}
