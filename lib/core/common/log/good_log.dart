import 'package:talker/talker.dart';

class GoodLog extends TalkerLog {
  GoodLog(super.message);

  static String get getTitle => 'Good';

  static String get getKey => 'good_log_key';

  static AnsiPen get getPen => AnsiPen()..green();

  @override
  String get title => getTitle;

  @override
  String? get key => getKey;

  @override
  AnsiPen get pen => getPen;
}
