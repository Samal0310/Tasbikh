import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/dhikr.dart';
import 'package:flutter_application_1/pages/home/settings/settings.dart';
import 'package:flutter_application_1/providers/counter_provider.dart';
import 'package:flutter_application_1/providers/hive_provider.dart';
import 'package:flutter_application_1/providers/top_panel_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'pages/home/custom/custom_page.dart';
import 'pages/home/home.dart';
import 'pages/home/top_panel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  Hive.registerAdapter(DhikrAdapter());
  await EasyLocalization.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterProvider(),
        lazy: false,),
        ChangeNotifierProvider(create: (context) => TopPanelProvider(),),
        ChangeNotifierProvider(create: (context) => HiveProvider(),
        lazy: false,),
        ],
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('ru'),
          Locale('kk'),
        ],
        path: 'assets/langs/lang.csv',
        fallbackLocale: const Locale('en'),
        assetLoader: CsvAssetLoader(),
        child: const FlutterApplication1(),
      ),
    ),
  );
}

class FlutterApplication1 extends StatelessWidget {
  const FlutterApplication1({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: ValueKey(context.locale),
      child: MaterialApp.router(
        routerConfig: _router,
        theme: ThemeData(
          fontFamily: 'Gilroy-Medium',
          textTheme: const TextTheme(
            bodyMedium: TextStyle(fontSize: 12.0),
          ),
        ),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Home();
      },
      routes: [
        GoRoute(
          path: 'settings',
          builder: (BuildContext context, GoRouterState state) {
            return const Settings();
          },
          routes: [
            GoRoute(
              path: 'custompage',
              builder: (BuildContext context, GoRouterState state) {
                return const CustomPage();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
