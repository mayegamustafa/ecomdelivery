import 'package:collection/collection.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';

class NewOrderTimeLine extends HookConsumerWidget {
  const NewOrderTimeLine({
    super.key,
    required this.orderStatus,
    required this.defStatus,
  });

  final List<OrderStatuses> orderStatus;
  final OrderStatuses defStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final existShipping = orderStatus.firstWhereOrNull((e) => e.deliveryStatusKey == 'shipped');
    final existConfirm = orderStatus.firstWhereOrNull((e) => e.deliveryStatusKey == 'confirmed');

    List<OrderStatuses> showingStatuses() {
      final confirmed = existConfirm ?? OrderStatuses.def('confirmed', '- - -');
      final shipped = existShipping ?? OrderStatuses.def('shipped', '- - -');

      return [defStatus, confirmed, shipped];
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: context.width / 1.5,
          child: FixedTimeline.tileBuilder(
            builder: TimelineTileBuilder.connected(
              itemCount: showingStatuses().length,
              connectorBuilder: (_, index, __) {
                return const SolidLineConnector(
                  color: Colors.grey,
                  thickness: 2.0,
                );
              },
              contentsAlign: ContentsAlign.reverse,
              oppositeContentsBuilder: (context, index) {
                final status = showingStatuses()[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'From',
                        style: context.textTheme.bodySmall!.textColor(
                          context.colorTheme.surfaceBright.op7,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        status.deliveryStatus,
                        style: context.textTheme.bodyLarge!.copyWith(color: context.colorTheme.surfaceBright),
                      ),
                    ],
                  ),
                );
              },
              contentsBuilder: (context, index) {
                final status = showingStatuses()[index];
                return Container(
                  padding: const EdgeInsets.only(right: 10),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        TR.of(context).time,
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: context.colorTheme.surfaceBright.withOpacity(.7),
                        ),
                      ),
                      Text(
                        status.createdAt,
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                );
              },
              indicatorBuilder: (_, index) {
                final isPassed = switch (orderStatus) {
                  List _ when index == 0 => true,
                  List<OrderStatuses> s when s.any((e) => e.isConfirmed && index == 1) => true,
                  List<OrderStatuses> s when s.any((e) => e.isShipped) => true,
                  _ => false
                };

                // final color = isPassed ? Colors.red : Colors.white;
                return isPassed
                    ? ColorFiltered(
                        colorFilter: ColorFilter.mode(context.colorTheme.primary, BlendMode.srcIn),
                        child: Assets.lottie.timelineLoader.lottie(height: 50))
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: context.colorTheme.primary.withOpacity(.1),
                        ),
                        padding: const EdgeInsets.all(5),
                        child: DotIndicator(color: context.colorTheme.onPrimary, size: 15),
                      );
              },
              itemExtent: 70,
            ),
          ),
        ),
      ],
    );
  }
}
