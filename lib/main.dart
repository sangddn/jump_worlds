import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_physics/flutter_physics.dart';
import 'package:provider/provider.dart';

import 'src/app/app.dart';
import 'src/core_ui/core_ui.dart';
import 'src/database/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Disable debugPrint if not in debug mode
  debugPrint = (String? message, {int? wrapWidth}) {
    if (kDebugMode) {
      debugPrintThrottled(message, wrapWidth: wrapWidth);
    }
  };

  // Register mappers to Mappable
  MapperContainer.globals.useAll(const [DateTimeMapper()]);

  // Set default duration and curve for Flutter Animate
  Animate.restartOnHotReload = true;
  Animate.defaultDuration = Effects.shortDuration;
  Animate.defaultCurve = Spring.elegant;

  // Database
  final database = Database();
  await database.initialize();

  runApp(
    MultiProvider(
      providers: [Provider<DatabaseInterface>.value(value: database)],
      child: const App(),
    ),
  );
}
