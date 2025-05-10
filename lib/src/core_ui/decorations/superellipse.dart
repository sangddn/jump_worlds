import 'package:flutter/widgets.dart';

abstract final class Superellipse {
  static RoundedSuperellipseBorder all(
    double radius, {
    BorderSide side = BorderSide.none,
  }) => RoundedSuperellipseBorder(
    borderRadius: BorderRadius.all(Radius.circular(radius)),
    side: side,
  );

  static const border2 = RoundedSuperellipseBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  );

  static const border4 = RoundedSuperellipseBorder(
    borderRadius: BorderRadius.all(Radius.circular(4.0)),
  );

  static const border8 = RoundedSuperellipseBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  );

  static const border12 = RoundedSuperellipseBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  );

  static const border16 = RoundedSuperellipseBorder(
    borderRadius: BorderRadius.all(Radius.circular(16.0)),
  );

  static const border20 = RoundedSuperellipseBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  );

  static const border24 = RoundedSuperellipseBorder(
    borderRadius: BorderRadius.all(Radius.circular(24.0)),
  );

  static const border28 = RoundedSuperellipseBorder(
    borderRadius: BorderRadius.all(Radius.circular(28.0)),
  );

  static const border32 = RoundedSuperellipseBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  );

  static const border36 = RoundedSuperellipseBorder(
    borderRadius: BorderRadius.all(Radius.circular(36.0)),
  );
}
