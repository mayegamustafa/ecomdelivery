import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class HomeLoader extends StatelessWidget {
  const HomeLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: Insets.padH,
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: KShimmer.card(
                  height: 50,
                  width: 50,
                ),
              ),
              const Gap(Insets.med),
              KShimmer.card(
                height: 50,
                width: 200,
              ),
              const Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: KShimmer.card(
                  height: 50,
                  width: 50,
                ),
              ),
            ],
          ),
          const Gap(Insets.lg),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: KShimmer.card(
              height: 50,
              width: double.infinity,
            ),
          ),
          const Gap(Insets.lg),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: ClipRRect(
                  borderRadius: Corners.medBorder,
                  child: KShimmer.card(
                    height: 150,
                    width: 150,
                  ),
                ),
              ),
            ),
          ),
          const Gap(Insets.lg),
          ClipRRect(
            borderRadius: Corners.medBorder,
            child: KShimmer.card(
              height: 40,
              width: double.infinity,
            ),
          ),
          const Gap(Insets.med),
          ClipRRect(
            borderRadius: Corners.medBorder,
            child: KShimmer.card(
              height: 70,
              width: double.infinity,
            ),
          ),
          const Gap(Insets.med),
          ClipRRect(
            borderRadius: Corners.medBorder,
            child: KShimmer.card(
              height: 70,
              width: double.infinity,
            ),
          ),
          const Gap(Insets.xl),
          ClipRRect(
            borderRadius: Corners.medBorder,
            child: KShimmer.card(
              height: 40,
              width: double.infinity,
            ),
          ),
          const Gap(Insets.med),
          ClipRRect(
            borderRadius: Corners.medBorder,
            child: KShimmer.card(
              height: 200,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
