import 'dart:math';

import 'package:flutter/material.dart';

/// A class that manages the sizing of table cells to ensure that the layout has
/// equal column widths and equal row heights.
class InternalTableSizeManager {
  InternalTableSizeManager();

  /// Reports the size of a cell identified by its row and column indices.
  /// This method saves the height and width for the corresponding row and column
  /// to ensure uniformity in the table layout.
  ///
  /// Parameters:
  /// - [rowIndex]: The index of the row for the cell.
  /// - [columnIndex]: The index of the column for the cell.
  /// - [size]: The size of the cell, including its width and height.
  void reportCellSize({
    required int rowIndex,
    required int columnIndex,
    required Size size,
  }) {
    _reportForRowHeight(rowIndex, size.height);
    _reportForColumnWidth(columnIndex, size.width);
  }

  /// Returns the maximum width of the specified column index.
  /// This method takes the largest width reported for that column.
  ///
  /// Parameters:
  /// - [columnIndex]: The index of the column whose width is requested.
  double columnWidthForIndex(int columnIndex) => _maxColumnWidths[columnIndex];

  /// Returns the maximum height of the specified row index.
  /// This method takes the largest height reported for that row.
  ///
  /// Parameters:
  /// - [rowIndex]: The index of the row whose height is requested.
  double rowHeightForIndex(int rowIndex) => _maxRowHeights[rowIndex];

  /// Gets the total number of rows that have been collected.
  int get numberOfRows => _maxRowHeights.length;

  final List<double> _maxRowHeights = List.empty(growable: true);
  final List<double> _maxColumnWidths = List.empty(growable: true);

  /// Reports the height of a specific row, updating the maximum height if
  /// the new height is greater than the previously recorded height.
  ///
  /// Parameters:
  /// - [rowIndex]: The index of the row for which the height is being reported.
  /// - [height]: The height of the cell in the specified row.
  void _reportForRowHeight(int rowIndex, double height) {
    if (rowIndex < _maxRowHeights.length) {
      // Update the maximum height for the row if the new height is greater.
      _maxRowHeights[rowIndex] = max(height, _maxRowHeights[rowIndex]);
    } else if (!(rowIndex > _maxRowHeights.length)) {
      // If the [rowIndex] is new, insert the width at the specified index.
      // This is only allowed if the [rowIndex] is not greater than the length of the array, hence the check above.
      _maxRowHeights.insert(rowIndex, height);
    } else {
      // If the [rowIndex] is not the next upcoming value, we did something wrong in the logic.
      // We throw an [IndexError] indicating the invalid [rowIndex].
      throw IndexError.withLength(
        rowIndex,
        _maxRowHeights.length,
        message: 'Tried to add for rowIndex $rowIndex but length was ${_maxRowHeights.length}',
      );
    }
  }

  /// Reports the width of a specific column, updating the maximum width if
  /// the new width is greater than the previously recorded width.
  ///
  /// Parameters:
  /// - [columnIndex]: The index of the column for which the width is being reported.
  /// - [width]: The width of the cell in the specified column.
  void _reportForColumnWidth(int columnIndex, double width) {
    // Check if the column index is valid.
    if (columnIndex < _maxColumnWidths.length) {
      // Update the maximum width for the column if the new width is greater.
      _maxColumnWidths[columnIndex] = max(width, _maxColumnWidths[columnIndex]);
    } else if (!(columnIndex > _maxColumnWidths.length)) {
      // If the [columnIndex] is new, insert the width at the specified index.
      // This is only allowed if the index is not greater than the length of the array, hence the check above.
      _maxColumnWidths.insert(columnIndex, width);
    } else {
      // If the [columnIndex] is not the next upcoming value, we did something wrong in the logic.
      // We throw an [IndexError] indicating the invalid [columnIndex].
      throw IndexError.withLength(
        columnIndex,
        _maxColumnWidths.length,
        message: 'Tried to add for columnIndex $columnIndex but length was ${_maxColumnWidths.length}',
      );
    }
  }
}
