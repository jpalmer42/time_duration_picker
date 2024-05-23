library time_duration_picker;

import 'package:flutter/material.dart';

class TimeDurationPicker extends StatefulWidget {
  final TimeOfDay? timeInitial;
  final Duration? timeInterval;
  final List<TimeOfDay>? timeRange;
  //
  final Duration? durationInitial;
  final Duration? durationInterval;
  final List<Duration>? durationRange;
  //
  const TimeDurationPicker({
    super.key,
    this.timeInitial,
    this.timeInterval,
    this.timeRange,
    //
    this.durationInitial,
    this.durationInterval,
    this.durationRange,
  });

  @override
  State<TimeDurationPicker> createState() => _TimeDurationPickerState();
}

class _TimeDurationPickerState extends State<TimeDurationPicker> {
  late final TimeOfDay timeInitial;
  late final Duration timeInterval;
  late final List<TimeOfDay> timeRange;
  //
  late final Duration durationInitial;
  late final Duration durationInterval;
  late final List<Duration> durationRange;

  @override
  void initState() {
    timeInterval = widget.timeInterval ?? const Duration(minutes: 15);
    timeInitial = widget.timeInitial ?? TimeOfDay.now();
    timeRange = widget.timeRange ?? [const TimeOfDay(hour: 0, minute: 0), const TimeOfDay(hour: 23, minute: 59)];
    //
    durationInterval = widget.durationInterval ?? const Duration(minutes: 5);
    durationInitial = widget.durationInitial ?? const Duration(minutes: 5);
    durationRange = widget.durationRange ?? [Duration.zero, const Duration(hours: 24)];
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
