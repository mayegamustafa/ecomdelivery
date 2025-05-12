import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class TransactionDetails extends ConsumerWidget {
  const TransactionDetails({
    super.key,
    required this.transactionData,
  });
  final TransactionData transactionData;
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
              value: transactionData.trxId,
            ),
            HText(
              title: TR.of(context).date,
              value: transactionData.date,
            ),
            HText(
              title: TR.of(context).postBalance,
              value: transactionData.postBalance.formate(),
            ),
            HText(
              title: TR.of(context).amount,
              value: transactionData.formattedAmount,
              color: transactionData.amountColor,
            ),
            HText(
              title: TR.of(context).time,
              value: transactionData.readableTime,
            ),
            HText(
              title: TR.of(context).details,
              value: transactionData.details,
            ),
            const Gap(Insets.offset),
          ],
        ),
      ),
    );
  }
}
