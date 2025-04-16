import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/navigation/nev_destination.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';

import 'nav_button.dart';

class NavigationRoot extends HookConsumerWidget {
  const NavigationRoot(this.child, {super.key});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rootPath = GoRouterState.of(context).uri.pathSegments.first;
    final int getIndex = RoutePaths.navRoutes.indexOf('/$rootPath');

    final index = useState(0);
    final showDrawer = useState(false);

    useEffect(() {
      index.value = getIndex;
      return null;
    }, [rootPath]);

    return GestureDetector(
      onTap: () => showDrawer.value = false,
      child: SizedBox(
        height: context.height,
        width: context.width,
        child: Scaffold(
          body: child,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              color: context.isDark
                  ? context.colorTheme.primaryContainer
                  : context.colorTheme.surface,
              border: Border.all(
                width: 2,
                color: context.colorTheme.surface.withOpacity(.05),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: context.isDark ? 0 : 20,
                  color: context.colorTheme.onSurface.withOpacity(.08),
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: NavigationBar(
              backgroundColor: Colors.transparent,
              destinations: [
                for (var i = 0; i < _destinations().length; i++)
                  NavButton(
                    destination: _destinations()[i],
                    index: i,
                    selectedIndex: index.value,
                    onPressed: () {
                      index.value = i;
                      context.push(RoutePaths.navRoutes[i]);
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<KNavDestination> _destinations() => [
        KNavDestination(
          text: 'Home',
          selectedIcon: Assets.icon.home.path,
          icon: Assets.icon.home.path,
        ),
        KNavDestination(
          text: 'Analytics',
          selectedIcon: Assets.icon.analytics.path,
          icon: Assets.icon.analytics.path,
        ),
        KNavDestination(
          text: 'Chat',
          selectedIcon: Assets.icon.massage.path,
          icon: Assets.icon.massage.path,
        ),
        KNavDestination(
          text: 'History',
          selectedIcon: Assets.icon.history.path,
          icon: Assets.icon.history.path,
        ),
        KNavDestination(
          text: 'Profile',
          selectedIcon: Assets.icon.profile.path,
          icon: Assets.icon.profile.path,
          isDrawerButton: true,
        ),
      ];
}
