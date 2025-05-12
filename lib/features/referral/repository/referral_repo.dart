import 'package:delivery_boy/main.export.dart';

class ReferralRepo extends Repo {
  FutureResponse<String> updateReferralCode(String code) async {
    final data = await rdb.updateReferralCode(
      code,
    );
    return data;
  }

  FutureResponse<ReferralLog> getReferralLog() async {
    final data = await rdb.getReferralLog();
    return data;
  }
}
