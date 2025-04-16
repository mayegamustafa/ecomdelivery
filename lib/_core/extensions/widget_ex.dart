import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

extension TestWiEx on Text {
  Widget markAsRequired([bool isRequired = true]) {
    return Builder(
      builder: (context) {
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: data,
                style: style,
              ),
              if (isRequired)
                TextSpan(
                  text: '*',
                  style: (style ?? context.textTheme.bodyMedium)?.copyWith(
                    color: context.colorTheme.error,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget get fit => FittedBox(child: this);
  Widget copyable([bool copyOnTap = false]) => clickable(
        onTap: copyOnTap ? () => Clipper.copy(data) : null,
        onLongPress: !copyOnTap ? () => Clipper.copy(data) : null,
      );
}

extension WidgetEx on Widget {
  Widget clickable({void Function()? onTap, void Function()? onLongPress}) {
    return GestureDetector(onTap: onTap, onLongPress: onLongPress, child: this);
  }

  Widget conditionalExpanded(bool condition, [int flex = 1]) =>
      condition ? Expanded(flex: flex, child: this) : this;
}

extension ColorEX on Color {
  Color op(double opacity) => withOpacity(opacity);
  Color get op1 => op(.1);
  Color get op2 => op(.2);
  Color get op3 => op(.3);
  Color get op4 => op(.4);
  Color get op5 => op(.5);
  Color get op6 => op(.6);
  Color get op7 => op(.7);
  Color get op8 => op(.8);
  Color get op9 => op(.9);
}

extension MaterialStateSet on Set<WidgetState> {
  bool get isHovered => contains(WidgetState.hovered);
  bool get isFocused => contains(WidgetState.focused);
  bool get isPressed => contains(WidgetState.pressed);
  bool get isDragged => contains(WidgetState.dragged);
  bool get isSelected => contains(WidgetState.selected);
  bool get isScrolledUnder => contains(WidgetState.scrolledUnder);
  bool get isDisabled => contains(WidgetState.disabled);
  bool get isError => contains(WidgetState.error);
}
