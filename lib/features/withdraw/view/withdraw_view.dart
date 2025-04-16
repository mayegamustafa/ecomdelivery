import 'package:delivery_boy/features/home/controller/home_ctrl.dart';
import 'package:delivery_boy/features/wallet/controller/withdraw_ctrl.dart';
import 'package:delivery_boy/features/wallet/view/local/select_method_sheet.dart';
import 'package:delivery_boy/features/wallet/view/local/withdraw_confirm_dialog.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class WithdrawView extends HookConsumerWidget {
  const WithdrawView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = useState<WithdrawMethod?>(null);
    final formKey = useMemoized(GlobalKey<FormBuilderState>.new);

    Future<bool> request(QMap data) async {
      final ctrl = ref.read(withdrawCtrlProvider.notifier);
      return await ctrl.request('${selected.value!.id}', data['amount']);
    }

    final amount = useState(0);
    final controller = useTextEditingController();

    // Function to update the text field and amount state
    void updateAmount(int newAmount) {
      amount.value = newAmount;
      controller.text = newAmount.toString();
    }

    final balance = ref.watch(
      localHomeCtrlProvider.select((c) => c?.deliveryMan.balance ?? 0),
    );

    return Scaffold(
      appBar: KAppBar(
        leading: SquareButton.backButton(
          onPressed: () => context.pop(),
        ),
        title: Text(TR.of(context).withdraw),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: SubmitButton(
          padding: Insets.padAll,
          icon: Assets.icon.withdrawSwift.svg(height: 20),
          onPressed: (l) async {
            if (selected.value == null) {
              Toaster.showError(TR.of(context).pleaseSelectAMethod);
              return;
            }
            final state = formKey.currentState!;
            if (!state.saveAndValidate()) return;
            l.value = true;
            final data = state.value.nonNull();

            final isOk = await request(data);

            l.value = false;
            if (!context.mounted || !isOk) return;

            await showDialog(
              context: context,
              builder: (ctx) {
                return WithdrawConfirmDialog(formData: data);
              },
            );
          },
          child: Text(TR.of(context).withdraw),
        ),
      ),
      body: FormBuilder(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: Insets.padH.copyWith(top: Insets.med),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: Corners.medBorder,
                        color: context.colorTheme.primary,
                      ),
                      padding: Insets.padAllContainer,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            TR.of(context).balance,
                            style: context.textTheme.bodyLarge!.copyWith(
                              color: context.colorTheme.onPrimary,
                            ),
                          ),
                          Text(
                            balance.formate(),
                            style: context.textTheme.titleLarge!.copyWith(
                              color: context.colorTheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(Insets.lg),
                    Text(
                      TR.of(context).amount,
                      style: context.textTheme.titleLarge,
                    ),
                    const Gap(Insets.med),
                    FormBuilderTextField(
                      name: 'amount',
                      controller: controller,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.number,
                      validator: FormBuilderValidators.required(),
                      decoration: InputDecoration(
                        hintText: TR.of(context).enterAmount,
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        suffixIcon: SizedBox(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      updateAmount(amount.value + 1);
                                    },
                                    child: const Icon(
                                      Icons.keyboard_arrow_up_rounded,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (amount.value > 0) {
                                        updateAmount(amount.value - 1);
                                      }
                                    },
                                    child: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                              Container(
                                decoration: BoxDecoration(
                                  color: context.colorTheme.primary,
                                  borderRadius: Corners.medBorder,
                                ),
                                padding: const EdgeInsets.all(12),
                                child: Icon(
                                  Icons.attach_money,
                                  color: context.colorTheme.onPrimary,
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        if (value != null && value.isNotEmpty) {
                          amount.value = int.parse(value);
                        }
                      },
                    ),
                    const Gap(Insets.lg),
                    Text(
                      TR.of(context).withdrawTo,
                      style: context.textTheme.titleLarge,
                    ),
                    const Gap(Insets.lg),
                    if (selected.value == null)
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: Corners.medBorder,
                          color: context.colorTheme.surface,
                        ),
                        padding: Insets.padAllContainer,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: Corners.medBorder,
                                color: context.colorTheme.surfaceBright
                                    .withOpacity(.05),
                              ),
                              padding: Insets.padAllContainer,
                              child: Assets.icon.bank.svg(),
                            ),
                            const Gap(Insets.med),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  TR.of(context).withdrawMethod,
                                  style: context.textTheme.bodyLarge,
                                ),
                                Text(
                                  TR.of(context).select,
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    color: context.colorTheme.surfaceBright.op7,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  builder: (_) => SelectMethodSheet(
                                    onSelected: (method) {
                                      selected.value = method;
                                      formKey.currentState?.reset();
                                      context.nPop();
                                    },
                                    isSelected: (m) =>
                                        m.id == selected.value?.id,
                                  ),
                                );
                              },
                              child: Text(TR.of(context).change),
                            ),
                          ],
                        ),
                      )
                    else
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: Corners.medBorder,
                          color: context.colorTheme.surface,
                        ),
                        child: Padding(
                          padding: Insets.padAll,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HostedImage(
                                selected.value!.image,
                                height: 40,
                              ),
                              const Gap(Insets.med),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      selected.value!.name,
                                      style: context.textTheme.bodyLarge,
                                    ),
                                    Text(
                                      '${TR.of(context).charge}: ${selected.value!.chargeString}',
                                    ),
                                    Text(
                                        '${TR.of(context).range}: ${selected.value!.limit}'),
                                    Text(
                                      '${TR.of(context).duration} ${selected.value!.durationString}',
                                    ),
                                    const Gap(Insets.sm),
                                    Html(
                                      data: selected.value!.description,
                                      shrinkWrap: true,
                                      style: {'*': Style(margin: Margins.zero)},
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () => showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  builder: (_) => SelectMethodSheet(
                                    onSelected: (method) {
                                      selected.value = method;
                                      formKey.currentState?.reset();
                                      context.nPop();
                                    },
                                    isSelected: (m) =>
                                        m.id == selected.value?.id,
                                  ),
                                ),
                                child: Text(TR.of(context).change),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const Gap(Insets.lg),
                    if (selected.value?.customInputs != null) ...[
                      Text(
                        TR.of(context).note,
                        style: context.textTheme.bodyLarge,
                      ),
                      const Gap(Insets.med),
                      _CustomInputFields(
                        inputs: selected.value!.customInputs,
                        key: ValueKey(selected.value!.id),
                      ),
                    ],
                    const Gap(Insets.lg),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomInputFields extends StatelessWidget {
  const _CustomInputFields({
    super.key,
    required this.inputs,
  });

  final List<CustomInput> inputs;

  @override
  Widget build(BuildContext context) {
    return SeparatedColumn(
      separatorBuilder: () => const Gap(Insets.lg),
      children: [
        for (var input in inputs)
          FormBuilderTextField(
            name: input.name,
            onTapOutside: hideSoftKeyboard(),
            textInputAction: input.isTextArea()
                ? TextInputAction.newline
                : TextInputAction.next,
            maxLines: input.isTextArea() ? 3 : 1,
            decoration: InputDecoration(
              labelText: input.label,
              alignLabelWithHint: true,
              border: const OutlineInputBorder(
                borderRadius: Corners.medBorder,
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: Corners.medBorder,
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: Corners.medBorder,
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: Corners.medBorder,
              ),
            ),
            validator: input.required ? FormBuilderValidators.required() : null,
          ),
      ],
    );
  }
}
