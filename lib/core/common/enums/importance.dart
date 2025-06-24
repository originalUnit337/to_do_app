enum Importance {
  no,
  low,
  high;

  String get label {
    switch (this) {
      case Importance.no:
        return 'no';
      case Importance.low:
        return 'low';
      case Importance.high:
        return 'high';
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
