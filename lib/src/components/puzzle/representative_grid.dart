import 'dart:math';

import 'package:flutter/material.dart';

import '../../core_ui/core_ui.dart';
import '../../database/database.dart';

class RepresentativeGrid extends StatelessWidget {
  const RepresentativeGrid({super.key, this.cellSize, required this.game});

  final double? cellSize;
  final Game game;

  @override
  Widget build(BuildContext context) {
    final numRows = game.numRows;
    final numCols = game.numCols;

    return Container(
      decoration: ShapeDecoration(
        shape: Superellipse.border8,
        shadows: focusedShadows(),
        color: context.colors.neutral100,
      ),
      clipBehavior: Clip.hardEdge,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cellSize = min(constraints.maxWidth / numCols, 999.0);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(numRows, (row) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(numCols, (col) {
                  final index = row * numCols + col;
                  final cellType = game.grid[index];
                  return Container(
                    width: cellSize,
                    height: cellSize,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: context.colors.gray400,
                        strokeAlign: BorderSide.strokeAlignCenter,
                      ),
                    ),
                    child: _buildCell(cellType),
                  );
                }),
              );
            }),
          );
        },
      ),
    );
  }

  Widget _buildCell(int cellType) {
    switch (cellType) {
      case 0:
        return const SizedBox();
      case 1:
        return const _OriginCell();
      case 2:
        return const _PuzzleCell();
      case 3:
        return const _TargetCell();
      default:
        return const SizedBox();
    }
  }
}

class _OriginCell extends StatelessWidget {
  const _OriginCell();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('O', style: TextStyle(color: Colors.blue)));
  }
}

class _PuzzleCell extends StatelessWidget {
  const _PuzzleCell();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('P', style: TextStyle(color: Colors.green)),
    );
  }
}

class _TargetCell extends StatelessWidget {
  const _TargetCell();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('T', style: TextStyle(color: Colors.red)));
  }
}
