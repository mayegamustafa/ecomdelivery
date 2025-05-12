import 'package:delivery_boy/features/settings/controller/settings_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';

class SupportView extends HookConsumerWidget {
  const SupportView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expandedIndex = useState<int?>(null);

    final faq = ref
        .watch(localSettingsCtrlProvider.select((value) => value?.faq ?? []));

    return Scaffold(
      appBar: KAppBar(
        title: Text(TR.of(context).helpSupportTicket),
        leading: SquareButton.backButton(
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Insets.padH.copyWith(top: Insets.med),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => context.push(RoutePaths.adminTickets),
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colorTheme.surface,
                    borderRadius: Corners.medBorder,
                  ),
                  child: Padding(
                    padding: Insets.padAllContainer,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: Corners.medBorder,
                            color: context.colorTheme.surfaceBright
                                .withOpacity(.05),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Assets.icon.support.svg(),
                          ),
                        ),
                        const Gap(Insets.med),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              TR.of(context).createTicket,
                              style: context.textTheme.bodyLarge,
                            ),
                            Text(
                              TR.of(context).messageYourProblem,
                              style: context.textTheme.bodyMedium!.copyWith(
                                color: context.colorTheme.surfaceBright
                                    .withOpacity(.7),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ),
              ),
              const Gap(Insets.lg),
              Text(
                TR.of(context).frequentQuestion,
                style: context.textTheme.titleLarge,
              ),
              const Gap(Insets.lg),
              ListView.builder(
                itemCount: faq.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final que = faq[index].question;
                  final answer = faq[index].answer;
                  final isExpanded = expandedIndex.value == index;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: Corners.medBorder,
                        color: context.colorTheme.surface,
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          dividerColor: Colors.transparent,
                        ),
                        child: ExpansionTile(
                          childrenPadding: Insets.padAllContainer,
                          trailing: Icon(isExpanded ? Icons.remove : Icons.add),
                          onExpansionChanged: (bool expanded) {
                            expandedIndex.value = expanded ? index : null;
                          },
                          title: Text('${index + 1}. $que'),
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                answer,
                                textAlign: TextAlign.start,
                                style: context.textTheme.bodyLarge!.copyWith(
                                  color: context.colorTheme.surfaceBright
                                      .withOpacity(.7),
                                ),
                              ),
                            ),
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
      ),
    );
  }
}
