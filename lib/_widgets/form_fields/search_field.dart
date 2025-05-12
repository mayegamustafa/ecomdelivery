import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SearchField extends HookConsumerWidget {
  const SearchField({
    super.key,
    this.onSearch,
    this.onRangeSearch,
    this.onClear,
    this.hint,
    this.autoSearch = false,
    this.fillColor,
  });

  final void Function(String query)? onSearch;
  final dynamic Function(DateTimeRange? range)? onRangeSearch;
  final VoidCallback? onClear;
  final String? hint;
  final bool autoSearch;
  final Color? fillColor;

  @override
  Widget build(BuildContext context, ref) {
    final srcCtrl = useTextEditingController();
    final helpText = useState<String?>(null);

    return Row(
      children: [
        Flexible(
          child: TextField(
            onChanged: autoSearch ? onSearch : null,
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            controller: srcCtrl,
            onSubmitted: (value) => onSearch?.call(value),
            decoration: InputDecoration(
              fillColor: fillColor,
              hintText: hint ?? TR.of(context).searchByTrxId,
              helper: FieldHelpText(
                helpText: helpText,
                onClear: onClear,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: Assets.icon.search.svg(),
              ),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FieldClearButton(
                    ctrl: srcCtrl,
                    onClear: onClear,
                  ),
                  GestureDetector(
                    onTap: () {
                      onSearch?.call(srcCtrl.text);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: CircleAvatar(
                        backgroundColor: context.colorTheme.primary,
                        child: Assets.icon.search.svg(
                          colorFilter: ColorFilter.mode(
                            context.colorTheme.onPrimary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (onRangeSearch != null)
          IconButton(
            onPressed: () async {
              final date = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime.now().add(30.days),
              );

              if (date == null) return;

              helpText.value =
                  'Searching: ${date.start.formatDate()} - ${date.end.formatDate()}';

              await onRangeSearch?.call(date);
            },
            icon: Assets.icon.filterLines.svg(),
          ),
      ],
    );
  }
}
