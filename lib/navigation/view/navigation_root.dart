// import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// import 'package:delivery_boy/_core/_core.dart';
// import 'package:delivery_boy/routes/route_name.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class NavigationRoot extends HookConsumerWidget {
//   const NavigationRoot({required this.child, super.key});
//   final Widget child;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final navIndex = useState(0);
//     final route = GoRouterState.of(context).uri.toString().split('/');

//     final onDestinationChange = useCallback(
//       (int index) {
//         context.push(RoutePaths.navRoutes[index]);
//         navIndex.value = index;
//       },
//       [navIndex.value],
//     );

//     final show = route.length == 2;
//     return Scaffold(
//       body: child,
//       floatingActionButton: show
//           ? FloatingActionButton(
//               backgroundColor: context.colorTheme.primary,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(100),
//               ),
//               child: const Icon(
//                 Icons.chat_bubble_outline_rounded,
//               ),
//               onPressed: () {
//                 context.push(RoutePaths.messages);
//               },
//               //params
//             )
//           : null,
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: show
//           ? AnimatedBottomNavigationBar(
//               icons: const [
//                 Icons.home_outlined,
//                 Icons.pending_actions,
//                 Icons.poll_outlined,
//                 Icons.person_outline_outlined,
//               ],
//               activeColor: context.colorTheme.primary,
//               activeIndex: navIndex.value,
//               gapLocation: GapLocation.center,
//               notchSmoothness: NotchSmoothness.softEdge,
//               onTap: onDestinationChange,
//             )
//           : null,
//     );
//   }
// }
