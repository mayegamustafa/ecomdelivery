import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class FieldClearButton extends HookWidget {
  const FieldClearButton({
    super.key,
    required this.ctrl,
    this.onClear,
  });
  final TextEditingController ctrl;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final show = useListenable(ctrl).text.isNotEmpty;

    return Visibility(
      visible: show,
      child: IconButton(
        style: IconButton.styleFrom(
          foregroundColor: context.colorTheme.onSurface.op5,
        ),
        onPressed: () {
          ctrl.clear();
          onClear?.call();
        },
        icon: const Icon(Icons.close),
      ),
    );
  }
}

class FieldHelpText extends StatelessWidget {
  const FieldHelpText({
    super.key,
    required this.helpText,
    this.onClear,
  });

  final ValueNotifier<String?> helpText;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    if (helpText.value == null) return const SizedBox.shrink();
    return Row(
      children: [
        Expanded(
          child: Text(helpText.value!),
        ),
        const Icon(
          Icons.close_rounded,
          size: 18,
        ).clickable(
          onTap: () {
            helpText.value = null;
            onClear?.call();
          },
        ),
      ],
    );
  }
}
