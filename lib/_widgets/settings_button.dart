import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../main.export.dart';

class SettingButton extends StatelessWidget {
  const SettingButton({
    super.key,
    this.route,
    required this.icon,
    required this.title,
    this.isActive = false,
    this.showSwitch = false,
    this.onChanged,
    this.onTap,
    this.color,
    this.colorFilter,
    this.iconSize,
  });

  final String? route;
  final String icon;
  final String title;
  final bool showSwitch;
  final bool isActive;
  final Function(bool)? onChanged;
  final Function()? onTap;
  final ColorFilter? colorFilter;
  final Color? color;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Insets.med),
      child: GestureDetector(
        onTap: route == null ? onTap : () => context.push(route!),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: Corners.medBorder,
            border: Border.all(
              width: 1,
              color: context.colorTheme.surfaceBright.withOpacity(.1),
            ),
          ),
          child: Padding(
            padding: Insets.padAllContainer,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: color?.withOpacity(.05) ??
                      context.colorTheme.primary.withOpacity(.05),
                  child: SvgPicture.asset(
                    icon,
                    colorFilter: colorFilter,
                    height: iconSize,
                  ),
                ),
                const Gap(Insets.med),
                Text(
                  title,
                  style: context.textTheme.bodyLarge,
                ),
                const Spacer(),
                if (showSwitch)
                  Switch(
                    value: isActive,
                    onChanged: onChanged,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
