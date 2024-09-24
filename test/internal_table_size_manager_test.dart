import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scala_scoreboard/src/internal_table/internal_table_size_manager.dart';

void main() {
  group('InternalTableSizeManager Tests', () {
    late InternalTableSizeManager sizeManager;

    setUp(() {
      sizeManager = InternalTableSizeManager();
    });

    test('Initial state has no rows and columns', () {
      expect(sizeManager.numberOfRows, 0);
    });

    test('Reporting cell sizes updates row heights and column widths', () {
      sizeManager
        ..reportCellSize(rowIndex: 0, columnIndex: 0, size: const Size(100, 50))
        ..reportCellSize(rowIndex: 1, columnIndex: 0, size: const Size(150, 30))
        ..reportCellSize(rowIndex: 0, columnIndex: 1, size: const Size(120, 60));

      expect(sizeManager.rowHeightForIndex(0), 60);
      expect(sizeManager.rowHeightForIndex(1), 30);
      expect(sizeManager.columnWidthForIndex(0), 150);
      expect(sizeManager.columnWidthForIndex(1), 120);
      expect(sizeManager.numberOfRows, 2);
    });

    test('Reporting cell sizes updates existing rows and columns', () {
      sizeManager
        ..reportCellSize(rowIndex: 0, columnIndex: 0, size: const Size(100, 50))
        ..reportCellSize(rowIndex: 0, columnIndex: 1, size: const Size(150, 60)) // Update column 1 width
        ..reportCellSize(rowIndex: 1, columnIndex: 0, size: const Size(120, 70)); // Update row 1 height

      expect(sizeManager.rowHeightForIndex(0), 60);
      expect(sizeManager.rowHeightForIndex(1), 70);
      expect(sizeManager.columnWidthForIndex(0), 120);
      expect(sizeManager.columnWidthForIndex(1), 150);
      expect(sizeManager.numberOfRows, 2);
    });

    test('Inserting new row height and column width', () {
      sizeManager
        ..reportCellSize(rowIndex: 0, columnIndex: 0, size: const Size(100, 50))
        ..reportCellSize(rowIndex: 1, columnIndex: 1, size: const Size(200, 80)); // New row and column

      expect(sizeManager.rowHeightForIndex(1), 80);
      expect(sizeManager.columnWidthForIndex(1), 200);
      expect(sizeManager.numberOfRows, 2);
    });

    test('Invalid row index throws error', () {
      expect(
        () => sizeManager.reportCellSize(rowIndex: 2, columnIndex: 0, size: const Size(100, 50)),
        throwsA(isA<IndexError>()),
      );
    });

    test('Invalid column index throws error', () {
      expect(
        () => sizeManager.reportCellSize(rowIndex: 0, columnIndex: 2, size: const Size(100, 50)),
        throwsA(isA<IndexError>()),
      );
    });
  });
}
