import 'package:delivery_boy/features/auth/controller/auth_ctrl.dart';
import 'package:delivery_boy/features/settings/controller/settings_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

Future<void> _initFirebase() async {
  await FireMessage.initiateWithFirebase();
  LNService.initialize();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await preloadSVGs(Assets.svg.values.map((v) => v.path).toList());

  await initServices();

  ///* To enable FIREBASE, change the value to true;
  FireMessage.isFireActive = true;
  await _initFirebase();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    useEffect(() {
      return null;
    }, [locale]);

    return _EagerInitialization(
      child: RefreshConfiguration(
        headerBuilder: () => const WaterDropHeader(),
        footerBuilder: () => const ClassicFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
          loadingText: '',
          noDataText: 'No more messages',
        ),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: AppDefaults.appName,
          themeMode: mode,
          theme: AppTheme.theme(true),
          darkTheme: AppTheme.theme(false),
          routerConfig: ref.watch(routerProvider),
          locale: locale,
          supportedLocales: TR.delegate.supportedLocales,
          localizationsDelegates: const [
            TR.delegate,
            RefreshLocalizations.delegate,
            FormBuilderLocalizations.delegate,
            ...GlobalMaterialLocalizations.delegates,
          ],
        ),
      ),
    );
  }
}

class _EagerInitialization extends HookConsumerWidget {
  const _EagerInitialization({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //!
    ref.watch(appSettingsCtrlProvider);
    ref.watch(localSettingsCtrlProvider);
    //!

    ref.listen(
      unAuthEventProvider,
      (_, v) => v.maybeWhen(
        orElse: () {},
        data: (_) => ref.read(authCtrlProvider.notifier).logout(),
      ),
    );
    ref.listen(
      serverEventProvider,
      (_, v) => v.maybeWhen(
        orElse: () {},
        data: (e) {
          final statusCtrl = ref.read(serverStatusProvider.notifier);
          statusCtrl.update(e.code);
        },
      ),
    );

    useEffect(
      () {
        Future.delayed(
          0.seconds,
          () {
            // locate<LocalDB>().clear();
            ref.read(localeProvider.notifier).setFromCode(Intl.getCurrentLocale());
          },
        );

        return null;
      },
      const [],
    );

    return child;
  }
}

final unAuthEventProvider = StreamProvider<UnAuthEvent>((ref) async* {
  yield* eventBus.on<UnAuthEvent>();
});
final serverEventProvider = StreamProvider<ServerEvent>((ref) async* {
  yield* eventBus.on<ServerEvent>();
});
