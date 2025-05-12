import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pinput/pinput.dart';

class PinField extends HookWidget {
  const PinField({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onCompleted,
    this.onClipboardFound,
    this.autoFocus = false,
    this.focusNode,
    this.validators,
    this.name,
    this.fieldKey,
    this.obscureText = false,
  }) : _length = 4;

  const PinField.otp({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onCompleted,
    this.onClipboardFound,
    this.autoFocus = false,
    this.focusNode,
    this.validators,
    this.name,
    this.fieldKey,
    this.obscureText = false,
  }) : _length = 6;

  final TextEditingController? controller;
  final void Function(String value)? onChanged;
  final void Function(String value)? onSubmitted;
  final void Function(String value)? onCompleted;
  final void Function(String value)? onClipboardFound;
  final bool autoFocus;
  final bool obscureText;
  final int _length;
  final FocusNode? focusNode;
  final List<FormFieldValidator>? validators;
  final String? name;

  final GlobalKey<FormFieldState>? fieldKey;

  static const defName = 'pinField';

  @override
  Widget build(BuildContext context) {
    FocusNode node = useFocusNode();

    useEffect(
      () {
        if (autoFocus) {
          focusNode?.requestFocus();
          node.requestFocus();
        }
        return null;
      },
      const [],
    );

    final pinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: context.textTheme.titleMedium!.copyWith(
        color: context.colorTheme.onSurface,
      ),
      decoration: BoxDecoration(
        color: context.theme.inputDecorationTheme.fillColor,
        borderRadius: Corners.lgBorder,
        border: Border.all(
          color: context.colorTheme.primary,
          width: .7,
        ),
      ),
    );
    return FormBuilderField(
      key: fieldKey,
      name: name ?? defName,
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(
            errorText: 'Please Enter OTP',
          ),
          FormBuilderValidators.equalLength(
            _length,
            errorText: 'OTP NOT VALID',
          ),
          ...?validators,
        ],
      ),
      builder: (field) {
        final color = field.hasError
            ? context.colorTheme.error
            : context.colorTheme.primary;
        return InputDecorator(
          decoration: InputDecoration(
            filled: false,
            contentPadding: const EdgeInsets.only(top: 10.0, bottom: 0.0),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            error: field.errorText == null
                ? null
                : Center(
                    child: Text(
                      field.errorText!,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.colorTheme.error,
                      ),
                    ),
                  ),
          ),
          child: Pinput(
            focusNode: focusNode ?? node,
            obscureText: obscureText,
            controller: controller,
            onChanged: (v) {
              field.didChange(v);
              onChanged?.call(v);
            },
            onSubmitted: onSubmitted,
            onCompleted: onCompleted,
            onClipboardFound: onClipboardFound,
            length: _length,
            focusedPinTheme: pinTheme.copyBorderWith(
              border: Border.all(width: 1.3, color: color),
            ),
            defaultPinTheme: pinTheme.copyBorderWith(
              border: Border.all(width: .7, color: color),
            ),
            submittedPinTheme: pinTheme.copyBorderWith(
              border: Border.all(width: 1.3, color: color),
            ),
          ),
        );
      },
    );
  }
}
