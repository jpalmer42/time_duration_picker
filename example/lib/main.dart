import 'package:flutter/material.dart';
import 'package:time_duration_picker/time_duration_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Duration Picker Demo',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Example(),
    );
  }
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  Key _refreshKey = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time and Duration Picker'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            TimeDurationPicker(
              key: _refreshKey, // Cause initState to be called when testing
              // timeInterval: Duration(minutes: 15),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => setState(() {
                _refreshKey = UniqueKey();
              }),
              child: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}
