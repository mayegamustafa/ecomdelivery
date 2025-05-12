import 'package:delivery_boy/main.export.dart';

class OnboardRepo extends Repo {
  bool showOnboard() => ldb.showOnboard();
  Future<bool> disableOnboard() => ldb.disableOnboard();
}
