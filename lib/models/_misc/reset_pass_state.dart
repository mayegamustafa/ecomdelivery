import 'package:delivery_boy/main.export.dart';

class PassResetState {
  const PassResetState({
    required this.phone,
    required this.phoneCode,
    required this.otp,
    required this.password,
    required this.confirmPassword,
  });

  factory PassResetState.fromMap(Map<String, dynamic> map) {
    return PassResetState(
      phone: map['phone'],
      phoneCode: map['phone_code'],
      otp: map['code'],
      password: map['password'],
      confirmPassword: map['password_confirmation'],
    );
  }

  static PassResetState empty = const PassResetState(
    phoneCode: '',
    otp: '',
    password: '',
    confirmPassword: '',
    phone: '',
  );

  final String phone;
  final String phoneCode;
  final String otp;
  final String password;
  final String confirmPassword;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'phone': phone});
    result.addAll({'phone_code': phoneCode});
    result.addAll({'code': otp});
    result.addAll({'password': password});
    result.addAll({'password_confirmation': confirmPassword});
    return result;
  }

  PassResetState copyWith({
    String? phone,
    String? phoneCode,
    String? otp,
    String? password,
    String? confirmPassword,
  }) {
    return PassResetState(
      phone: phone ?? this.phone,
      phoneCode: phoneCode ?? this.phoneCode,
      otp: otp ?? this.otp,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  PassResetState copyWithMap(QMap map) {
    Logger.json(map, 'map');

    final data = PassResetState(
      phone: map['phone'] ?? phone,
      phoneCode: map['phone_code'] ?? phoneCode,
      otp: map['code'] ?? otp,
      password: map['password'] ?? password,
      confirmPassword: map['password_confirmation'] ?? confirmPassword,
    );
    Logger.json(data.toMap(), 'data');
    return data;
  }
}
