import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core_ui/core_ui.dart';
import '../database/database.dart';
import '../router/router.dart';
import '../scopes/scopes.dart';

class App extends StatefulWidget {
  const App({super.key});

  static final toasterKey = GlobalKey<ToasterState>();
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final _db = context.read<DatabaseInterface>();
  late final _appRouter = AppRouter(navigatorKey: App.navigatorKey, db: _db);

  @override
  void dispose() {
    _db.dispose();
    _appRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<ThemeMode>(
          initialData: kInitialThemeMode,
          create: (context) => streamThemeMode(context.db),
        ),
        ChangeNotifierProvider<AppRouter>.value(value: _appRouter),
      ],
      builder: (context, _) {
        final mode = context.watch<ThemeMode>();
        return MaterialApp.router(
          title: 'Jumper',
          debugShowCheckedModeBanner: false,
          theme: getTheme(Brightness.light),
          darkTheme: getTheme(Brightness.dark),
          themeMode: mode,
          routerConfig: _appRouter.config(navigatorObservers: () => []),
          builder: (_, child) => Toaster(key: App.toasterKey, child: child!),
        );
      },
    );
  }
}

extension DatabaseExtension on BuildContext {
  DatabaseInterface get db => read();
}
