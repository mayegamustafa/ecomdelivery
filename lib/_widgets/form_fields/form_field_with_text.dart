import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class TextFieldWithHeader extends StatelessWidget {
  const TextFieldWithHeader({
    super.key,
    required this.title,
    required this.name,
    required this.hintText,
    this.isRequired,
    this.obscureText,
  });
  final String title;
  final String name;
  final String hintText;
  final bool? isRequired;
  final ValueNotifier<bool>? obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: title, style: context.textTheme.bodyLarge),
              if (isRequired == true)
                TextSpan(
                  text: '*',
                  style: context.textTheme.bodyLarge!
                      .copyWith(color: context.colorTheme.error),
                ),
            ],
          ),
        ),
        const Gap(Insets.med),
        FormBuilderTextField(
          name: name,
          obscureText: obscureText?.value ?? false,
          decoration: InputDecoration(
            fillColor: context.colorTheme.surfaceBright.withOpacity(.05),
            filled: true,
            hintText: hintText,
            suffixIcon: obscureText == null
                ? null
                : IconButton(
                    onPressed: () => obscureText?.value = !obscureText!.value,
                    icon: Icon(
                      obscureText!.value
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                    ),
                  ),
          ),
        ),
        const Gap(Insets.lg),
      ],
    );
  }
}
