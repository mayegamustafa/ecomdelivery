import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'navigation.dart';

class NavButton extends HookWidget {
  const NavButton({
    super.key,
    required this.destination,
    required this.index,
    required this.onPressed,
    required this.selectedIndex,
  });

  final KNavDestination destination;
  final int index;
  final int selectedIndex;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: destination.focused
          ? const EdgeInsets.symmetric(horizontal: 15).copyWith(bottom: 10)
          : const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: destination.focused == true
          ? InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: onPressed,
              child: Container(
                height: 55,
                width: 55,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Color.fromARGB(255, 255, 120, 79),
                      Color.fromARGB(255, 255, 60, 0)
                    ],
                  ),
                ),
                alignment: Alignment.center,
                child: Assets.icon.home.svg(),
              ),
            )
          : MaterialButton(
              splashColor: context.colorTheme.scrim.withOpacity(.3),
              shape: const StadiumBorder(),
              height: double.maxFinite,
              padding: EdgeInsets.zero,
              onPressed: onPressed,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    selectedIndex == index
                        ? destination.selectedIcon
                        : destination.icon,
                    height: 25,
                    colorFilter: ColorFilter.mode(
                      selectedIndex == index
                          ? context.colorTheme.primary
                          : context.colorTheme.surfaceBright.withOpacity(.3),
                      BlendMode.srcIn,
                    ),
                  ),
                  if (destination.focused == false)
                    Text(
                      destination.text,
                      style: GoogleFonts.saira(
                        fontSize: 12,
                        // fontWeight: FontWeight.w800,
                        color: selectedIndex == index
                            ? context.colorTheme.primary
                            : context.colorTheme.surfaceBright.withOpacity(.7),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
