extension StringExt on String? {

  bool get isNotBlank => this != null && this!.trim().isNotEmpty;
}
