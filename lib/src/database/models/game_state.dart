part of '../database.dart';

enum MoveDirection { up, down, left, right }

@immutable
class Node {
  const Node(this.col, this.row);

  final int col;
  final int row;

  @override
  bool operator ==(Object other) {
    if (other is Node) {
      return col == other.col && row == other.row;
    }
    return false;
  }

  @override
  int get hashCode => col.hashCode ^ row.hashCode;

  @override
  String toString() => 'Node($col, $row)';

  MoveDirection directionTo(Node other) {
    assert(
      (col == other.col) != (row == other.row),
      'Nodes must differ in exactly one axis.',
    );
    if (col < other.col) {
      return MoveDirection.right;
    }
    if (col > other.col) {
      return MoveDirection.left;
    }
    if (row < other.row) {
      return MoveDirection.down;
    }
    return MoveDirection.up;
  }

  int orthogonalDistanceTo(Node other) {
    assert(
      (col == other.col) != (row == other.row),
      'Nodes must differ in exactly one axis.',
    );
    return (col - other.col).abs() + (row - other.row).abs();
  }
}

extension GameStateExtension on Game {
  Node get firstPoint {
    final index = grid.indexOf(1);
    return Node(index % numCols, index ~/ numCols);
  }

  Node get endPoint {
    final index = grid.indexOf(3);
    return Node(index % numCols, index ~/ numCols);
  }

  Node nodeOf(Puzzle puzzle) {
    final puzzleIndex = puzzles.indexOf(puzzle);
    // find the index-th 2 in the grid
    final index = grid.indexWhereNth((_, e) => e == 2, puzzleIndex);
    return Node(index % numCols, index ~/ numCols);
  }

  Map<Node, Puzzle> get puzzlesMap {
    return Map.fromEntries(
      puzzles.map((puzzle) => MapEntry(nodeOf(puzzle), puzzle)),
    );
  }
}
