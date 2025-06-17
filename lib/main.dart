import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:nextgen_reeftech/features/home/presentation/pages/find_devices_view.dart';
import 'package:nextgen_reeftech/features/home/presentation/pages/home_view.dart';
import 'package:nextgen_reeftech/features/landing/presentation/pages/splash_view.dart';
import 'package:nextgen_reeftech/features/modes/presentation/pages/modes_view.dart';
import 'package:sizer/sizer.dart';

import 'features/global/resources/app_theme.dart';
import 'features/global/routes/app_routes.dart';
import 'features/home/presentation/pages/device_settings_view.dart';
import 'features/landing/presentation/pages/splash_view.dart';
import 'features/user/presentation/pages/auth/login_view.dart';
import 'injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(Injector(routerWidget: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _connectionStatus = "Unknown";
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: GetMaterialApp(
            title: 'NextGen ReefTech',
            builder: BotToastInit(),
            theme: AppTheme.getLightTheme(),
            navigatorObservers: [BotToastNavigatorObserver()],
            fallbackLocale: const Locale('en', 'US'),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', 'US'), // English
            ],
            localeResolutionCallback: (
              Locale? deviceLocale,
              Iterable<Locale> supportedLocales,
            ) {
              for (var locale in supportedLocales) {
                if (locale.languageCode == deviceLocale?.languageCode &&
                    locale.countryCode == deviceLocale?.countryCode) {
                  return deviceLocale;
                }
              }
              return supportedLocales.first;
            },
            debugShowCheckedModeBanner: false,
            getPages: AppRoutes.pages,
            initialRoute: SplashView.route,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    connectivitySubscription.cancel();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      startConnectionStream();
      initConnectivity();
    });
  }

  Future<void> initConnectivity() async {
    List<ConnectivityResult> result = [ConnectivityResult.none];
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    switch (result.first) {
      case ConnectivityResult.wifi:
        {
          debugPrint(result.toString());
          debugPrint(_connectionStatus);
        }
        break;
      case ConnectivityResult.mobile:
        {
          debugPrint(result.toString());
        }
        break;
      case ConnectivityResult.none:
        {
          // Get.snackbar("Uh Oh!", "No Internet Connection");
          // Get.to(() => const NoInternetScreen());
        }
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        break;
    }
  }

  void startConnectionStream() {
    connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }
}
