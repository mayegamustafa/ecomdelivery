import 'package:delivery_boy/main.export.dart';

class Config {
  const Config({
    required this.deliveryStatus,
    required this.ticketPriority,
    required this.leftCurrency,
    required this.declineAssignRequest,
    required this.onBoardingData,
    required this.orderVerification,
    required this.deliverymanKycVerification,
    required this.deliverymanRegistration,
    required this.deliveryManModule,
    required this.chatWithCustomer,
    required this.chatWithDeliveryman,
    required this.orderAssign,
    required this.referralSystem,
    required this.reviewRequest,
    required this.deliverymanClubPointSystem,
    required this.deliverymanWalletPointConversionRate,
    required this.deliverymanDefaultRewardPoint,
    required this.deliverymanRewardPointExpiredAfter,
    required this.rewardAmountConfigurations,
    required this.rewardPointConfigurations,
    required this.defaultOrderStatus,
  });

  factory Config.fromMap(Map<String, dynamic> map) {
    return Config(
      leftCurrency: map['currency_position_is_left'] as bool,
      deliveryStatus: JEnum.fromMap(map['delevary_status']),
      ticketPriority: JEnum.fromMap(map['ticket_priority']),
      onBoardingData: OnBoardingData.fromList(map['onboarding_pages']),
      declineAssignRequest: map['decline_assign_request'] as bool,
      deliverymanKycVerification: map['deliveryman_kyc_verification'] as bool,
      deliverymanRegistration: map['deliveryman_registration'] as bool,
      deliveryManModule: map['delivery_man_module'] as bool,
      chatWithCustomer: map['chat_with_customer'] as bool,
      orderVerification: map['order_verification'] as bool,
      chatWithDeliveryman: map['chat_with_deliveryman'] as bool,
      orderAssign: map['order_assign'] as bool,
      referralSystem: map['referral_system'] as bool,
      reviewRequest: map['review_request'] as bool,
      deliverymanClubPointSystem: map['deliveryman_club_point_system'] as bool,
      deliverymanWalletPointConversionRate:
          map.parseNum('deliveryman_wallet_point_conversion_rate'),
      deliverymanDefaultRewardPoint:
          map.parseNum('deliveryman_default_reward_point'),
      deliverymanRewardPointExpiredAfter:
          map.parseNum('deliveryman_reward_point_expired_after'),
      rewardAmountConfigurations:
          RewardPoint.fromList(map['reward_amount_configurations']),
      rewardPointConfigurations:
          RewardPointConfig.fromList(map['reward_point_configurations']),
      defaultOrderStatus: map['default_order_status'] ?? '',
    );
  }

  final JEnum deliveryStatus;
  final JEnum ticketPriority;
  final bool leftCurrency;
  final List<OnBoardingData> onBoardingData;
  final bool deliverymanKycVerification;
  final bool deliverymanRegistration;
  final bool deliveryManModule;
  final bool chatWithCustomer;
  final bool declineAssignRequest;
  final bool chatWithDeliveryman;
  final bool orderAssign;
  final bool referralSystem;
  final bool reviewRequest;
  final bool orderVerification;

  final bool deliverymanClubPointSystem;
  final num deliverymanWalletPointConversionRate;
  final num deliverymanDefaultRewardPoint;
  final num deliverymanRewardPointExpiredAfter;
  final List<RewardPoint> rewardAmountConfigurations;
  final List<RewardPointConfig> rewardPointConfigurations;
  final String defaultOrderStatus;

  Map<String, dynamic> toMap() {
    final data = {
      'currency_position_is_left': leftCurrency,
      'delevary_status': deliveryStatus.enumData,
      'ticket_priority': ticketPriority.enumData,
      'onboarding_pages': onBoardingData.map((x) => x.toMap()).toList(),
      'deliveryman_kyc_verification': deliverymanKycVerification,
      'deliveryman_registration': deliverymanRegistration,
      'delivery_man_module': deliveryManModule,
      'chat_with_customer': chatWithCustomer,
      'chat_with_deliveryman': chatWithDeliveryman,
      'order_verification': orderVerification,
      'order_assign': orderAssign,
      'referral_system': referralSystem,
      'review_request': reviewRequest,
      'deliveryman_club_point_system': deliverymanClubPointSystem,
      'decline_assign_request': declineAssignRequest,
      'deliveryman_wallet_point_conversion_rate':
          deliverymanWalletPointConversionRate,
      'deliveryman_default_reward_point': deliverymanDefaultRewardPoint,
      'deliveryman_reward_point_expired_after':
          deliverymanRewardPointExpiredAfter,
      'reward_amount_configurations':
          rewardAmountConfigurations.map((x) => x.toMap()).toList(),
      'reward_point_configurations':
          rewardPointConfigurations.map((x) => x.toMap()).toList(),
      'default_order_status': defaultOrderStatus,
    };
    return data;
  }
}

class OnBoardingData {
  final String image;
  final String header;
  final String body;

  const OnBoardingData({
    required this.image,
    required this.header,
    required this.body,
  });

  factory OnBoardingData.fromMap(Map<String, dynamic> map) {
    return OnBoardingData(
      image: map['image'] ?? '',
      header: map['heading'] ?? '',
      body: map['description'] ?? '',
    );
  }

  static List<OnBoardingData> fromList(List? list) {
    return List<OnBoardingData>.from(
      list?.map((x) => OnBoardingData.fromMap(x)) ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {'image': image, 'heading': header, 'description': body};
  }
}
