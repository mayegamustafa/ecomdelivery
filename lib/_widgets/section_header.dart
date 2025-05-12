import 'package:delivery_boy/_core/_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SectionHeader extends HookConsumerWidget {
  const SectionHeader({
    super.key,
    required this.title,
    required this.seeAll,
    this.icon,
    this.borderColor,
    this.fillColor,
    required this.onTap,
  });
  final String title;
  final String seeAll;
  final IconData? icon;
  final Color? borderColor;
  final Color? fillColor;
  final Function() onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> list = ['last 7 day', 'last 15 Day', 'last 1 month'];
    final selectedValue = useState<String?>(null);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: Corners.smBorder,
              border: Border.all(
                width: 0,
                color: borderColor ?? Colors.transparent,
              ),
              color: fillColor,
            ),
            child: DropdownButton<String>(
              value: selectedValue.value,
              elevation: 16,
              style: TextStyle(color: context.colorTheme.primary),
              onChanged: (String? value) {
                selectedValue.value = value;
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: context.textTheme.bodyLarge!
                        .copyWith(color: context.colorTheme.primary),
                  ),
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }
}
