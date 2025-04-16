import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class WithdrawDetails extends ConsumerWidget {
  const WithdrawDetails({
    super.key,
    required this.withdrawData,
  });
  final WithdrawData withdrawData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: context.height / 3,
      child: Padding(
        padding: Insets.padH,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Gap(Insets.lg),
            HText(
              title: TR.of(context).transactionId,
              value: withdrawData.trxNo,
            ),
            HText(
              title: TR.of(context).date,
              value: withdrawData.date,
            ),
            HText(
              title: TR.of(context).amount,
              value: withdrawData.amount.formate(),
              color: withdrawData.statusColor,
            ),
            HText(
              title: TR.of(context).time,
              value: withdrawData.readableTime,
            ),
            HText(
              title: TR.of(context).details,
              value: withdrawData.feedback,
            ),
            const Gap(Insets.offset),
          ],
        ),
      ),
    );
  }
}
