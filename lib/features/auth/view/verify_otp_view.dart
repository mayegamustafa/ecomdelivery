import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../auth/controller/password_reset_ctrl.dart';

class VerifyOtpView extends HookConsumerWidget {
  const VerifyOtpView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fieldKey = useMemoized(() => GlobalKey<FormBuilderTextState>());

    final resetCtrl =
        useCallback(() => ref.read(passwordResetCtrlProvider.notifier));

    return Scaffold(
      body: SingleChildScrollView(
        padding: Insets.padAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(Insets.offset),
            IconButton(
              onPressed: () => context.pop(),
              icon: Icon(
                Icons.arrow_back_rounded,
                color: context.colorTheme.primary,
              ),
            ),
            const Gap(Insets.offset),
            Text(
              TR.of(context).enterOtp,
              style: context.textTheme.titleLarge,
            ),
            const Gap(Insets.offset),
            FormBuilderTextField(
              key: fieldKey,
              name: 'code',
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: TR.of(context).enterOtpCode,
              ),
              validator: FormBuilderValidators.required(),
            ),
            const Gap(Insets.offset),
            SubmitButton(
              onPressed: (l) async {
                final state = fieldKey.currentState!;

                final value = state.value;
                if (!state.validate() || value == null) return;
                l.value = true;

                resetCtrl().copyWithMap({'code': value});

                final result = await resetCtrl().verifyOtp();

                l.value = false;

                if (!context.mounted) return;

                if (result) {
                  context.push(RoutePaths.resetPassword);
                }
              },
              child: Text(TR.of(context).submit),
            ),
          ],
        ),
      ),
    );
  }
}
