import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class KListTile extends StatelessWidget {
  const KListTile({
    super.key,
    this.onTap,
    this.title,
    this.subtitle,
    this.trailing,
    this.leading,
  });

  final void Function()? onTap;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: context.colorTheme.surface,
        borderRadius: Corners.medBorder,
      ),
      padding: Insets.padH,
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        onTap: onTap,
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
      ),
    );
  }
}
