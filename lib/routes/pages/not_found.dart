import 'package:delivery_boy/_core/_core.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound(this.path, {super.key});

  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '404',
              style: context.textTheme.headlineSmall,
            ),
            const Gap(Insets.sm),
            Text(
              TR.of(context).NotFound,
              style: context.textTheme.bodyMedium,
            ),
            const Gap(Insets.sm),
            Text(path),
            const Gap(Insets.med),
            ElevatedButton(
              onPressed: () => context.go(RoutePaths.home),
              child: Text(TR.of(context).goHome),
            ),
          ],
        ),
      ),
    );
  }
}
