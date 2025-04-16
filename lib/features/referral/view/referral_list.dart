import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';

import '../controller/referral_ctrl.dart';
import 'referral_view.dart';

class ReferralListView extends HookConsumerWidget {
  const ReferralListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final referralList = ref.watch(referralCtrlProvider);
    final referralCtrl =
        useCallback(() => ref.read(referralCtrlProvider.notifier));
    return Scaffold(
      appBar: KAppBar(
        leading: SquareButton.backButton(
          onPressed: () => context.pop(),
        ),
        title: Text(TR.of(context).referralLists),
      ),
      body: referralList.when(
        error: (e, s) {
          return ErrorView(e, s, invalidate: referralCtrlProvider);
        },
        loading: Loader.list,
        data: (referral) {
          return Padding(
            padding: Insets.padH.copyWith(top: Insets.med),
            child: Column(
              children: [
                SearchField(
                  hint: TR.of(context).searchByName,
                  onSearch: (query) => referralCtrl().search(query),
                  onClear: () => referralCtrl().reload(),
                ),
                const Gap(Insets.lg),
                referral.deliveryMen.isEmpty
                    ? NoDataFound(topPadding: context.height / 5)
                    : ListView.builder(
                        itemCount: referral.deliveryMen.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: YourFriendCard(
                              data: referral.deliveryMen[index],
                            ),
                          ),
                        ),
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}
