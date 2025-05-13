String removeRegExp(String rawError) {
  final RegExp regex = RegExp(r'\] (.*)');
  final match = regex.firstMatch(rawError);
  return match != null ? match.group(1)!.trim() : rawError;
}
