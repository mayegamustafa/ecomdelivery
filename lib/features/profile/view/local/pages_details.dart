import 'package:delivery_boy/features/settings/controller/settings_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PagesDetailsView extends ConsumerWidget {
  const PagesDetailsView(this.id, {super.key});
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pages =
        ref.watch(localSettingsCtrlProvider.select((e) => e?.pages.data));
    final page = pages?.firstWhere((e) => e.uid == id);
    if (page == null) {
      return const ErrorView('Page not found', null).withSF();
    }
    return Scaffold(
      appBar: KAppBar(
        leading: SquareButton.backButton(
          onPressed: () => context.pop(),
        ),
        title: Text(page.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Insets.padH,
          child: Html(
            data: page.description,
            style: {
              "*": Style(
                fontSize: FontSize(16),
                lineHeight: const LineHeight(1.6),
                fontWeight: FontWeight.w400,
                color: context.colorTheme.onSurface,
                backgroundColor: context.isLight
                    ? const Color(0xffF5F5F5)
                    : const Color(0xFF191B24),
              ),
            },
          ),
        ),
      ),
    );
  }
}
