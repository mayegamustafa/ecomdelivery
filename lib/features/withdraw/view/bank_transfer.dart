import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';
import 'package:delivery_boy/routes/route_name.dart';

class BankTransferView extends HookConsumerWidget {
  const BankTransferView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBank = useState<String?>('Standard Bank');

    final List bank = [
      'Standard Bank',
    ];
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () => context.push(RoutePaths.addMethod),
              child: CircleAvatar(
                backgroundColor: context.colorTheme.surface,
                child: Assets.icon.edit.svg(),
              ),
            ),
          ),
        ],
        title:  Text(TR.of(context).bankInfo),
      ),
      body: Padding(
        padding: Insets.padH.copyWith(top: Insets.med),
        child: Column(
          children: [
            ListView.builder(
              itemCount: bank.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => SelectBank(
                svg: Assets.icon.bank.svg(),
                title: TR.of(context).standardBank,
                subTitle: '5638 2742 9482 ****',
                radio: Radio<String>(
                  value: bank[index],
                  groupValue: selectedBank.value,
                  onChanged: (value) {
                    selectedBank.value = value;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectBank extends StatelessWidget {
  const SelectBank({
    super.key,
    required this.title,
    required this.subTitle,
    required this.svg,
    this.onTap,
    this.radio,
  });
  final String title;
  final String subTitle;
  final Widget svg;
  final Function()? onTap;
  final Widget? radio;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: Corners.medBorder,
            border: Border.all(
              width: 1,
              color: context.colorTheme.surfaceBright.withOpacity(.1),
            )),
        child: Padding(
          padding: Insets.padAllContainer,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: Corners.medBorder,
                  color: context.colorTheme.surfaceBright.withOpacity(.1),
                ),
                child: Padding(
                  padding: Insets.padAllContainer,
                  child: svg,
                ),
              ),
              const Gap(Insets.med),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: context.textTheme.bodyLarge),
                  Text(
                    subTitle,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: context.colorTheme.surfaceBright.withOpacity(.7),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              radio ?? const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
