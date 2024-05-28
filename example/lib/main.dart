import 'package:flutter/material.dart';
import 'package:time_duration_picker/helper/time_of_day_ext.dart';
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

  TimeDuration? timeDuration;
  @override
  Widget build(BuildContext context) {
    final containerWidth = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time and Duration Picker'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: containerWidth,
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (timeDuration != null)
                Text(
                  '${timeDuration!.timeOfDay.format(context)} for ${timeDuration!.duration.format(context)}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              TimeDurationPicker(
                key: _refreshKey, // Cause initState to be called when testing
                timeInitial: const TimeOfDay(hour: 1, minute: 30),
                timeInterval: const Duration(minutes: 15),
                timeRange: const [
                  TimeOfDay(hour: 1, minute: 0),
                  TimeOfDay(hour: 23, minute: 30),
                ],
                durationInitial: const Duration(hours: 2),
                durationRange: const [
                  Duration(hours: 1),
                  Duration(hours: 4),
                ],
                onChange: (timeDuration) => setState(() {
                  this.timeDuration = timeDuration;
                }),
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
      ),
    );
  }
}
