import 'package:delivery_boy/features/settings/controller/settings_ctrl.dart';
import 'package:delivery_boy/features/support_ticket/controller/ticket_massage_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/routing.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CreateTicketView extends HookConsumerWidget {
  const CreateTicketView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormBuilderState>.new);
    final ticketData = ref.watch(ticketCreateCtrlProvider);
    final createTicket =
        useCallback(() => ref.watch(ticketCreateCtrlProvider.notifier));
    final priority = ref.watch(localSettingsCtrlProvider
        .select((v) => v?.config.ticketPriority.enumData.entries.toList()));

    return Scaffold(
      appBar: KAppBar(
        title: Text(TR.of(context).createTicket),
        leading: SquareButton.backButton(
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: Insets.padAll,
                child: FormBuilder(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            TR.of(context).subject,
                            style: context.textTheme.bodyLarge,
                          ).markAsRequired(),
                          const Gap(Insets.sm),
                          FormBuilderTextField(
                            name: 'subject',
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: TR.of(context).enterSubject,
                            ),
                            validator: FormBuilderValidators.required(),
                          ),
                          const Gap(Insets.med),
                          Text(
                            TR.of(context).message,
                            style: context.textTheme.bodyLarge,
                          ).markAsRequired(),
                          const Gap(Insets.sm),
                          FormBuilderTextField(
                            name: 'message',
                            keyboardType: TextInputType.multiline,
                            validator: FormBuilderValidators.required(),
                            textInputAction: TextInputAction.newline,
                            maxLines: 4,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: Corners.medBorder,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: Corners.medBorder,
                                borderSide: BorderSide(
                                  color: context.colorTheme.primary,
                                ),
                              ),
                              hintText: TR.of(context).enterMessage,
                              alignLabelWithHint: true,
                            ),
                          ),
                          const Gap(Insets.med),
                          Text(
                            TR.of(context).priority,
                            style: context.textTheme.bodyLarge,
                          ).markAsRequired(),
                          const Gap(Insets.sm),
                          if (priority != null)
                            FormBuilderDropField<String>(
                              name: 'priority',
                              hintText: TR.of(context).selectPriority,
                              itemCount: priority.length,
                              color: context.colorTheme.surface,
                              itemBuilder: (context, index) {
                                final pri = priority[index];
                                return DropdownMenuItem(
                                  value: pri.value.toString(),
                                  child: Text(pri.key),
                                );
                              },
                              validators: [
                                FormBuilderValidators.required(),
                              ],
                            ),
                          const Gap(Insets.lg),
                          GestureDetector(
                            onTap: () {
                              createTicket().pickFiles();
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: context.colorTheme.surface,
                                borderRadius: Corners.medBorder,
                              ),
                              child: Padding(
                                padding: Insets.padAllContainer,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: Corners.medBorder,
                                        color: context.colorTheme.surfaceBright
                                            .withOpacity(.05),
                                      ),
                                      child: Padding(
                                        padding: Insets.padAllContainer,
                                        child: Assets.icon.upload.svg(),
                                      ),
                                    ),
                                    const Gap(Insets.lg),
                                    Text(
                                      TR.of(context).uploadAFile,
                                      style: context.textTheme.titleLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: ticketData.files.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: Corners.medBorder,
                              color: context.colorTheme.surface,
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.file_present_rounded,
                                size: 30,
                                color: context.colorTheme.secondaryContainer,
                              ),
                              title: Text(
                                ticketData.files[index].path.split('/').last,
                              ),
                              trailing: IconButton(
                                style: IconButton.styleFrom(
                                  foregroundColor: context.colorTheme.error,
                                ),
                                onPressed: () =>
                                    createTicket().removeFile(index),
                                icon: const Icon(Icons.clear_rounded),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: context.colorTheme.surface,
            width: double.infinity,
            child: Padding(
              padding: Insets.padAll,
              child: SubmitButton(
                onPressed: (isLoading) async {
                  final state = formKey.currentState!;
                  if (!state.saveAndValidate()) return;
                  createTicket().setTicketInfo(state.value);
                  final id = await createTicket().createTicket();
                  state.reset();
                  if (id != null && context.mounted) {
                    context.push(RoutePaths.adminTicket(id));
                  }
                },
                child: Text(TR.of(context).submit),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
