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

String getNameInitials(String? name) {
  if (name == null) return '';
  List<String> names = name.split(" ");
  String initials = "";
  for (String part in names) {
    if (part.trim().isNotEmpty) {
      initials = initials + part.trim()[0].toUpperCase();
    }
  }
  return initials;
}
