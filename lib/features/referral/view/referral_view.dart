import 'dart:math';

import 'package:delivery_boy/features/home/controller/home_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../controller/referral_ctrl.dart';

class ReferralView extends HookConsumerWidget {
  const ReferralView({super.key});

  int _generateSixDigitNumber() {
    Random random = Random();
    int min = 100000;
    int max = 999999;
    return min + random.nextInt(max - min + 1);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final referralCtrl = useCallback(
      () => ref.read(referralCtrlProvider.notifier),
      [ref],
    );
    final referral = ref.watch(referralCtrlProvider);
    final homeCtrl = ref.watch(localHomeCtrlProvider);
    final referCode = homeCtrl?.deliveryMan.referralCode;

    final textController = useTextEditingController(
      text: referCode == 0 ? null : referCode.toString(),
    );

    return Scaffold(
      appBar: KAppBar(
        leading: SquareButton.backButton(
          onPressed: () => context.pop(),
        ),
        title: Text(TR.of(context).referAFriend),
      ),
      body: referral.when(
        error: (e, s) => ErrorView(e, s, invalidate: referralCtrlProvider),
        loading: Loader.list,
        data: (refer) => SingleChildScrollView(
          padding: Insets.padH.copyWith(top: Insets.med),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ReferTopCard(
                    title: TR.of(context).totalReferred,
                    svg: Assets.icon.change.svg(),
                    count: refer.overview.totalReferred.toString(),
                  ),
                  const Gap(Insets.med),
                  ReferTopCard(
                    title: TR.of(context).totalEarn,
                    svg: Assets.icon.gift.svg(),
                    count: '${refer.overview.totalPointEarned} Point',
                  ),
                ],
              ),
              const Gap(Insets.lg),
              Container(
                decoration: BoxDecoration(
                  borderRadius: Corners.medBorder,
                  color: context.colorTheme.surface,
                ),
                child: Padding(
                  padding: Insets.padAllContainer,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        TR.of(context).yourUniqueReferralLink,
                        style: context.textTheme.titleLarge,
                      ),
                      const Gap(Insets.lg),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: textController,
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText: TR.of(context).referralCode,
                                fillColor: context.colorTheme.surfaceBright
                                    .withOpacity(.05),
                              ),
                            ),
                          ),
                          const Gap(Insets.med),
                          GestureDetector(
                            onTap: () => Clipper.copy(textController.text),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    textController.text =
                                        _generateSixDigitNumber().toString();
                                  },
                                  child: Icon(
                                    Icons.sync,
                                    size: 25,
                                    color: context.colorTheme.primary,
                                  ),
                                ),
                                const Gap(Insets.sm),
                                Assets.icon.copy.svg(
                                  height: 25,
                                  colorFilter: ColorFilter.mode(
                                    context.colorTheme.errorContainer,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Gap(Insets.lg),
                      Row(
                        children: [
                          Expanded(
                            child: SubmitButton(
                              height: 45,
                              onPressed: (l) async {
                                l.value = true;
                                await referralCtrl().updateReferralCode(
                                  textController.text,
                                );
                                l.value = false;
                              },
                              child: Text(TR.of(context).update),
                            ),
                          ),
                          const Gap(Insets.sm),
                          IconButton.filled(
                            onPressed: () => Share.share(
                              'Invite your friends and earn rewards! Use my referral code $referCode to get started.',
                            ),
                            icon: const Icon(Icons.share),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(Insets.med),
              ListView.builder(
                itemCount: refer.deliveryMen.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return YourFriendCard(
                    data: refer.deliveryMen[index],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class YourFriendCard extends StatelessWidget {
  const YourFriendCard({
    super.key,
    required this.data,
  });

  final DeliveryMan data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              TR.of(context).yourFriends,
              style: context.textTheme.titleLarge,
            ),
            TextButton(
              onPressed: () => context.push(RoutePaths.referralList),
              child: Text(TR.of(context).seeAll),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: Corners.medBorder,
            color: context.colorTheme.surface,
          ),
          child: Padding(
            padding: Insets.padAllContainer,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor:
                      context.colorTheme.surfaceBright.withOpacity(.05),
                  backgroundImage: HostedImage.provider(data.image),
                ),
                const Gap(Insets.med),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.fullName,
                        style: context.textTheme.bodyLarge,
                      ),
                      SelectableText(
                        '${data.phoneCode} ${data.phone}',
                        style: context.textTheme.bodyMedium!.copyWith(
                          color:
                              context.colorTheme.surfaceBright.withOpacity(.7),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  data.registeredAt,
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: context.colorTheme.surfaceBright.withOpacity(.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ReferTopCard extends StatelessWidget {
  const ReferTopCard({
    super.key,
    required this.title,
    required this.count,
    required this.svg,
  });
  final String title;
  final String count;
  final Widget svg;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: Corners.medBorder,
          color: context.colorTheme.surface,
        ),
        child: Padding(
          padding: Insets.padAllContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  svg,
                  const Gap(Insets.sm),
                  Text(
                    title,
                    style: context.textTheme.bodyLarge,
                  ),
                ],
              ),
              const Gap(Insets.med),
              Text(
                count,
                style: context.textTheme.titleLarge,
              )
            ],
          ),
        ),
      ),
    );
  }
}
