import 'dart:io';

import 'package:delivery_boy/features/auth/controller/auth_ctrl.dart';
import 'package:delivery_boy/features/home/controller/home_ctrl.dart';
import 'package:delivery_boy/features/kyc/controller/kyc_ctrl.dart';
import 'package:delivery_boy/features/kyc/view/kyc_logs_view.dart';
import 'package:delivery_boy/features/settings/controller/settings_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'kyc_view.dart';

class VerifyKYCView extends HookConsumerWidget {
  const VerifyKYCView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSettings = ref.watch(appSettingsCtrlProvider);
    final formKey = useMemoized(GlobalKey<FormBuilderState>.new);

    final kycCtrl = useCallback(() => ref.read(kycCtrlProvider.notifier));

    useEffect(
      () {
        Future.delayed(0.seconds, () {
          Toaster.showError(TR.of(context).applyForKycVerification);
        });
        return null;
      },
      const [],
    );

    return Scaffold(
      appBar: KAppBar(
        title: Text(TR.of(context).verifyKyc),
        actions: [
          IconButton.outlined(
            style: IconButton.styleFrom(
              foregroundColor: context.colorTheme.onSurface,
            ),
            onPressed: () {
              context.nPush(const KYCLogsView());
            },
            icon: const Icon(Icons.receipt_long_rounded),
            tooltip: TR.of(context).kycLogs,
          ),
          IconButton.outlined(
            style: IconButton.styleFrom(
              foregroundColor: context.colorTheme.onSurface,
            ),
            onPressed: () {
              ref.read(authCtrlProvider.notifier).logout(false);
            },
            icon: const Icon(Icons.logout_outlined),
            tooltip: TR.of(context).logout,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(appSettingsCtrlProvider),
        child: SingleChildScrollView(
          padding: Insets.padAll,
          child: appSettings.when(
            loading: () => Loader.list(),
            error: (e, s) => ErrorView(e, s),
            data: (settings) {
              final kycConfig = settings.kycConfig;

              return FormBuilder(
                key: formKey,
                child: SeparatedColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  separatorBuilder: () => const Gap(Insets.med),
                  children: [
                    for (var field in kycConfig)
                      if (field.type == KYCType.file)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              field.labels,
                              style: context.textTheme.titleMedium?.bold,
                            ).markAsRequired(field.isRequired),
                            FormBuilderField<File>(
                              name: field.name,
                              validator: FormBuilderValidators.compose(
                                [
                                  if (field.isRequired)
                                    FormBuilderValidators.required(),
                                ],
                              ),
                              builder: (state) {
                                final value = state.value;
                                return Row(
                                  children: [
                                    Expanded(
                                      child: DecoratedContainer(
                                        color: context.theme
                                            .inputDecorationTheme.fillColor,
                                        borderRadius: Corners.med,
                                        height: 50,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        child: value == null
                                            ? Text(
                                                field.placeholder,
                                                style: context
                                                    .textTheme.bodyMedium,
                                              )
                                            : Text(
                                                value.path.split('/').last,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                      ),
                                    ),
                                    if (field.type == KYCType.file) ...[
                                      const Gap(Insets.sm),
                                      IconButton.outlined(
                                        onPressed: () async {
                                          final file =
                                              await locate<FilePickerRepo>()
                                                  .pickFile(
                                                      type: FileType.image);

                                          file.fold(
                                            (l) {},
                                            (r) => state.didChange(r),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.add_photo_alternate_outlined,
                                        ),
                                      ),
                                    ],
                                  ],
                                );
                              },
                            ),
                          ],
                        )
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              field.labels,
                              style: context.textTheme.titleMedium?.bold,
                            ).markAsRequired(field.isRequired),
                            const Gap(Insets.sm),
                            Row(
                              children: [
                                Flexible(
                                  child: FormBuilderTextField(
                                    name: field.name,
                                    textInputAction: field.type.input.action,
                                    keyboardType: field.type.input.type,
                                    maxLines: field.type.maxLines,
                                    onTapOutside: (_) => hideSoftKeyboard(),
                                    validator: FormBuilderValidators.compose(
                                      [
                                        if (field.isRequired)
                                          FormBuilderValidators.required(),
                                      ],
                                    ),
                                    decoration: InputDecoration(
                                      hintText: field.placeholder,
                                      border: field.type == KYCType.textarea
                                          ? OutlineInputBorder(
                                              borderRadius: Corners.medBorder,
                                              borderSide: BorderSide(
                                                color:
                                                    context.colorTheme.primary,
                                                width: .07,
                                              ),
                                            )
                                          : null,
                                      enabledBorder: field.type ==
                                              KYCType.textarea
                                          ? const OutlineInputBorder(
                                              borderRadius: Corners.medBorder,
                                              borderSide: BorderSide.none,
                                            )
                                          : null,
                                      errorBorder: field.type ==
                                              KYCType.textarea
                                          ? OutlineInputBorder(
                                              borderRadius: Corners.medBorder,
                                              borderSide: BorderSide(
                                                color:
                                                    context.colorTheme.primary,
                                              ),
                                            )
                                          : null,
                                    ),
                                  ),
                                ),
                                if (field.type == KYCType.date) ...[
                                  const Gap(Insets.sm),
                                  IconButton.outlined(
                                    onPressed: () async {
                                      final date = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1950),
                                        lastDate: DateTime.now().add(29.days),
                                      );
                                      formKey.currentState?.fields[field.name]
                                          ?.didChange(date?.formatDate());
                                    },
                                    icon: const Icon(
                                      Icons.calendar_month_rounded,
                                    ),
                                  ),
                                ]
                              ],
                            ),
                          ],
                        ),
                    const Gap(Insets.lg),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                            style: OutlinedButton.styleFrom(
                              fixedSize: const Size.fromHeight(50),
                              backgroundColor: context.colorTheme.surface,
                              foregroundColor: context.colorTheme.onSurface,
                              side: const BorderSide(width: 2),
                            ),
                            onPressed: () async {
                              final test = ref.refresh(homeCtrlProvider);

                              test.maybeWhen(
                                data: (d) => ref
                                    .read(serverStatusProvider.notifier)
                                    .update(200),
                                orElse: () => Toaster.showError(
                                    TR.of(context).kycNotVerified),
                              );
                            },
                            child: Text(TR.of(context).goToHome),
                          ),
                        ),
                        const Gap(Insets.sm),
                        Expanded(
                          child: SubmitButton(
                            onPressed: (l) async {
                              final state = formKey.currentState!;
                              if (!state.saveAndValidate()) return;

                              l.value = true;

                              final values = state.value;

                              Map<String, File> files = {};
                              Map<String, String> data = {};

                              for (var MapEntry(:key, :value)
                                  in values.entries) {
                                if (value is File) {
                                  files[key] = value;
                                } else {
                                  data[key] = value.toString();
                                }
                              }

                              final kyc =
                                  await kycCtrl().submitKYC(data, files);
                              l.value = false;

                              if (!context.mounted || kyc == null) return;
                              context.nPush(KYCView(kyc));
                            },
                            child: Text(TR.of(context).submit),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
