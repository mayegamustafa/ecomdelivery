import 'package:delivery_boy/features/home/controller/home_ctrl.dart';
import 'package:delivery_boy/features/my_review/controller/my_review_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';

class MyReviewView extends HookConsumerWidget {
  const MyReviewView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewData = ref.watch(myReviewCtrlProvider);
    final reviewCtrl =
        useCallback(() => ref.read(myReviewCtrlProvider.notifier));
    return Scaffold(
      appBar: KAppBar(
        leading: SquareButton.backButton(
          onPressed: () => context.pop(),
        ),
        title: Text(TR.of(context).reviews),
      ),
      body: RefreshIndicator(
        onRefresh: () async => reviewCtrl().reload(),
        child: Padding(
          padding: Insets.padAll,
          child: reviewData.when(
            error: (e, s) => ErrorView(e, s, invalidate: homeCtrlProvider),
            loading: () => Loader.list(),
            data: (reviews) {
              return ListViewWithFooter(
                emptyListWidget: const NoDataFound(),
                itemCount: reviews.length,
                physics: const AlwaysScrollableScrollPhysics(),
                pagination: reviews.pagination,
                onNext: (u) => reviewCtrl().fromUrl(u),
                onPrevious: (u) => reviewCtrl().fromUrl(u),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ReviewCard(
                    review: reviews[index],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.review,
  });
  final DeliveryManReview review;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: Corners.medBorder,
        color: context.colorTheme.surface,
      ),
      child: Padding(
        padding: Insets.padAllContainer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${review.orderNumber}',
                  style: context.textTheme.bodyLarge,
                ),
                Text(
                  review.createdAt,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.colorTheme.surfaceBright.withOpacity(.6),
                  ),
                ),
              ],
            ),
            const Gap(Insets.med),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 18,
                        child: Row(
                          children: [
                            ListView.builder(
                              itemCount: review.rating.toInt(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 18,
                              ),
                            ),
                            const Gap(Insets.sm),
                            Text(
                              '(${review.rating})',
                            )
                          ],
                        ),
                      ),
                      const Gap(Insets.med),
                      Text(
                        review.message,
                        style: context.textTheme.bodyMedium!.copyWith(
                          color:
                              context.colorTheme.surfaceBright.withOpacity(.7),
                        ),
                      ),
                      const Gap(Insets.sm),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
