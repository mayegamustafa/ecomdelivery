import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class AnimatedBottomSheet extends HookWidget {
  const AnimatedBottomSheet({
    super.key,
    required this.child,
    this.hight,
  });

  final Widget child;
  final double? hight;

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );

    final slideAnimation = useMemoized(
      () => Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.easeOut,
        ),
      ),
      [animationController],
    );

    useEffect(() {
      animationController.forward();
      return null;
    }, [animationController]);

    return SlideTransition(
      position: slideAnimation,
      child: Container(
        height: hight ?? 280,
        decoration: const BoxDecoration(
          // color: context.colorTheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: Insets.padH,
        child: child,
      ),
    );
  }
}
