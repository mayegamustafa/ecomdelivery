import 'package:delivery_boy/main.export.dart';
import 'package:flutter/foundation.dart';

abstract class Repo {
  @protected
  final ldb = locate<LocalDB>();

  @protected
  final rdb = locate<RemoteDB>();
}
