import 'package:delivery_boy/features/settings/controller/settings_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';

final serverStatusProvider =
    AutoDisposeNotifierProvider<ServerStatusNotifier, ServerStatus>(
        ServerStatusNotifier.new);

class ServerStatusNotifier extends AutoDisposeNotifier<ServerStatus> {
  void update(int? code) {
    if (code == null) return;

    final status = ServerStatus.fromCode(code);
    if (status == state) return;

    state = status;
  }

  Future<void> retryStatusResolver() async {
    await ref.read(appSettingsCtrlProvider.notifier).reload();
  }

  @override
  ServerStatus build() {
    ServerStatus status = ServerStatus.active;

    return status;
  }
}

enum ServerStatus {
  active,
  noKyc,
  moduleInactive,
  maintenance,
  invalidPurchase;

  String? get paths => switch (this) {
        ServerStatus.active => null,
        ServerStatus.noKyc => RoutePaths.verifyKyc,
        ServerStatus.moduleInactive => RoutePaths.moduleInactive,
        ServerStatus.maintenance => RoutePaths.maintenance,
        ServerStatus.invalidPurchase => RoutePaths.invalidPurchase,
      };
  int? get code => switch (this) {
        active => null,
        noKyc => 6000000,
        moduleInactive => 6000,
        maintenance => 1000000,
        invalidPurchase => 2000000,
      };

  factory ServerStatus.fromCode(int? code) => switch (code) {
        6000000 => ServerStatus.noKyc,
        6000 => ServerStatus.moduleInactive,
        1000000 => ServerStatus.maintenance,
        2000000 => ServerStatus.invalidPurchase,
        _ => ServerStatus.active,
      };

  bool get isActive => this == ServerStatus.active;
  bool get isNoKyc => this == ServerStatus.noKyc;
  bool get isModuleInactive => this == ServerStatus.moduleInactive;
  bool get isMaintenance => this == ServerStatus.maintenance;
  bool get isInvalidPurchase => this == ServerStatus.invalidPurchase;
}
