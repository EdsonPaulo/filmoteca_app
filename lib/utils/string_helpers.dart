/// Return text with initial as UpperCase
String capitalizeText(String value) {
  if (value.isEmpty) {
    return '';
  }

  return '${value[0].toUpperCase()}${value.substring(1)}';
}

String formatDuration(int? durationInMinutes) {
  if (durationInMinutes == null) {
    return '--';
  }

  int hours = (durationInMinutes / 60).floor();
  int minutes = durationInMinutes % 60;

  return '${hours}h ${minutes}m';
}
