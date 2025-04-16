import 'dart:io';

import 'package:collection/collection.dart';
import 'package:delivery_boy/features/home/controller/home_ctrl.dart';
import 'package:delivery_boy/features/profile/controller/profile_ctrl.dart';
import 'package:delivery_boy/features/settings/controller/settings_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'map_view.dart';

class MyProfileView extends HookConsumerWidget {
  const MyProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeData = ref.watch(homeCtrlProvider);
    final countries =
        ref.watch(localSettingsCtrlProvider.select((v) => v?.countries ?? []));

    final file = useState<File?>(null);
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final profileCtrl =
        useCallback(() => ref.read(profileCtrlProvider.notifier));

    return Scaffold(
      appBar: KAppBar(
        leading: SquareButton.backButton(
          onPressed: () => context.pop(),
        ),
        title: Text(TR.of(context).myProfile),
      ),
      body: SingleChildScrollView(
        padding: Insets.padH,
        child: homeData.when(
            loading: Loader.list,
            error: (e, s) => ErrorView(e, s, invalidate: homeCtrlProvider),
            data: (home) {
              final self = home.deliveryMan;
              return FormBuilder(
                key: formKey,
                child: SeparatedColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  separatorBuilder: () => const Gap(Insets.sm),
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          if (file.value != null)
                            CircleAvatar(
                              radius: 60,
                              backgroundImage: FileImage(file.value!),
                            )
                          else
                            CircleImage(self.image, radius: 60),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () async {
                                file.value = await profileCtrl().picImage();
                              },
                              child: Assets.icon.cameraCircle.svg(height: 45),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(Insets.lg),
                    Row(
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                TR.of(context).firstName,
                                style: context.textTheme.bodyLarge,
                              ),
                              const Gap(Insets.sm),
                              FormBuilderTextField(
                                name: 'first_name',
                                initialValue: self.firstName,
                                decoration: InputDecoration(
                                  hintText: TR.of(context).enterFastName,
                                ),
                                validator: FormBuilderValidators.required(),
                              ),
                            ],
                          ),
                        ),
                        const Gap(Insets.med),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                TR.of(context).lastName,
                                style: context.textTheme.bodyLarge,
                              ),
                              const Gap(Insets.sm),
                              FormBuilderTextField(
                                name: 'last_name',
                                initialValue: self.lastName,
                                decoration: InputDecoration(
                                  hintText: TR.of(context).enterLastName,
                                ),
                                validator: FormBuilderValidators.required(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Gap(Insets.med),
                    Text(
                      TR.of(context).userName,
                      style: context.textTheme.bodyLarge,
                    ),
                    FormBuilderTextField(
                      name: 'username',
                      initialValue: self.username,
                      decoration: InputDecoration(
                        hintText: TR.of(context).enterUserName,
                      ),
                      validator: FormBuilderValidators.required(),
                    ),
                    const Gap(Insets.med),
                    Text(
                      TR.of(context).email,
                      style: context.textTheme.bodyLarge,
                    ),
                    FormBuilderTextField(
                      name: 'email',
                      initialValue: self.email,
                      decoration: InputDecoration(
                        hintText: TR.of(context).enterEmail,
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ]),
                    ),
                    const Gap(Insets.med),
                    Row(
                      children: [
                        Text(
                          TR.of(context).address,
                          style: context.textTheme.titleLarge,
                        ),
                        const Spacer(),
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            backgroundColor:
                                context.colorTheme.primary.withOpacity(.1),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AddressMapView(
                                onLocationSelect: (latLng, address, cc) {
                                  final state = formKey.currentState!;
                                  state.patchValue(
                                    {
                                      'address': address,
                                      if (latLng != null) ...{
                                        'latitude': '${latLng.latitude}',
                                        'longitude': '${latLng.longitude}',
                                      },
                                      if (cc != null) ...{
                                        'country_id': countries
                                            .firstWhereOrNull(
                                                (e) => e.code == cc)
                                            ?.id,
                                      },
                                    },
                                  );
                                },
                              ),
                            );
                          },
                          icon: const Icon(Icons.map_outlined),
                          label: Text(TR.of(context).selectLocation),
                        ),
                      ],
                    ),
                    const Gap(Insets.med),
                    Text(
                      TR.of(context).country,
                      style: context.textTheme.bodyLarge,
                    ),
                    FormBuilderDropField(
                      name: 'country_id',
                      initialValue: self.countryId,
                      hintText: TR.of(context).country,
                      itemCount: countries.length,
                      color: context.colorTheme.surface,
                      onChanged: (value) {},
                      itemBuilder: (context, index) {
                        final country = countries[index];
                        return DropdownMenuItem(
                          value: country.id,
                          child: Text(country.name),
                        );
                      },
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                    ),
                    const Gap(Insets.sm),
                    Text(
                      TR.of(context).fullAddress,
                      style: context.textTheme.bodyLarge,
                    ),
                    const Gap(Insets.sm),
                    FormBuilderTextField(
                      name: 'address',
                      initialValue: self.address.address,
                      decoration: InputDecoration(
                        hintText: TR.of(context).enterAddress,
                      ),
                      validator: FormBuilderValidators.required(),
                    ),
                    const Gap(Insets.med),
                    Visibility(
                      visible: false,
                      maintainState: true,
                      child: Row(
                        children: [
                          Flexible(
                            child: FormBuilderTextField(
                              name: 'latitude',
                              initialValue: self.address.latitude.toString(),
                              decoration: InputDecoration(
                                hintText: TR.of(context).latitude,
                              ),
                              validator: FormBuilderValidators.required(),
                            ),
                          ),
                          const Gap(Insets.med),
                          Flexible(
                            child: FormBuilderTextField(
                              name: 'longitude',
                              initialValue: self.address.longitude.toString(),
                              decoration: InputDecoration(
                                hintText: TR.of(context).longitude,
                              ),
                              validator: FormBuilderValidators.required(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(Insets.xl),
                    SubmitButton(
                      onPressed: (l) async {
                        final state = formKey.currentState!;
                        if (!state.saveAndValidate()) return;
                        l.value = true;
                        final image = file.value;
                        await profileCtrl().updateProfile(state.value, image);
                        l.value = false;
                      },
                      child: Text(TR.of(context).submit),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
