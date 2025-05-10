part of 'core_ui.dart';

const kThemeModeKey = 'theme-mode';
const kInitialThemeMode = ThemeMode.system;
ThemeMode _themeModeFromName(String? name) => ThemeMode.values.firstWhere(
  (element) => element.toString() == name,
  orElse: () => kInitialThemeMode,
);
Stream<ThemeMode> streamThemeMode(DatabaseInterface db) => db
    .stringRef //
    .watch(key: kThemeModeKey)
    .map((event) => event.value as String?)
    .startsWith(db.stringRef.get(kThemeModeKey))
    .map(_themeModeFromName);
void setThemeMode(ThemeMode themeMode, DatabaseInterface db) =>
    db.stringRef.put(kThemeModeKey, themeMode.toString());

ThemeData getTheme(Brightness brightness) {
  final colorScheme =
      brightness == Brightness.light ? PColorScheme.light : PColorScheme.dark;

  return ThemeData(
    fontFamily: 'GeistMono',
    brightness: brightness,
    colorScheme: colorScheme.materialScheme,
    appBarTheme: const AppBarTheme(centerTitle: false),
    switchTheme: SwitchThemeData(
      splashRadius: brightness == Brightness.light ? 0.0 : 1.0,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: kPageTransitionBuilders,
    ),
    dividerTheme: DividerThemeData(
      thickness: .5,
      indent: 12.0,
      endIndent: 12.0,
      color: PColors.gray300.resolveWithBrightness(brightness),
    ),
    inputDecorationTheme: const InputDecorationTheme(border: InputBorder.none),
    extensions: [
      if (brightness == Brightness.light)
        PColorScheme.light
      else
        PColorScheme.dark,
    ],
  );
}

extension ThemeUtils on BuildContext {
  ThemeData get theme => Theme.of(this);
  PTextTheme get textTheme => PTextTheme.of(this);
  PColorScheme get colors => theme.extension<PColorScheme>()!;
  ScaffoldMessengerState get toaster => ScaffoldMessenger.of(this);
  Color get brightSurface => theme.resolveColor(
    const Color.fromARGB(255, 252, 252, 252),
    const Color(0xff222222),
  );
}
