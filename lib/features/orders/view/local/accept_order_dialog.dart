import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AcceptOrderDialog extends HookConsumerWidget {
  const AcceptOrderDialog({
    super.key,
    required this.title,
    required this.onPressed,
    this.onCancel,
  });

  final String title;
  final Function(String note)? onPressed;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    return AlertDialog(
      actions: [
        Row(
          children: [
            Expanded(
              child: SubmitButton(
                onPressed: (l) => onCancel?.call(),
                child: Text(TR.of(context).no),
              ),
            ),
            const Gap(Insets.med),
            Expanded(
              child: SubmitButton(
                style: FilledButton.styleFrom(
                  backgroundColor: context.colorTheme.primary,
                ),
                onPressed: (l) async {
                  l.value = true;
                  await onPressed?.call(controller.text);
                  l.value = false;
                },
                child: Text(TR.of(context).accept),
              ),
            ),
          ],
        )
      ],
      content: SizedBox(
        width: context.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.icon.orderCancel.svg(height: 45),
            const Gap(Insets.lg),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.textTheme.titleLarge,
            ),
            const Gap(Insets.lg),
            FormBuilderTextField(
              name: 'note',
              controller: controller,
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                fillColor: context.colorTheme.surfaceBright.op(.05),
                hintText: TR.of(context).enterNote,
              ),
              validator: FormBuilderValidators.required(),
            ),
          ],
        ),
      ),
    );
  }
}
