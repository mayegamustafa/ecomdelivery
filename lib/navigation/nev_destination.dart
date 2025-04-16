class KNavDestination {
  KNavDestination({
    required this.text,
    required this.icon,
    required this.selectedIcon,
    this.focused = false,
    this.isDrawerButton = false,
  });

  final bool focused;
  final String icon;
  final bool isDrawerButton;
  final String selectedIcon;
  final String text;
}
