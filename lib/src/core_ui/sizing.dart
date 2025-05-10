part of 'core_ui.dart';

abstract final class Breakpoints {
  static const double concentrated = 350.0;
  static const double optimRead = 600.0;
  static const double narrow = 700.0;
  static const double xWide = 1200.0;
  static const double maxWidth = 1500.0;
}

extension BreakpointsExtension on BuildContext {
  bool get isNarrow => MediaQuery.sizeOf(this).width <= Breakpoints.narrow;
  bool get isWideAndUp => MediaQuery.sizeOf(this).width > Breakpoints.narrow;
  bool get isXWideAndUp => MediaQuery.sizeOf(this).width > Breakpoints.xWide;
  T sizeAdapt<T>(T narrow, T wide) {
    return isNarrow ? narrow : wide;
  }
}
