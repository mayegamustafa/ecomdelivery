import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../controller/auth_ctrl.dart';

class ChangePassView extends HookConsumerWidget {
  const ChangePassView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final hideOld = useState(true);
    final hideNow = useState(true);
    final hideConfirm = useState(true);
    final newPass = useState('');

    return Scaffold(
      appBar: KAppBar(
        leading: SquareButton.backButton(
          onPressed: () => context.pop(),
        ),
        title: Text(TR.of(context).changePassword),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: FormBuilder(
                key: formKey,
                child: Container(
                  padding: Insets.padAll,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(Insets.lg),
                      Text(
                        TR.of(context).currentPassword,
                        style: context.textTheme.labelLarge,
                      ),
                      const Gap(Insets.med),
                      FormBuilderTextField(
                        name: 'current_password',
                        textInputAction: TextInputAction.next,
                        obscureText: hideOld.value,
                        decoration: InputDecoration(
                          hintText: TR.of(context).enterCurrentPassword,
                          suffixIcon: IconButton(
                            onPressed: () => hideOld.value = !hideOld.value,
                            icon: hideOld.value
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          ),
                        ),
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.minLength(6),
                          ],
                        ),
                      ),
                      const Gap(Insets.lg),
                      Text(
                        TR.of(context).newPassword,
                        style: context.textTheme.labelLarge,
                      ),
                      const Gap(Insets.med),
                      FormBuilderTextField(
                        name: 'password',
                        obscureText: hideNow.value,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) => newPass.value = value ?? '',
                        decoration: InputDecoration(
                          hintText: TR.of(context).enterNewPassword,
                          suffixIcon: IconButton(
                            onPressed: () => hideNow.value = !hideNow.value,
                            icon: hideNow.value
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          ),
                        ),
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.minLength(6),
                          ],
                        ),
                      ),
                      const Gap(Insets.lg),
                      Text(
                        TR.of(context).confirmPassword,
                        style: context.textTheme.labelLarge,
                      ),
                      const Gap(Insets.med),
                      FormBuilderTextField(
                        name: 'password_confirmation',
                        obscureText: hideConfirm.value,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          hintText: TR.of(context).reenterNewPassword,
                          suffixIcon: IconButton(
                            onPressed: () =>
                                hideConfirm.value = !hideConfirm.value,
                            icon: hideConfirm.value
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          ),
                        ),
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.minLength(6),
                            FormBuilderValidators.equal(
                              newPass.value,
                              errorText: TR.of(context).notMatch,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: Insets.padH.copyWith(bottom: 10),
            child: SubmitButton(
              width: context.width,
              onPressed: (l) async {
                final state = formKey.currentState!;
                if (!state.saveAndValidate()) return;

                l.value = true;
                await ref
                    .read(authCtrlProvider.notifier)
                    .updatePassword(state.value);
                l.value = false;
                state.reset();
              },
              child: Text(TR.of(context).saveChanges),
            ),
          ),
        ],
      ),
    );
  }
}
