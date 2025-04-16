import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../auth/controller/password_reset_ctrl.dart';

class ResetPasswordView extends HookConsumerWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final resetCtrl =
        useCallback(() => ref.read(passwordResetCtrlProvider.notifier));
    final hidePass1 = useState(true);
    final hidePass2 = useState(true);

    return Scaffold(
      body: SingleChildScrollView(
        padding: Insets.padAll,
        child: FormBuilder(
          key: formKey,
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
                TR.of(context).updatePassword,
                style: context.textTheme.titleLarge,
              ),
              const Gap(Insets.offset),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    TR.of(context).newPassword,
                    style: context.textTheme.bodyLarge,
                  ),
                  const Gap(Insets.med),
                  FormBuilderTextField(
                    name: 'password',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    obscureText: hidePass1.value,
                    decoration: InputDecoration(
                      hintText: TR.of(context).enterNewPassword,
                      suffixIcon: IconButton(
                        onPressed: () => hidePass1.value = !hidePass1.value,
                        icon: Icon(hidePass1.value
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                    validator: FormBuilderValidators.required(),
                  ),
                  const Gap(Insets.xl),
                  Text(
                    TR.of(context).confirmPassword,
                    style: context.textTheme.bodyLarge,
                  ),
                  const Gap(Insets.med),
                  FormBuilderTextField(
                    name: 'password_confirmation',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    obscureText: hidePass2.value,
                    decoration: InputDecoration(
                      hintText: TR.of(context).enterYourConfirmPassword,
                      suffixIcon: IconButton(
                        onPressed: () => hidePass2.value = !hidePass2.value,
                        icon: Icon(hidePass2.value
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                    validator: FormBuilderValidators.required(),
                  ),
                ],
              ),
              const Gap(Insets.offset),
              SubmitButton(
                onPressed: (l) async {
                  final state = formKey.currentState!;
                  if (!state.saveAndValidate()) return;

                  l.value = true;
                  resetCtrl().copyWithMap(state.value);

                  final result = await resetCtrl().resetPass();
                  l.value = false;

                  if (!context.mounted) return;

                  if (result) {
                    context.push(RoutePaths.login);
                  }
                },
                child: Text(TR.of(context).submit),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
