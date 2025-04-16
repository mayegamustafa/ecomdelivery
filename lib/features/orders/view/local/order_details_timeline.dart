import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';

class OrderDetailsTimeline extends StatelessWidget {
  const OrderDetailsTimeline({super.key, required this.order});
  final ProductOrder order;
  @override
  Widget build(BuildContext context) {
    List<Assign> actionsList = order.orderDeliveryInfo.timeLine!.getActionsAsList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: context.width / 1.2,
          child: FixedTimeline.tileBuilder(
            theme: TimelineThemeData(nodePosition: 0),
            builder: TimelineTileBuilder.connected(
              itemCount: actionsList.length,
              connectorBuilder: (_, index, __) {
                return const SolidLineConnector(
                  color: Colors.grey,
                  thickness: 2.0,
                );
              },
              contentsAlign: ContentsAlign.basic,
              connectionDirection: ConnectionDirection.after,
              addAutomaticKeepAlives: true,
              contentsBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (order.orderDeliveryInfo.timeLine != null)
                      Text(
                        actionsList[index].actionBy,
                        style: context.textTheme.bodyLarge,
                      ),
                    Text(
                      actionsList[index].time.formatDate('dd MMM yyyy'),
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: context.colorTheme.surfaceBright.withOpacity(.7),
                      ),
                    ),
                    Text(
                      actionsList[index].details,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: context.colorTheme.surfaceBright.withOpacity(.7),
                      ),
                    ),
                  ],
                ),
              ),
              indicatorBuilder: (_, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: context.colorTheme.primary.withOpacity(.2),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(5),
                    child: DotIndicator(
                      color: Colors.red,
                      size: 16,
                    ),
                  ),
                );
              },
              itemExtent: 80,
            ),
          ),
        ),
      ],
    );
  }
}
