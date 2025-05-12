import 'package:delivery_boy/main.export.dart';

class HomeRepo extends Repo {
  FutureResponse<HomeModel> getHomeData() async {
    final data = await rdb.fetchHomeData();
    return data;
  }

  HomeModel? getHomeDataSync() {
    final data = ldb.fetchHomeData();
    return data;
  }

  Future<HomeModel> saveHomeData(HomeModel home) async {
    final data = await ldb.setHomeData(home);
    return data;
  }
}
