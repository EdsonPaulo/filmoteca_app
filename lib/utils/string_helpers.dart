/// Return text with initial as UpperCase
String capitalizeText(String value) {
  if (value.isEmpty) {
    return '';
  }

  return '${value[0].toUpperCase()}${value.substring(1)}';
}
