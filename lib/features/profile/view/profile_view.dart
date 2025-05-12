import 'package:delivery_boy/features/auth/controller/auth_ctrl.dart';
import 'package:delivery_boy/features/home/controller/home_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';
import '../../settings/controller/settings_ctrl.dart';
import '../controller/profile_ctrl.dart';

class ProfileView extends HookConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileCtrl =
        useCallback(() => ref.read(profileCtrlProvider.notifier));
    final isActive = ref.watch(
      localHomeCtrlProvider.select(
        (value) => value?.deliveryMan.isOnlineStatusActive ?? false,
      ),
    );
    final deliveryMan =
        ref.watch(localHomeCtrlProvider.select((value) => value?.deliveryMan));
    if (deliveryMan == null) {
      return ErrorView(TR.of(context).deliveryManNotFound, null).withSF();
    }

    final settingCtrl = ref.watch(localSettingsCtrlProvider);
    final pages = ref.watch(
      localSettingsCtrlProvider.select(
        (value) => value?.pages.data ?? [],
      ),
    );
    final settingsCtrl = ref.watch(localSettingsCtrlProvider);
    final homeLocal = ref.watch(localHomeCtrlProvider);

    Future<bool> handleToggle() async {
      final status = isActive ? 'offline' : 'online';
      await profileCtrl().updateActiveStatus(status);
      return isActive;
    }

    final myPoint = homeLocal?.deliveryMan.point.toDouble() ?? 0;

    final RewardPoint? matchingReward =
        settingsCtrl?.config.rewardAmountConfigurations.firstWhere(
      (config) => myPoint >= config.minAmount && myPoint <= config.lessThanEq,
      orElse: () => RewardPoint(
        name: TR.of(context).noReward,
        amount: 0,
        lessThanEq: 0,
        minAmount: 0,
      ),
    );

    return Scaffold(
      backgroundColor: context.colorTheme.surface,
      body: RefreshIndicator(
        onRefresh: () => ref.read(homeCtrlProvider.notifier).reload(),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset(
                Assets.png.bg.path,
                width: context.width,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 40,
                child: Column(
                  children: [
                    Text(
                      TR.of(context).profile,
                      style: context.textTheme.titleLarge!.copyWith(
                        color: context.colorTheme.onPrimary,
                      ),
                    ),
                    Gap(context.height * .1),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: context.height * .3,
                          width: context.width,
                          decoration: BoxDecoration(
                            color: context.colorTheme.surface,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(32),
                            ),
                          ),
                          child: Column(
                            children: [
                              Gap(context.height * .07),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    deliveryMan.firstName,
                                    style: context.textTheme.titleLarge,
                                  ),
                                  const Gap(Insets.med),
                                  GestureDetector(
                                    onTap: () =>
                                        context.push(RoutePaths.myReview),
                                    child: Container(
                                      height: 20,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: context.colorTheme.primary,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Row(
                                        children: [
                                          Assets.icon.star.svg(
                                            height: 16,
                                            colorFilter: ColorFilter.mode(
                                              context.colorTheme.onPrimary,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                          const Gap(Insets.sm),
                                          Text(
                                            deliveryMan.avgRatings.toString(),
                                            style: TextStyle(
                                              color:
                                                  context.colorTheme.onPrimary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '${TR.of(context).username} @${deliveryMan.username}',
                                style: context.textTheme.bodyMedium!.textColor(
                                  context.colorTheme.surfaceBright.op7,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${TR.of(context).orderBalance} ${homeLocal?.deliveryMan.orderBalance.formate()}',
                                    style:
                                        context.textTheme.bodyMedium!.textColor(
                                      context.colorTheme.surfaceBright.op7,
                                    ),
                                  ),
                                  const Gap(Insets.med),
                                  if (homeLocal?.deliveryMan.referredBy !=
                                      null) ...[
                                    Container(
                                      height: 18,
                                      width: 2,
                                      color: context.colorTheme.surfaceBright
                                          .withOpacity(.1),
                                    ),
                                    const Gap(Insets.med),
                                    Text(
                                      '${TR.of(context).referralBy} ${homeLocal?.deliveryMan.referredBy!.firstName}',
                                      style: context.textTheme.bodyMedium!
                                          .textColor(
                                        context.colorTheme.surfaceBright.op7,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const Gap(Insets.med),
                              Padding(
                                padding: Insets.padH,
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () =>
                                          context.push(RoutePaths.redeemPoints),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              context.colorTheme.surfaceBright,
                                          borderRadius: Corners.medBorder,
                                        ),
                                        child: Padding(
                                          padding: Insets.padAllContainer,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Assets.icon.coins.svg(
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                      context
                                                          .colorTheme.surface,
                                                      BlendMode.srcIn,
                                                    ),
                                                  ),
                                                  const Gap(Insets.med),
                                                  Text(
                                                    '${matchingReward?.name}- ${deliveryMan.point} ${TR.of(context).point}',
                                                    style: context
                                                        .textTheme.titleLarge
                                                        ?.copyWith(
                                                      color: context
                                                          .colorTheme.surface,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Gap(Insets.med),
                                              Text(
                                                deliveryMan.point != 0
                                                    ? '${TR.of(context).youWillGet} ${matchingReward?.amount.formate(calculateRate: true)} ${TR.of(context).byRedeeming} ${deliveryMan.point} ${TR.of(context).point}'
                                                    : TR
                                                        .of(context)
                                                        .youDontHaveAnyPoint,
                                                style: context
                                                    .textTheme.bodyMedium!
                                                    .copyWith(
                                                  color: context
                                                      .colorTheme.surface,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 10,
                                      top: 10,
                                      child: CircleAvatar(
                                        radius: 15,
                                        child: Assets.icon.star.svg(height: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 10,
                          right: 10,
                          top: -60,
                          child: CircleAvatar(
                            backgroundColor:
                                context.colorTheme.onPrimary.withOpacity(.5),
                            radius: 60,
                            child: CircleAvatar(
                              radius: 55,
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: HostedImage(
                                        deliveryMan.image,
                                        height: 100,
                                        width: 100,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    right: 0,
                                    child: CircleAvatar(
                                      radius: 10,
                                      child: CircleAvatar(
                                        backgroundColor: isActive
                                            ? context.colorTheme.errorContainer
                                            : context.colorTheme.surfaceBright
                                                .withOpacity(.7),
                                        radius: 8,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(context.height / 2.4),
                  Padding(
                    padding: Insets.padH.copyWith(top: Insets.med),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(Insets.lg),
                        Text(
                          TR.of(context).general,
                          style: context.textTheme.titleLarge,
                        ),
                        const Gap(Insets.lg),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: Corners.medBorder,
                            border: Border.all(
                              width: 1,
                              color: context.colorTheme.surfaceBright
                                  .withOpacity(.1),
                            ),
                          ),
                          child: Padding(
                            padding: Insets.padAllContainer,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: context.colorTheme.primary
                                      .withOpacity(.05),
                                  child: Assets.icon.off.svg(),
                                ),
                                const Gap(Insets.med),
                                Text(
                                  TR.of(context).activeStatus,
                                  style: context.textTheme.bodyLarge,
                                ),
                                const Spacer(),
                                LoadingSwitch(
                                  value: isActive,
                                  onChange: (v) => handleToggle(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Gap(Insets.med),
                        SettingButton(
                          iconSize: 25,
                          colorFilter: ColorFilter.mode(
                            context.colorTheme.primary,
                            BlendMode.srcIn,
                          ),
                          icon: Assets.icon.assign.path,
                          title: TR.of(context).assignOrder,
                          route: RoutePaths.assignByMe,
                        ),
                        SettingButton(
                          iconSize: 20,
                          colorFilter: ColorFilter.mode(
                            context.colorTheme.primary,
                            BlendMode.srcIn,
                          ),
                          icon: Assets.icon.verified.path,
                          title: TR.of(context).kycLog,
                          route: RoutePaths.kycLogs,
                        ),
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: GeneralAction.values.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final action = GeneralAction.values[index];
                            return SettingButton(
                              color: context.colorTheme.primary,
                              icon: action.icon,
                              title: action.title,
                              route: action.route,
                            );
                          },
                        ),
                        const Gap(Insets.med),
                        Text(
                          TR.of(context).others,
                          style: context.textTheme.titleLarge,
                        ),
                        const Gap(Insets.lg),
                        if (settingCtrl!.config.referralSystem)
                          SettingButton(
                            color: context.colorTheme.primary,
                            icon: Assets.icon.referral.path,
                            title: TR.of(context).referralConfiguration,
                            route: RoutePaths.referral,
                          ),
                        SettingButton(
                          color: context.colorTheme.primary,
                          icon: Assets.icon.sms.path,
                          title: TR.of(context).helpSupportTicket,
                          route: RoutePaths.support,
                        ),
                        ListView.builder(
                          padding: const EdgeInsets.all(0),
                          itemCount: pages.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return SettingButton(
                              colorFilter: ColorFilter.mode(
                                context.colorTheme.errorContainer,
                                BlendMode.srcIn,
                              ),
                              color: context.colorTheme.errorContainer,
                              icon: Assets.icon.info.path,
                              title: pages[index].name,
                              onTap: () => context.push(
                                  RoutePaths.pageDetails(pages[index].uid)),
                            );
                          },
                        ),
                        SubmitButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              context.colorTheme.primary.withOpacity(.1),
                            ),
                          ),
                          onPressed: (l) {
                            ref.read(authCtrlProvider.notifier).logout();
                          },
                          child: Text(
                            TR.of(context).logout,
                            style: TextStyle(
                              color: context.colorTheme.primary,
                            ),
                          ),
                        ),
                        const Gap(Insets.lg),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum GeneralAction {
  myProfile,
  changePassword,
  wallet,
  settings;

  String get icon => switch (this) {
        myProfile => Assets.icon.profileOutline.path,
        changePassword => Assets.icon.lock.path,
        wallet => Assets.icon.money.path,
        settings => Assets.icon.setting.path,
      };
  String get title => switch (this) {
        myProfile => TR.current.myProfile,
        changePassword => TR.current.changePassword,
        wallet => TR.current.wallet,
        settings => TR.current.settings,
      };
  String get route => switch (this) {
        myProfile => RoutePaths.myProfile,
        changePassword => RoutePaths.passwordChange,
        wallet => RoutePaths.myWallet,
        settings => RoutePaths.settings,
      };
}
