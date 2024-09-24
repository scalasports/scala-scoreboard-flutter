import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'internal_table.dart';

/// {@template scala_scoreboard.InternalTableCellType}
/// Enum representing the type of internal table cells (ranking, definition, data)
/// {@endtemplate}
enum InternalTableCellType {
  ranking,   // Represents a ranking cell in the table.
  definition, // Represents a definition cell in the table, e.g. player name or club name.
  data,      // Represents a data cell in the table, the scrollable parts.
}

/// Custom parent data class for the internal table cells, extending the
/// ContainerBoxParentData for layout management.
class InternalTableCellParentData extends ContainerBoxParentData<RenderBox>
    with ContainerParentDataMixin<RenderBox> {
  /// {@macro scala_scoreboard.InternalTableCellType}
  InternalTableCellType? cellType;

  /// {@template scala_scoreboard.rowIndex}
  /// The index of the row this cell belongs to.
  /// {@endtemplate}
  int? rowIndex;
}

/// A widget that provides a parent data class for internal table cells.
class InternalTableCell extends ParentDataWidget<InternalTableCellParentData> {
  /// Creates an instance of [InternalTableCell].
  const InternalTableCell._({
    required this.rowIndex,
    required this.cellType,
    required super.child,
  });

  /// {@macro scala_scoreboard.rowIndex}
  final int rowIndex;

  /// {@macro scala_scoreboard.InternalTableCellType}
  final InternalTableCellType cellType;

  /// Applies the parent data to the given [renderObject], updating its
  /// [cellType] and [rowIndex] if necessary, and marking the parent for layout
  /// if changes are made by calling `markNeedsLayout`.
  @override
  void applyParentData(RenderObject renderObject) {
    final parentData = renderObject.parentData! as InternalTableCellParentData;
    if (parentData.cellType != cellType || parentData.rowIndex != rowIndex) {
      parentData
        ..cellType = cellType
        ..rowIndex = rowIndex;
      (renderObject.parent! as InternalTableRenderBox).markNeedsLayout();
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => InternalTable;
}
