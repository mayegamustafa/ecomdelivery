import 'package:delivery_boy/features/orders/controller/orders_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class RejectDialog extends HookConsumerWidget {
  const RejectDialog({
    super.key,
    required this.orderId,
  });
  final String orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    final orderCtrl = useCallback(
      () => ref.read(orderCtrlProvider(orderId).notifier),
      [ref],
    );

    return AlertDialog(
      content: SizedBox(
        height: context.height / 2.5,
        width: context.width,
        child: Column(
          children: [
            const Gap(Insets.lg),
            Assets.icon.orderCancel.svg(),
            const Gap(Insets.lg),
            Text(
              TR.of(context).areYouSureToRejectThisOrder,
              textAlign: TextAlign.center,
              style: context.textTheme.headlineSmall,
            ),
            const Gap(Insets.lg),
            TextFormField(
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
                fillColor: context.colorTheme.surfaceBright.withOpacity(
                  .05,
                ),
                hintText: TR.of(context).enterNote,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: SubmitButton(
                    onPressed: (l) => Navigator.pop(context),
                    child: Text(TR.of(context).no),
                  ),
                ),
                const Gap(Insets.med),
                Expanded(
                  child: SubmitButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        context.colorTheme.primary,
                      ),
                    ),
                    onPressed: (l) async {
                      l.value = true;
                      await orderCtrl().requestOrder(
                        id: orderId,
                        status: '2',
                        note: controller.text,
                      );
                      l.value = false;
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: Text(TR.of(context).reject),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
