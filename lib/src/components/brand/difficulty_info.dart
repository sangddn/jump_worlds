import 'package:flutter/cupertino.dart';

import '../../core_ui/core_ui.dart';
import '../../database/database.dart';

extension DifficultyInfo on Difficulty {
  CupertinoDynamicColor get backgroundColor => switch (this) {
    Difficulty.easy => PColors.green700,
    Difficulty.medium => PColors.blue700,
    Difficulty.hard => PColors.red700,
  };
}

extension GameDifficultyInfo on Difficulty {
  
}
