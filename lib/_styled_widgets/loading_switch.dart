import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class LoadingSwitch extends HookWidget {
  const LoadingSwitch({
    super.key,
    required this.value,
    required this.onChange,
  });

  final bool value;
  final dynamic Function(bool v) onChange;

  @override
  Widget build(BuildContext context) {
    final v = useState(value);
    return Switch(
      value: v.value,
      onChanged: (value) {
        v.value = value;
        onChange(value);
      },
    );
  }
}
