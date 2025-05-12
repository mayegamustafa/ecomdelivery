import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../main.export.dart';

class FormBuilderDropField<T> extends StatelessWidget {
  const FormBuilderDropField({
    super.key,
    required this.name,
    required this.itemCount,
    required this.itemBuilder,
    this.initialValue,
    this.hintText,
    this.validators,
    this.onChanged,
    this.onSaved,
    this.bottom,
    this.headerText,
    this.isRequired = false,
    this.searchMatchFn,
    this.color,
  });

  final void Function(T? value)? onChanged;
  final void Function(T? value)? onSaved;
  final Widget? Function()? bottom;
  final String? headerText;
  final String? hintText;
  final T? initialValue;
  final DropdownMenuItem<T> Function(BuildContext context, int index)
      itemBuilder;
  final int? itemCount;
  final String name;
  final List<FormFieldValidator<T>>? validators;
  final bool isRequired;
  final bool Function(DropdownMenuItem<T> item, String searchValue)?
      searchMatchFn;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<T>(
      name: name,
      initialValue: initialValue,
      onChanged: onChanged,
      onSaved: onSaved,
      validator: FormBuilderValidators.compose(validators ?? []),
      builder: (state) => DropDownField<T>(
        hintText: hintText,
        itemCount: itemCount,
        itemBuilder: itemBuilder,
        onChanged: (value) => state.didChange(value),
        errorText: state.errorText,
        value: state.value,
        bottom: bottom,
        headerText: headerText,
        isRequired: isRequired,
        searchMatchFn: searchMatchFn,
        color: color,
      ),
    );
  }
}

class DropDownField<T> extends HookWidget {
  const DropDownField({
    super.key,
    required this.hintText,
    required this.itemCount,
    required this.itemBuilder,
    this.value,
    this.onChanged,
    this.errorText,
    this.headerText,
    this.bottom,
    this.isRequired = false,
    this.searchMatchFn,
    this.color,
  });

  final void Function(T? value)? onChanged;
  final Widget? Function()? bottom;
  final String? errorText;
  final String? headerText;
  final String? hintText;
  final DropdownMenuItem<T> Function(BuildContext context, int index)
      itemBuilder;
  final int? itemCount;
  final T? value;
  final bool isRequired;
  final bool Function(DropdownMenuItem<T> item, String searchValue)?
      searchMatchFn;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final bottomWidget = bottom?.call();
    final isSearch = searchMatchFn != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (headerText != null) ...[
          Text(
            headerText!,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ).markAsRequired(isRequired),
          const Gap(Insets.sm),
        ],
        DropdownButtonFormField2<T>(
          isExpanded: true,
          value: value,
          decoration: InputDecoration(
            errorText: errorText,
            hintText: hintText,
            contentPadding: EdgeInsets.zero,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: const BorderSide(
                color: Color.fromARGB(0, 42, 41, 41),
              ),
            ),
            fillColor: color ?? context.colorTheme.onPrimary,
            // filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: context.colorTheme.primary,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
          ),
          hint: hintText != null ? Text(hintText!) : null,
          onChanged: onChanged,
          items: [
            for (int i = 0; i < (itemCount ?? 0); i++) itemBuilder(context, i),
          ],
          dropdownSearchData: DropdownSearchData(
            searchController: isSearch ? controller : null,
            searchMatchFn: searchMatchFn,
            searchInnerWidget: Padding(
              padding: Insets.padH.copyWith(top: 10),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Search Here',
                    fillColor:
                        context.colorTheme.surfaceBright.withOpacity(.05)),
                controller: controller,
              ),
            ),
            searchInnerWidgetHeight: 50,
          ),
        ),
        if (bottomWidget != null) ...[
          bottomWidget,
        ]
      ],
    );
  }
}
