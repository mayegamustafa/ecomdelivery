import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';

class HomeAppbar extends HookWidget {
  const HomeAppbar({
    super.key,
    required this.deliveryMan,
  });

  final DeliveryMan deliveryMan;

  @override
  Widget build(BuildContext context) {
    final srcCtrl = useTextEditingController();
    return DecoratedContainer(
      child: Padding(
        padding: Insets.padH.copyWith(top: 10),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => context.push(RoutePaths.myProfile),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: HostedImage(
                      deliveryMan.image,
                      height: 50,
                      width: 50,
                    ),
                  ),
                ),
                const Gap(Insets.med),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        deliveryMan.firstName,
                        style: context.textTheme.titleLarge,
                      ),
                      const Gap(Insets.sm),
                      Row(
                        children: [
                          Assets.icon.location.svg(),
                          const Gap(Insets.xs),
                          Flexible(
                            child: Text(
                              deliveryMan.address.address.showUntil(20),
                              maxLines: 1,
                              style: context.textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => context.push(RoutePaths.notification),
                  child: CircleAvatar(
                    child: Assets.icon.notification.svg(height: 20),
                  ),
                ),
              ],
            ),
            const Gap(Insets.lg),
            TextField(
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              controller: srcCtrl,
              decoration: InputDecoration(
                contentPadding: Insets.padSym(10, 25),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8),
                  child: CircleAvatar(
                    backgroundColor: context.colorTheme.primary,
                    child: Assets.icon.search.svg(
                      colorFilter: ColorFilter.mode(
                        context.colorTheme.onPrimary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ).clickable(
                    onTap: () {
                      final id = srcCtrl.text.trim();
                      if (id.isEmpty) return;

                      context.push(
                        RoutePaths.acceptOrder(id),
                      );
                    },
                  ),
                ),
                hintText: TR.of(context).enterTheTrackId,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
