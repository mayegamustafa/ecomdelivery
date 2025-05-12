import 'package:delivery_boy/features/home/controller/home_ctrl.dart';
import 'package:delivery_boy/features/profile/controller/profile_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';

class SettingView extends HookConsumerWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
    final profileCtrl =
        useCallback(() => ref.read(profileCtrlProvider.notifier));

    final isActive = ref.watch(localHomeCtrlProvider
        .select((value) => value?.deliveryMan.pushNotification ?? false));

    Future<bool> handleToggle() async {
      final status = isActive ? '0' : '1';
      await profileCtrl().pushNotificationStatus(status);
      return isActive;
    }

    return Scaffold(
      appBar: KAppBar(
        leading: SquareButton.backButton(
          onPressed: () => context.pop(),
        ),
        title: Text(TR.of(context).settings),
      ),
      body: Padding(
        padding: Insets.padH,
        child: Column(
          children: [
            const Gap(Insets.lg),
            Container(
              decoration: BoxDecoration(
                borderRadius: Corners.medBorder,
                border: Border.all(
                  width: 1,
                  color: context.colorTheme.surfaceBright.withOpacity(.1),
                ),
              ),
              child: Padding(
                padding: Insets.padAllContainer,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor:
                          context.colorTheme.primary.withOpacity(.05),
                      child: Assets.icon.notification.svg(),
                    ),
                    const Gap(Insets.med),
                    Text(
                      TR.of(context).pushNotification,
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
            const Gap(10),
            Container(
              decoration: BoxDecoration(
                borderRadius: Corners.medBorder,
                border: Border.all(
                  width: 1,
                  color: context.colorTheme.surfaceBright.withOpacity(.1),
                ),
              ),
              child: Padding(
                padding: Insets.padAllContainer,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor:
                          context.colorTheme.primary.withOpacity(.05),
                      child: Icon(
                        isDarkMode
                            ? Icons.dark_mode_outlined
                            : Icons.light_mode_outlined,
                        color: context.colorTheme.primary,
                      ),
                    ),
                    const Gap(Insets.med),
                    Text(
                      isDarkMode
                          ? TR.of(context).darkTheme
                          : TR.of(context).lightTheme,
                      style: context.textTheme.bodyLarge,
                    ),
                    const Spacer(),
                    Tooltip(
                      message: TR.of(context).toggleBetweenThemes,
                      child: Switch(
                        value: isDarkMode,
                        onChanged: (value) {
                          ref.read(themeModeProvider.notifier).toggleTheme();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(10),
            ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: SettingsAction.values.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final action = SettingsAction.values[index];
                return SettingButton(
                  icon: action.icon,
                  title: action.title,
                  route: action.route,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

enum SettingsAction {
  language,
  currencySwitcher,
  reviews;

  String get icon => switch (this) {
        language => Assets.icon.language.path,
        currencySwitcher => Assets.icon.currency.path,
        reviews => Assets.icon.reviewButton.path,
      };
  String get title => switch (this) {
        language => TR.current.language,
        currencySwitcher => TR.current.currencySwitcher,
        reviews => TR.current.reviews,
      };
  String get route => switch (this) {
        language => RoutePaths.language,
        currencySwitcher => RoutePaths.currency,
        reviews => RoutePaths.myReview,
      };
}
