import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/routing.dart';
import 'package:flutter/material.dart';

class TicketListCard extends ConsumerWidget {
  const TicketListCard({
    super.key,
    required this.ticket,
  });
  final SupportTicket ticket;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final sellerData = ref.watch(sellerCtrlProvider);
    return Column(
      children: [
        const Gap(Insets.med),
        GestureDetector(
          onTap: () =>
              context.push(RoutePaths.adminTicket(ticket.ticketNumber)),
          child: Container(
            decoration: BoxDecoration(
              color: context.colorTheme.surface,
              borderRadius: Corners.medBorder,
            ),
            child: Padding(
              padding: Insets.padAllContainer,
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ticket.subject,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.titleLarge,
                          ),
                          Text(
                            ticket.humanReadableTime,
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: context.colorTheme.surfaceBright
                                  .withOpacity(.7),
                            ),
                          ),
                        ],
                      ),
                      const Gap(Insets.sm),
                      Row(
                        children: [
                          Text(
                            ticket.ticketNumber,
                            style: context.textTheme.bodyLarge!.copyWith(
                              color: context.colorTheme.primary,
                            ),
                          ),
                          const Gap(Insets.sm),
                          GestureDetector(
                            onTap: () => Clipper.copy(
                              ticket.ticketNumber,
                            ),
                            child: Assets.icon.copy.svg(
                              colorFilter: ColorFilter.mode(
                                context.colorTheme.primary,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Gap(Insets.med),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: Corners.smBorder,
                          color: ticket.status.color.withOpacity(.1),
                          border: Border.all(
                            width: 0,
                            color: ticket.status.color,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Text(
                            ticket.status.title,
                            style: context.textTheme.labelMedium!.copyWith(
                              color: ticket.status.color,
                            ),
                          ),
                        ),
                      ),
                      const Gap(Insets.med),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: Corners.smBorder,
                          color: ticket.priority.color.withOpacity(.1),
                          border: Border.all(
                            width: 0,
                            color: ticket.priority.color,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Text(
                            ticket.priority.title,
                            style: context.textTheme.labelMedium!.copyWith(
                              color: ticket.priority.color,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
