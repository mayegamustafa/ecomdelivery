import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class WithdrawMethodCard extends StatelessWidget {
  const WithdrawMethodCard({
    super.key,
    required this.method,
    required this.isSelected,
    required this.onSelected,
  });

  final bool isSelected;
  final WithdrawMethod method;
  final Function(WithdrawMethod method) onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Insets.padH,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: Corners.medBorder,
          color: context.colorTheme.surface,
        ),
        child: GestureDetector(
          onTap: () => onSelected(method),
          child: DecoratedContainer(
            padding: Insets.padAll,
            borderRadius: Corners.med,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HostedImage.square(
                  method.image,
                  dimension: 60,
                ),
                const Gap(Insets.sm),
                Text(method.name),
                Text(
                  '${method.durationString} - ${method.currency.name}',
                ),
                const Spacer(),
                Radio<WithdrawMethod>(
                  value: method,
                  groupValue: isSelected ? method : null,
                  onChanged: (WithdrawMethod? value) {
                    if (value != null) {
                      onSelected(value);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
