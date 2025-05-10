extension DurationExtension on num {
  Duration get ms => Duration(milliseconds: toInt());
  Duration get s =>
      Duration(milliseconds: toInt() * Duration.millisecondsPerSecond);
  Duration get min =>
      Duration(milliseconds: toInt() * Duration.millisecondsPerMinute);
  Duration get hour =>
      Duration(milliseconds: toInt() * Duration.millisecondsPerHour);
}
