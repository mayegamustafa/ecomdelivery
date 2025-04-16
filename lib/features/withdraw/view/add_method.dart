import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';
import 'package:delivery_boy/routes/route_name.dart';

class AddMethodView extends HookConsumerWidget {
  const AddMethodView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: GestureDetector(
            onTap: () => context.pop(),
            child: CircleAvatar(
              backgroundColor: context.colorTheme.surface,
              child: Assets.icon.arrowLeft.svg(
                height: 30,
                colorFilter: ColorFilter.mode(
                  context.colorTheme.surfaceBright,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
        title: Text(TR.of(context).editInfo),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: Insets.padH.copyWith(top: Insets.med),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    TR.of(context).cardholderName,
                    style: context.textTheme.bodyLarge,
                  ),
                  const Gap(Insets.med),
                  FormBuilderTextField(
                    name: 'name',
                    decoration: InputDecoration(
                      hintText: TR.of(context).enterYourNameAsWrittenOnCard,
                    ),
                  ),
                  const Gap(Insets.lg),
                  Text(
                    TR.of(context).cardNumber,
                    style: context.textTheme.bodyLarge,
                  ),
                  const Gap(Insets.med),
                  FormBuilderTextField(
                    name: 'name',
                    decoration: InputDecoration(
                      hintText: TR.of(context).enterCardNumber,
                    ),
                  ),
                  const Gap(Insets.lg),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              TR.of(context).cvvcvc,
                              style: context.textTheme.bodyLarge,
                            ),
                            const Gap(Insets.med),
                            FormBuilderTextField(
                              name: 'name',
                              decoration: const InputDecoration(
                                hintText: '123',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(Insets.lg),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              TR.of(context).expiryDate,
                              style: context.textTheme.bodyLarge,
                            ),
                            const Gap(Insets.med),
                            FormBuilderTextField(
                              name: 'name',
                              decoration: const InputDecoration(
                                hintText: '2020',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Gap(Insets.lg),
                ],
              ),
            ),
          ),
          Padding(
            padding: Insets.padH.copyWith(bottom: Insets.med),
            child: SubmitButton(
              onPressed: (l) {},
              child: Text(TR.of(context).saveChanges),
            ),
          ),
        ],
      ),
    );
  }
}
