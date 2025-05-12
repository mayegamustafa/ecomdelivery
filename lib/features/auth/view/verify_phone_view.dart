import 'package:country_code_picker/country_code_picker.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../auth/controller/password_reset_ctrl.dart';

class VerifyPhoneView extends HookConsumerWidget {
  const VerifyPhoneView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final resetCtrl =
        useCallback(() => ref.read(passwordResetCtrlProvider.notifier));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FormBuilder(
          key: formKey,
          child: SingleChildScrollView(
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
                  TR.of(context).resetPassword,
                  style: context.textTheme.headlineMedium,
                ),
                const Gap(Insets.sm),
                Text(
                  TR.of(context).resetPassword,
                  style: context.textTheme.bodyLarge,
                ),
                const Gap(Insets.offset),
                Text(
                  TR.of(context).phone,
                  style: context.textTheme.bodyLarge,
                ),
                const Gap(Insets.med),
                Row(
                  children: [
                    FormBuilderField<String>(
                      name: 'phone_code',
                      builder: (state) => Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: Corners.medBorder,
                          border: Border.all(
                            width: 0,
                            color: context.colorTheme.onSurface.withOpacity(.5),
                          ),
                        ),
                        child: CountryCodePicker(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 0,
                          ),
                          initialSelection: 'bd',
                          onInit: (value) {
                            Future.delayed(
                              0.seconds,
                              () => state.didChange(
                                value?.dialCode?.replaceAll('+', ''),
                              ),
                            );
                          },
                          flagDecoration: const BoxDecoration(
                            borderRadius: Corners.smBorder,
                          ),
                          onChanged: (code) {
                            state.didChange(code.dialCode?.replaceAll('+', ''));
                          },
                        ),
                      ),
                    ),
                    const Gap(Insets.sm),
                    Expanded(
                      child: FormBuilderTextField(
                        name: 'phone',
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          hintText: TR.of(context).enterYourPhoneNumber,
                        ),
                        validator: FormBuilderValidators.required(),
                      ),
                    ),
                  ],
                ),
                const Gap(Insets.offset),
                SubmitButton(
                  onPressed: (l) async {
                    final state = formKey.currentState!;

                    if (!state.saveAndValidate()) return;
                    final value = state.value;

                    l.value = true;
                    resetCtrl().copyWithMap(value);
                    final result = await resetCtrl().verifyPhone();
                    l.value = false;

                    if (!context.mounted) return;

                    if (result) {
                      context.push(RoutePaths.verifyOtp);
                    }
                  },
                  child: Text(TR.of(context).submit),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
