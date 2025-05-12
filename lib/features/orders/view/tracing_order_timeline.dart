import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';

class TractOrderTimeline extends StatelessWidget {
  const TractOrderTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: context.width / 1.2,
          // height: 500,
          child: FixedTimeline.tileBuilder(
            theme: TimelineThemeData(nodePosition: 0),
            builder: TimelineTileBuilder.connected(
              itemCount: 2,
              connectorBuilder: (_, index, __) {
                return const SolidLineConnector(
                  color: Colors.grey,
                  thickness: 2.0,
                );
              },
              contentsAlign: ContentsAlign.basic,
              connectionDirection: ConnectionDirection.after,
              addAutomaticKeepAlives: true,
              contentsBuilder: (context, index) => const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'tractTimelineModel[index].title',
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        Text(
                          'tractTimelineModel[index].subtitle',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          'tractTimelineModel[index].date',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              indicatorBuilder: (_, index) {
                if (index == 0) {
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
                } else {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(.2),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: DotIndicator(
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  );
                }
              },
              itemExtent: 80,
            ),
          ),
        ),
      ],
    );
  }
}
