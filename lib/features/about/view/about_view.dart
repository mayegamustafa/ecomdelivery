import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';

class AboutUsView extends ConsumerWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: KAppBar(
        leading: SquareButton.backButton(
          onPressed: () => context.pop(),
        ),
        title: Text(TR.of(context).aboutUs),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Insets.padH.copyWith(top: Insets.med),
          child: Column(
            children: [
              Text(
                TR.of(context).dontHesitateToContactUs,
                style: context.textTheme.bodyLarge!.copyWith(
                  color: context.colorTheme.surfaceBright.withOpacity(.7),
                ),
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
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor:
                            context.colorTheme.primary.withOpacity(.05),
                      ),
                      const Gap(Insets.med),
                      Text(
                        TR.of(context).callUs,
                        style: context.textTheme.bodyLarge,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
