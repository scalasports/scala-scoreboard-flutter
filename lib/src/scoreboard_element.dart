import 'package:flutter/material.dart';

import 'internal_table/internal_table_cell.dart';

/// An abstract class that represents a single element in the scoreboard table.
///
/// It defines a row containing a [position] widget, a [title] widget, and a list of
/// [dataColumns] widgets. This is used as the base class for the [ScoreboardHeader]
/// and [ScoreboardRow].
abstract class ScoreboardElement {
  /// Creates an instance of [ScoreboardElement].
  ///
  /// The [position] widget typically shows a rank, such as the position of a player or team.
  /// The [title] widget displays the main identifier for the row, such as a player or team name.
  /// The [dataColumns] list contains widgets that represent additional columns, such as scores or statistics.
  const ScoreboardElement({
    required this.position,
    required this.title,
    required this.dataColumns,
  });

  /// The widget displayed in the position column, typically showing a ranking (e.g., position number).
  ///
  /// This widget appears on the left side of the scoreboard.
  final Widget position;

  /// The widget representing the main identifier for this row.
  ///
  /// This is often used to display something like a player's name, club name, or team name.
  final Widget title;

  /// A list of widgets representing additional data columns for the row.
  ///
  /// These widgets appear in the scrollable area of the scoreboard and usually show statistics or scores.
  final List<Widget> dataColumns;

  /// Converts this [ScoreboardElement] into a list of [InternalTableCell]s.
  ///
  /// The [rowIndex] is required to correctly associate this row with its position in the table.
  ///
  /// This method returns a list of cells that includes the [position], [title],
  /// and all [dataColumns]. These cells can then be used to build the visual layout of the scoreboard.
  List<InternalTableCell> toInternalCells({required int rowIndex}) {
    return [
      InternalTableCell(
        rowIndex: rowIndex,
        cellType: InternalTableCellType.ranking,
        child: position,
      ),
      InternalTableCell(
        rowIndex: rowIndex,
        cellType: InternalTableCellType.definition,
        child: title,
      ),
      for (final column in dataColumns)
        InternalTableCell(
          rowIndex: rowIndex,
          cellType: InternalTableCellType.data,
          child: column,
        ),
    ];
  }
}

/// The header row of the scoreboard table, representing the titles for each column.
///
/// The [ScoreboardHeader] is typically used to define the column headers in the table, including
/// the rank, player/team name, and any other data columns. This header usually remains fixed at the
/// top of the table.
class ScoreboardHeader extends ScoreboardElement {
  /// Creates a [ScoreboardHeader] with a [position], [title], and [dataColumns].
  ///
  /// The [position] widget typically indicates the ranking column header (e.g., "Rank").
  /// The [title] widget represents the main column header (e.g., "Player" or "Team").
  /// The [dataColumns] widgets represent the headers for the additional data columns (e.g., "Points", "Goals").
  const ScoreboardHeader({
    required super.position,
    required super.title,
    required super.dataColumns,
  });
}

/// A single row of the scoreboard table, representing an individual player, team, or entity.
///
/// Each [ScoreboardRow] contains a [position] widget (typically showing a rank), a [title] widget (typically
/// showing a player or team name), and a list of [dataColumns] widgets representing additional data for that entity
/// (e.g., scores, points, or statistics).
class ScoreboardRow extends ScoreboardElement {
  /// Creates a [ScoreboardRow] with a [position], [title], and [dataColumns].
  ///
  /// The [position] widget typically shows the rank or position of the player or team.
  /// The [title] widget represents the player, team, or entity name.
  /// The [dataColumns] widgets represent additional statistics or data for this row, such as scores or points.
  const ScoreboardRow({
    required super.position,
    required super.title,
    required super.dataColumns,
    this.isSelected = false,
  });

  /// Whether the row should appear as selected.
  /// Only one [isSelected] row can exist in a scoreboard.
  final bool isSelected;
}
