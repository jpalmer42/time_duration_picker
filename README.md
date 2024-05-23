<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Use this Widget where you need to Collect or Show Time and Duration.
Widget uses the Horizontal Slider

## Features

Specify:
* initial TimeOfDay
* Time Range
* Minimum and Maximum Duration.
* Initial Duration.

## Getting started

```dart
import { TimeDurationPicker } from 'com.androidpigeon.widget.time_duration_picker';

## Usage
TimeDurationPicker(
    timeInitial?: TimeOfDay.now(),
    timeInterval?: const Duration(minutes: 30),
    timeRange?: [startTimeOfDay, endTimeOfDay],
    durationInterval?: const Duration(minutes: 5),
    durationInitial?: const Duration(hours: 2),
    durationRange?: [const Duration(hours: 0), const Duration(hours: 2)],

    
)

```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
