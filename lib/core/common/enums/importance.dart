enum Importance { no, low, high }

extension ImportanceExtension on Importance {
  String get label {
    switch (this) {
      case Importance.no:
        return 'No';
      case Importance.low:
        return 'Low';
      case Importance.high:
        return 'High';
    }
  }

  static Importance fromString(String value) {
    final a = value.toLowerCase();
    switch (a) {
      case 'no':
        return Importance.no;
      case 'low':
        return Importance.low;
      case 'high':
        return Importance.high;
      default:
        throw ArgumentError('Unknown importance: $value');
    }
  }
}
