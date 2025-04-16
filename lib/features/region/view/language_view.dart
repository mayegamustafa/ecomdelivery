import 'package:collection/collection.dart';
import 'package:delivery_boy/features/settings/controller/settings_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';

import '../controller/region_ctrl.dart';

class LanguageView extends HookConsumerWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languages = ref.watch(
        localSettingsCtrlProvider.select((value) => value?.languages ?? []));

    Widget getLeading(String code) {
      final selected = languages.firstWhereOrNull((e) => e.code == code);
      if (selected != null) return CircleImage(selected.image, radius: 20);

      return CircleAvatar(
        radius: 20,
        backgroundColor: context.colorTheme.primary,
        child: Text(
          code.toUpperCase(),
          style: context.textTheme.titleLarge!.copyWith(
            color: context.colorTheme.primary,
          ),
        ),
      );
    }

    String getName(String code) {
      final selected = languages.firstWhereOrNull((e) => e.code == code);
      if (selected != null) return selected.name;
      return code.toUpperCase();
    }

    final activeLocale = ref.watch(localeProvider);

    return Scaffold(
      appBar: KAppBar(
        leading: SquareButton.backButton(
          onPressed: () => context.pop(),
        ),
        title: Text(TR.of(context).language),
      ),
      body: SingleChildScrollView(
        padding: Insets.padAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: TR.delegate.supportedLocales.length,
              itemBuilder: (context, index) {
                final locale = TR.delegate.supportedLocales[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: Corners.medBorder,
                      color: context.colorTheme.surface,
                    ),
                    child: Padding(
                      padding: Insets.padAllContainer,
                      child: Row(
                        children: [
                          getLeading(locale.languageCode),
                          const SizedBox(width: 16),
                          Text(
                            getName(locale.languageCode),
                            style: context.textTheme.titleLarge,
                          ),
                          const Spacer(),
                          Radio<Locale>(
                            value: locale,
                            groupValue: activeLocale,
                            onChanged: (value) {
                              if (value.isNotNullOrEmpty()) {
                                ref
                                    .read(regionCtrlProvider.notifier)
                                    .setLanguage(locale.languageCode);

                                ref
                                    .read(localeProvider.notifier)
                                    .setLocale(locale);
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
