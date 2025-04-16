import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SwipeToDeliverButton extends HookWidget {
  const SwipeToDeliverButton({
    super.key,
    required this.beforeSwipe,
    this.afterSwipe = '',
    required this.svg,
    required this.onSwipe,
    required this.isDelivered,
  });

  final String beforeSwipe;
  final String afterSwipe;
  final Widget svg;
  final ValueNotifier<bool> isDelivered;
  final Function()? onSwipe;
  @override
  Widget build(BuildContext context) {
    final dragPosition = useState(0.0);

    useEffect(() {
      if (isDelivered.value) {
        dragPosition.value = context.width - 128;
      } else {
        dragPosition.value = 0;
      }
      return null;
    }, [isDelivered.value]);

    return Stack(
      children: [
        Container(
          width: context.width - 40,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          child: isDelivered.value
              ? Text(
                  afterSwipe,
                  style: context.textTheme.bodyMedium?.bold
                      .textColor(Colors.white),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Gap(Insets.offset),
                    RotatedBox(
                      quarterTurns: 3,
                      child: Assets.lottie.arrowDown.lottie(height: 40),
                    ),
                    const Gap(Insets.med),
                    Text(
                      beforeSwipe,
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: context.colorTheme.onPrimary,
                      ),
                    ),
                  ],
                ),
        ),
        AnimatedPositioned(
          duration: kThemeAnimationDuration,
          left: dragPosition.value,
          child: GestureDetector(
            onHorizontalDragStart: (_) => HapticFeedback.selectionClick(),
            onHorizontalDragUpdate: isDelivered.value
                ? null
                : (details) {
                    dragPosition.value += details.delta.dx;

                    if (dragPosition.value < 0) {
                      dragPosition.value = 0;
                    } else if (dragPosition.value > context.width - 128) {
                      dragPosition.value = context.width - 128;
                    }
                  },
            onHorizontalDragEnd: isDelivered.value
                ? null
                : (details) {
                    if (dragPosition.value > 200) {
                      isDelivered.value = true;
                      HapticFeedback.selectionClick();
                      onSwipe?.call();
                    } else {
                      dragPosition.value = 0;
                    }
                  },
            child: Container(
              width: 80,
              height: 55,
              margin: const EdgeInsets.all(3),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: context.colorTheme.primary,
                borderRadius: BorderRadius.circular(100),
              ),
              child: svg,
            ),
          ),
        ),
      ],
    );
  }
}
