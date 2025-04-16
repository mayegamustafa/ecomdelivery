import 'package:delivery_boy/features/region/controller/region_ctrl.dart';
import 'package:delivery_boy/features/settings/controller/settings_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';

class CurrencyView extends HookConsumerWidget {
  const CurrencyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currency = ref.watch(regionCtrlProvider.select((v) => v.currency));
    final currencies =
        ref.watch(localSettingsCtrlProvider.select((v) => v?.currencies ?? []));

    return Scaffold(
      appBar: KAppBar(
        leading: SquareButton.backButton(
          onPressed: () => context.pop(),
        ),
        title: Text(TR.of(context).currency),
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            ref.read(appSettingsCtrlProvider.notifier).reload(),
        child: SingleChildScrollView(
          padding: Insets.padAll,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: currencies.length,
                itemBuilder: (context, index) {
                  final cur = currencies[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: Corners.medBorder,
                        color: context.colorTheme.surface,
                      ),
                      child: RadioListTile(
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: Text(
                          cur.name,
                          style: context.textTheme.titleLarge,
                        ),
                        value: cur.uid,
                        groupValue: currency?.uid,
                        onChanged: (value) {
                          if (value != null) {
                            ref
                                .read(regionCtrlProvider.notifier)
                                .setCurrency(cur);
                          }
                        },
                      ),
                    ),
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
