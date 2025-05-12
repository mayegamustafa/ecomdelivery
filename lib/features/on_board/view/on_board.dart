import 'package:delivery_boy/features/on_board/controller/onboard_ctrl.dart';
import 'package:delivery_boy/features/settings/controller/settings_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends HookConsumerWidget {
  const OnboardingView({super.key});

  Size get preferredSize => const Size.fromHeight(250);

  void disableAndGo(WidgetRef ref, BuildContext context) {
    ref.read(onBoardCtrlProvider.notifier).disableOnboard();
    context.push(RoutePaths.login);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    final current = useState(0);
    final settingsData = ref.watch(appSettingsCtrlProvider);

    return settingsData.when(
      error: (e, s) => ErrorView(e, s, invalidate: appSettingsCtrlProvider),
      loading: () => const Loader(),
      data: (settings) {
        final onboard = settings.config.onBoardingData;

        return Scaffold(
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView.builder(
                controller: pageController,
                itemCount: onboard.length,
                onPageChanged: (index) {
                  current.value = index;
                },
                itemBuilder: (context, index) {
                  final page = onboard[index];
                  return Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      SizedBox(height: preferredSize.height),
                      HostedImage(
                        page.image,
                        height: context.height / 1.4,
                        width: context.width,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: context.height / 2.5,
                          width: context.width,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                            color: context.colorTheme.surface,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 45,
                          ),
                          child: Column(
                            children: [
                              const Gap(Insets.lg),
                              Text(
                                page.header,
                                style: context.textTheme.headlineSmall,
                                textAlign: TextAlign.center,
                              ),
                              const Gap(Insets.lg),
                              Text(
                                page.body,
                                style: context.textTheme.bodyMedium!.textColor(
                                  context.colorTheme.surfaceBright
                                      .withOpacity(.7),
                                ),
                                maxLines: 4,
                                textAlign: TextAlign.center,
                              ),
                              const Gap(Insets.offset),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Positioned(
                child: Padding(
                  padding: Insets.padAll,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedSmoothIndicator(
                        activeIndex: current.value,
                        count: onboard.length,
                        effect: ExpandingDotsEffect(
                          activeDotColor: context.colorTheme.primary,
                          dotColor:
                              context.colorTheme.surfaceBright.withOpacity(.1),
                          dotHeight: 5,
                          dotWidth: 5,
                          expansionFactor: 6,
                        ),
                      ),
                      const Gap(Insets.med),
                      SubmitButton(
                        onPressed: (l) {
                          if (current.value < onboard.length - 1) {
                            pageController.nextPage(
                              duration: 300.ms,
                              curve: Curves.easeInOut,
                            );
                          } else {
                            disableAndGo(ref, context);
                          }
                        },
                        child: Text(
                          current.value == onboard.length - 1
                              ? TR.of(context).getStarted
                              : TR.of(context).next,
                        ),
                      ),
                      const Gap(Insets.med),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: TR.of(context).haveAccount,
                              style: context.textTheme.bodyLarge,
                            ),
                            const TextSpan(text: ' '),
                            TextSpan(
                              text: TR.of(context).signIn.toUpperCase(),
                              style: context.textTheme.bodyLarge!.underline,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
