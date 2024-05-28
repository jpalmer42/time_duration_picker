import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  int compareTo(TimeOfDay other) {
    final ticksLeft = hour * 60 + minute;
    final ticksRight = other.hour * 60 + other.minute;
    return ticksLeft - ticksRight;
  }

  int get inMinutes => hour * 60 + minute;

  int operator -(Object other) {
    if (other is TimeOfDay) {
      return inMinutes - other.inMinutes;
    } else {
      throw Exception('Invalid Type');
    }
  }

  static TimeOfDay fromMinutes(int minutes) => TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60);
}

extension DurationExtension on Duration {
  int get minutes => inMinutes - (inHours * 60);

  String format(BuildContext context) {
    final min = '$minutes'.padLeft(2, '0');
    return '${inHours}h:${min}m';
  }
}
