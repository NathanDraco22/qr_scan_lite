import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_lite/cubit/Theme/theme_cubit.dart';
import 'package:qr_lite/cubit/qr_scans_cubit.dart';
import 'package:qr_lite/database/shared_preferences/preferences.dart';
import 'package:qr_lite/screens/screens.dart';
import 'package:qr_lite/screens/storage_screen.dart';
import 'package:qr_lite/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Preferenes.initPref();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => QrScansCubit()),
        BlocProvider(create: (_) => ThemeCubit())
      ],
      child: const _RootApp()
    );
  }
}

class _RootApp extends StatelessWidget {
  const _RootApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'QR lite',
          initialRoute: "home",
          routes: {
            "home": (_) => const HomeScreen(),
            "storage" : ( _ ) => const StorageScreen()
          },
          theme: state.darkMode? AppTheme.dark : AppTheme.light,
        );
      },
    );
  }
}
