import 'dart:io';

import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class ErrorView extends HookConsumerWidget {
  const ErrorView(
    this.error,
    this.stackTrace, {
    this.onReload,
    this.invalidate,
    super.key,
  });

  final Function()? onReload;
  final ProviderOrFamily? invalidate;
  final Object error;
  final StackTrace? stackTrace;

  Widget withSF() => Scaffold(body: this);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        Logger.ex(error, stackTrace, 'Error on ErrorView');
        return null;
      },
      const [],
    );
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: Insets.padSym(0, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 80,
                color: context.colorTheme.error,
              ),
              const Gap(Insets.med),
              Text(
                error.toString(),
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
              ),
              const Gap(Insets.lg),
              if (onReload != null || invalidate != null)
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(150, 50),
                  ),
                  onPressed: () async {
                    onReload?.call();
                    if (invalidate != null) ref.invalidate(invalidate!);
                  },
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Retry'),
                )
              else
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    fixedSize: const Size(150, 50),
                  ),
                  onPressed: () async {
                    exit(0);
                  },
                  icon: const Icon(Icons.exit_to_app),
                  label: const Text('Exit'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class Loader extends StatelessWidget {
  const Loader({this.widget, super.key});

  Widget withSF() => Scaffold(body: this);

  Loader.grid([int count = 5, int cross = 3, Key? key])
      : widget = _LoaderGrid(count, cross),
        super(key: key);

  Loader.list([int count = 5, double height = 50, Key? key])
      : widget = _LoaderList(count, height),
        super(key: key);

  Loader.shimmer(double? height, double? width, {super.key})
      : widget = _LoaderShimmer(height, width);

  Loader.fullScreen(bool useScaffold, {super.key, Widget Function()? builder})
      : widget = _FullScreenLoader(useScaffold: useScaffold, builder: builder);

  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    if (widget != null) return widget!;
    return Center(
      child: CircularProgressIndicator(
        color: context.colorTheme.primaryContainer,
      ),
    );
  }
}

class _LoaderShimmer extends Loader {
  const _LoaderShimmer([this.height, this.width]);

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: Corners.lgBorder,
      child: KShimmer.card(
        height: height,
        width: width,
        padding: EdgeInsets.zero,
      ),
    );
  }
}

class _LoaderGrid extends Loader {
  const _LoaderGrid(this.itemCount, this.crossCount);

  final int crossCount;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: Insets.med,
        crossAxisSpacing: Insets.med,
        crossAxisCount: crossCount,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return const _LoaderShimmer();
      },
    );
  }
}

class _LoaderList extends Loader {
  const _LoaderList(this.itemCount, this.height);

  final double height;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: itemCount,
      separatorBuilder: (context, index) => const Gap(Insets.med),
      itemBuilder: (context, index) => _LoaderShimmer(height, double.infinity),
    );
  }
}

class _FullScreenLoader extends Loader {
  const _FullScreenLoader({required this.useScaffold, this.builder});

  final bool useScaffold;
  final Widget Function()? builder;

  @override
  Widget build(BuildContext context) {
    Widget child = const Loader();
    if (builder != null) child = builder!();

    if (useScaffold) return Scaffold(body: child);
    return child;
  }
}

class NoDataFound extends ConsumerWidget {
  const NoDataFound({super.key, this.errorText, this.topPadding});
  final String? errorText;
  final double? topPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Gap(topPadding ?? Insets.sm),
        Assets.svg.noData.svg(),
        const Gap(Insets.lg),
        Text(
          errorText ?? TR.of(context).noDataFound,
          style: context.textTheme.titleLarge,
        ),
      ],
    );
  }
}
