import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:delivery_boy/features/chat/view/customer/customer_chat_tab.dart';
import 'package:delivery_boy/features/chat/view/delivery/delivery_chat_tab.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class ChatsTabView extends HookConsumerWidget {
  const ChatsTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: KAppBar(
        title: Text(TR.of(context).chat),
      ),
      body: Padding(
        padding: Insets.padH.copyWith(top: Insets.med),
        child: DefaultTabController(
          length: 2,
          child: Stack(
            children: [
              SegmentedTabControl(
                selectedTabTextColor: context.colorTheme.onPrimary,
                textStyle: context.textTheme.bodyLarge,
                indicatorPadding: const EdgeInsets.all(3),
                tabTextColor: context.colorTheme.surfaceBright,
                indicatorDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: context.colorTheme.primary,
                ),
                barDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: context.colorTheme.surface,
                ),
                tabs: [
                  SegmentTab(
                    label: TR.of(context).customerChat,
                  ),
                  SegmentTab(
                    label: TR.of(context).deliverymanChat,
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 65),
                child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    CustomerChatTab(),
                    DeliveryChatTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
