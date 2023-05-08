DateTime toUTCSameInstant(DateTime date) {
  if (date.isUtc && date.microsecond == 0) {
    return date;
  } else {
    return DateTime.utc(
      date.year,
      date.month,
      date.day,
      date.hour,
      date.minute,
      date.second,
      date.millisecond,
      0,
    );
  }
}

DateTime toUTCDateTime(String string) {
  final dateTime = DateTime.parse(string);

  return toUTCSameInstant(dateTime);
}

DateTime toDate(String string) {
  return DateTime.parse(string);
}
