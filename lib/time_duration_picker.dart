library time_duration_picker;

import 'package:flutter/material.dart';
import 'package:time_duration_picker/helper/time_of_day_ext.dart';

class TimeDurationPicker extends StatefulWidget {
  final TimeOfDay? timeInitial;
  final Duration? timeInterval;
  final List<TimeOfDay>? timeRange;
  //
  final Duration? durationInitial;
  final Duration? durationInterval;
  final List<Duration>? durationRange;
  //
  final Function(TimeDuration timeDuration)? onChange;
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
    //
    this.onChange,
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
  //
  late TimeDuration timeDuration;

  @override
  void initState() {
    debugPrint('initState');
    final now = TimeOfDay.now();

    // Copy widget values.
    timeInterval = widget.timeInterval ?? const Duration(minutes: 15);
    timeInitial = widget.timeInitial ?? TimeOfDay(hour: now.hour, minute: timeInterval.minutes);
    timeRange = widget.timeRange ?? [const TimeOfDay(hour: 0, minute: 0), const TimeOfDay(hour: 24, minute: 0)];
    //
    durationInterval = widget.durationInterval ?? const Duration(minutes: 30);
    durationInitial = widget.durationInitial ?? Duration(minutes: durationInterval.minutes);
    durationRange = widget.durationRange ?? [Duration.zero, const Duration(hours: 24)];

    // Check values meet conditions
    assert(timeInterval.inHours <= 4); // Ensure the Interval is <= 4 hours (Seems resonable)
    assert((timeInterval.inMinutes % 5) == 0); // Interval must be on 5 minute boundaries (Seems resonable)
    assert(timeInitial.hour >= 0 && timeInitial.hour < 24); // Initial Hour must be within the a 24 hour period
    assert((timeInitial.minute % timeInterval.inMinutes) == 0); // Ensure the initial minutes is within the interval specified
    assert(timeRange[0].hour <= timeInitial.hour);
    assert(timeRange[1].hour >= timeInitial.hour);
    assert((timeRange[0].minute % timeInterval.minutes) == 0);
    assert((timeRange[1].minute % timeInterval.minutes) == 0);
    //
    assert(durationInitial.inHours <= 4); // Ensure the Interval is <= 4 hours (Seems resonable)
    assert((durationInitial.inMinutes % 5) == 0); // Interval must be on 5 minute boundaries (Seems resonable)
    assert(durationInitial.inHours < 24); // Duration can't be more than a 24 hour period.
    assert((durationInitial.inMinutes % 5) == 0); // Interval must be on 5 minute boundaries
    assert(durationRange[0].inHours <= durationInitial.inHours);
    assert(durationRange[1].inHours >= durationInitial.inHours);
    assert((durationRange[0].minutes % durationInitial.minutes) == 0);
    assert((durationRange[1].minutes % durationInitial.minutes) == 0);

    // Calc Time Bar
    timeGraduations = (timeRange[1].inMinutes - timeRange[0].inMinutes) / timeInterval.inMinutes;
    hourValue = timeInitial.inMinutes / timeInterval.inMinutes;
    durationGraduations = (durationRange[1].inMinutes - durationRange[0].inMinutes) / durationInitial.inMinutes;
    //
    calculate();
    super.initState();
  }

  double timeGraduations = 0;
  double hourValue = 0;

  double durationGraduations = 0;
  double durationValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Time Bar', style: Theme.of(context).textTheme.headlineMedium),
        Slider(
          label: timeDuration.timeOfDay.format(context),
          divisions: timeGraduations.toInt(),
          min: 0,
          max: timeGraduations,
          value: hourValue,
          activeColor: Theme.of(context).sliderTheme.inactiveTrackColor,
          thumbColor: Theme.of(context).sliderTheme.activeTrackColor,
          onChanged: (double value) {
            setState(() {
              hourValue = value;
            });
            calculate();
            if (widget.onChange != null) {
              widget.onChange!(timeDuration);
            }
          },
        ),
        Text('Duration Bar', style: Theme.of(context).textTheme.headlineMedium),
        Slider(
          label: timeDuration.duration.format(context),
          divisions: durationGraduations.toInt(),
          min: 0,
          max: durationGraduations,
          value: durationValue,
          onChanged: (double value) {
            setState(() {
              durationValue = value;
            });
            calculate();
            if (widget.onChange != null) {
              widget.onChange!(timeDuration);
            }
          },
        ),
      ],
    );
  }

  void calculate() {
    final timeMinutes = timeRange[0].inMinutes + timeInterval.minutes * hourValue.toInt();
    TimeOfDay timeOfDay = TimeOfDayExtension.fromMinutes(timeMinutes);
    final durationMinutes = durationRange[0].inMinutes + durationInitial.minutes * durationValue.toInt();
    Duration duration = Duration(minutes: durationMinutes);
    timeDuration = TimeDuration(timeOfDay, duration);
  }
}

class TimeDuration {
  late final TimeOfDay timeOfDay;
  late final Duration duration;
  TimeDuration(
    this.timeOfDay,
    this.duration,
  );
}
