import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'internal_table_cell.dart';
import 'internal_table_size_manager.dart';

/// A custom table widget that supports multi-child layout with two distinct sections:
/// a left section (e.g., a definition column or ranking column) and a right section (e.g., data columns).
///
/// This widget handles layout constraints, background colors, dividers, and shadow effects when scrolled.
/// It is designed to provide responsive layouts where the right section can become scrollable,
/// while ensuring that the left section maintains its size and layout.
class InternalTable extends MultiChildRenderObjectWidget {
  const InternalTable({
    super.key,
    required this.outerConstraints,
    required this.leftSectionBackgroundColor,
    required this.rightSectionBackgroundColor,
    required this.rightSectionBackgroundColorWhenScrolled,
    required this.shadowColorWhenScrolled,
    required this.applyShadowWhenScrolled,
    required this.shadowBlurWhenScrolled,
    required this.dividerWidth,
    required this.dividerColor,
    required this.skipDividerForHeader,
    required this.selectedRowIndex,
    required this.selectedRowColor,
    super.children,
  });

  /// {@macro scala_scoreboard.Scoreboard.outerConstraints}
  final BoxConstraints outerConstraints;

  /// {@macro scala_scoreboard.Scoreboard.leftSectionBackgroundColor}
  final Color leftSectionBackgroundColor;

  /// {@macro scala_scoreboard.Scoreboard.rightSectionBackgroundColor}
  final Color rightSectionBackgroundColor;

  /// {@macro scala_scoreboard.Scoreboard.rightSectionBackgroundColorWhenScrolled}
  final Color rightSectionBackgroundColorWhenScrolled;

  /// {@macro scala_scoreboard.Scoreboard.applyShadowWhenScrolled}
  final bool applyShadowWhenScrolled;

  /// {@macro scala_scoreboard.Scoreboard.shadowColorWhenScrolled}
  final Color shadowColorWhenScrolled;

  /// {@macro scala_scoreboard.Scoreboard.shadowBlurWhenScrolled}
  final double shadowBlurWhenScrolled;

  /// {@macro scala_scoreboard.Scoreboard.dividerWidth}
  final double dividerWidth;

  /// {@macro scala_scoreboard.Scoreboard.dividerColor}
  final Color dividerColor;

  /// {@macro scala_scoreboard.Scoreboard.skipDividerForHeader}
  final bool skipDividerForHeader;

  /// {@template scala_scoreboard.Scoreboard.selectedRowIndex}
  /// Determines which row should appear as selected.
  /// Defaults to null.
  /// {@endtemplate}
  final int? selectedRowIndex;

  /// {@macro scala_scoreboard.Scoreboard.selectedRowColor}
  final Color selectedRowColor;

  @override
  InternalTableRenderBox createRenderObject(BuildContext context) {
    return InternalTableRenderBox(
      outerConstraints: outerConstraints,
      leftSectionBackgroundColor: leftSectionBackgroundColor,
      rightSectionBackgroundColor: rightSectionBackgroundColor,
      rightSectionBackgroundColorWhenScrolled: rightSectionBackgroundColorWhenScrolled,
      applyShadowWhenScrolled: applyShadowWhenScrolled,
      shadowColorWhenScrolled: shadowColorWhenScrolled,
      shadowBlurWhenScrolled: shadowBlurWhenScrolled,
      dividerWidth: dividerWidth,
      dividerColor: dividerColor,
      selectedRowColor: selectedRowColor,
      skipDividerForHeader: skipDividerForHeader,
      selectedRowIndex: selectedRowIndex,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderObject renderObject) {
    (renderObject as InternalTableRenderBox)
      ..outerConstraints = outerConstraints
      ..leftSectionBackgroundColor = leftSectionBackgroundColor
      ..rightSectionBackgroundColor = rightSectionBackgroundColor
      ..rightSectionBackgroundColorWhenScrolled = rightSectionBackgroundColorWhenScrolled
      ..applyShadowWhenScrolled = applyShadowWhenScrolled
      ..shadowColorWhenScrolled = shadowColorWhenScrolled
      ..shadowBlurWhenScrolled = shadowBlurWhenScrolled
      ..dividerWidth = dividerWidth
      ..dividerColor = dividerColor
      ..skipDividerForHeader = skipDividerForHeader
      ..selectedRowIndex = selectedRowIndex
      ..selectedRowColor = selectedRowColor;
    super.updateRenderObject(context, renderObject);
  }
}

/// [InternalTableRenderBox] is a custom render box responsible for laying out
/// and painting a table-like widget where the left section is fixed and the
/// right section can be scrolled horizontally. It manages row heights and
/// column widths to ensure that cells in the left and right sections align properly.
class InternalTableRenderBox extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, ContainerBoxParentData<RenderBox>>,
        RenderBoxContainerDefaultsMixin<RenderBox, ContainerBoxParentData<RenderBox>> {
  /// Creates an [InternalTableRenderBox] with specified configuration options for
  /// background colors, shadow effects, and divider appearance.
  ///
  /// [outerConstraints] represents the constraints of the containing scroll view.
  /// The background colors for the left and right sections can be configured, as
  /// well as the background color for the right section when it is scrolled.
  /// Shadow appearance can be controlled by [applyShadowWhenScrolled], [shadowColorWhenScrolled],
  /// and [shadowBlurWhenScrolled]. The divider's color and width can be adjusted with
  /// [dividerColor] and [dividerWidth].
  InternalTableRenderBox({
    required BoxConstraints outerConstraints,
    required Color leftSectionBackgroundColor,
    required Color rightSectionBackgroundColor,
    required Color rightSectionBackgroundColorWhenScrolled,
    required bool applyShadowWhenScrolled,
    required Color shadowColorWhenScrolled,
    required double shadowBlurWhenScrolled,
    required double dividerWidth,
    required Color dividerColor,
    required Color selectedRowColor,
    required bool skipDividerForHeader,
    int? selectedRowIndex,
  })  : _outerConstraints = outerConstraints,
        _leftSectionBackgroundColor = leftSectionBackgroundColor,
        _rightSectionBackgroundColor = rightSectionBackgroundColor,
        _rightSectionBackgroundColorWhenScrolled = rightSectionBackgroundColorWhenScrolled,
        _applyShadowWhenScrolled = applyShadowWhenScrolled,
        _shadowColorWhenScrolled = shadowColorWhenScrolled,
        _shadowBlurWhenScrolled = shadowBlurWhenScrolled,
        _dividerWidth = dividerWidth,
        _dividerColor = dividerColor,
        _skipDividerForHeader = skipDividerForHeader,
        _selectedRowIndex = selectedRowIndex,
        _selectedRowColor = selectedRowColor;

  late InternalTableSizeManager _tableSizeManager;

  /// Gets the outer constraints (bounded) from the box above the [SingleChildScrollView].
  BoxConstraints get outerConstraints => _outerConstraints;
  BoxConstraints _outerConstraints;

  /// Sets the outer constraints (bounded) from the box above the [SingleChildScrollView].
  set outerConstraints(BoxConstraints value) {
    if (_outerConstraints == value) return;
    _outerConstraints = value;
    markNeedsPaint();
    markNeedsLayout();
  }

  /// Gets the background color for the left section.
  Color get leftSectionBackgroundColor => _leftSectionBackgroundColor;
  Color _leftSectionBackgroundColor;

  /// Sets the background color for the left section.
  set leftSectionBackgroundColor(Color color) {
    if (_leftSectionBackgroundColor == color) return;
    _leftSectionBackgroundColor = color;
    markNeedsPaint();
  }

  /// Gets the background color for the right section.
  Color _rightSectionBackgroundColor;
  Color get rightSectionBackgroundColor => _rightSectionBackgroundColor;

  /// Sets the background color for the right section.
  set rightSectionBackgroundColor(Color color) {
    if (_rightSectionBackgroundColor == color) return;
    _rightSectionBackgroundColor = color;
    markNeedsPaint();
  }

  /// Gets the background color for the right section when scrolled.
  Color _rightSectionBackgroundColorWhenScrolled;
  Color get rightSectionBackgroundColorWhenScrolled => _rightSectionBackgroundColorWhenScrolled;

  /// Sets the background color for the right section when scrolled.
  set rightSectionBackgroundColorWhenScrolled(Color color) {
    if (_rightSectionBackgroundColorWhenScrolled == color) return;
    _rightSectionBackgroundColorWhenScrolled = color;
    markNeedsPaint();
  }

  /// Gets whether the shadow should be applied when scrolled.
  bool get applyShadowWhenScrolled => _applyShadowWhenScrolled;
  bool _applyShadowWhenScrolled;

  /// Sets whether the shadow should be applied when scrolled.
  set applyShadowWhenScrolled(bool value) {
    if (_applyShadowWhenScrolled == value) return;
    _applyShadowWhenScrolled = value;
    markNeedsPaint();
  }

  /// Gets the color of the shadow when scrolled.
  Color get shadowColorWhenScrolled => _shadowColorWhenScrolled;
  Color _shadowColorWhenScrolled;

  /// Sets the color of the shadow when scrolled.
  set shadowColorWhenScrolled(Color value) {
    if (_shadowColorWhenScrolled == value) return;
    _shadowColorWhenScrolled = value;
    markNeedsPaint();
  }

  /// Gets the blur radius for the shadow when scrolled.
  double get shadowBlurWhenScrolled => _shadowBlurWhenScrolled;
  double _shadowBlurWhenScrolled;

  /// Sets the blur radius for the shadow when scrolled.
  set shadowBlurWhenScrolled(double value) {
    if (_shadowBlurWhenScrolled == value) return;
    _shadowBlurWhenScrolled = value;
    markNeedsPaint();
  }

  /// Gets the color for the divider between the rows.
  Color get dividerColor => _dividerColor;
  Color _dividerColor;

  /// Sets the color for the divider between the rows.
  set dividerColor(Color color) {
    if (_dividerColor == color) return;
    _dividerColor = color;
    markNeedsPaint();
  }

  /// Gets the divider width for the divider between the rows.
  double get dividerWidth => _dividerWidth;
  double _dividerWidth;

  /// Sets the divider width for the divider between the rows.
  set dividerWidth(double width) {
    if (_dividerWidth == width) return;
    _dividerWidth = width;
    markNeedsPaint();
  }

  /// Gets whether a divider should be drawn for the header row.
  bool get skipDividerForHeader => _skipDividerForHeader;
  bool _skipDividerForHeader;

  /// Sets whether the divider should be drawn for the header row.
  set skipDividerForHeader(bool value) {
    if (_skipDividerForHeader == value) return;
    _skipDividerForHeader = value;
    markNeedsPaint();
  }

  /// Gets the selected row index if any.
  int? get selectedRowIndex => _selectedRowIndex;
  int? _selectedRowIndex;

  /// Sets the selected row index.
  set selectedRowIndex(int? value) {
    if (_selectedRowIndex == value) return;
    _selectedRowIndex = value;
    markNeedsPaint();
  }

  /// Gets the selected row color.
  Color _selectedRowColor;
  Color get selectedRowColor => _selectedRowColor;

  set selectedRowColor(Color value) {
    if (_selectedRowColor == value) return;
    _selectedRowColor = value;
    markNeedsPaint();
  }

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! ContainerBoxParentData<RenderBox>) {
      child.parentData = InternalTableCellParentData();
    }
  }

  @override
  void performLayout() {
    RenderBox? child = firstChild;
    RenderBox? previousChild;

    Offset startOffset = Offset.zero;
    int currentColumnIndex = 0;

    // At least 1/3 of the column should be saved for the data.
    final minDataColumnWidth = outerConstraints.maxWidth * (1 / 3);

    final sizeManager = InternalTableSizeManager();

    // This method makes sure the cell is properly laid out respecting the layout rules for the cells.
    void layoutCell({
      required RenderBox child,
      required InternalTableCellType cellType,
      double? width,
      double? height,
    }) {
      // Layout the child with respect to the rules defined for the cells.
      if (cellType == InternalTableCellType.definition) {
        // Layout, but respect the size that's available.
        // If this cell is a 'definition' cell, then it always should have a previous cell that's a 'ranking' cell.
        // Deduct the width of the previous child and the min width of the data column from the total width.
        // NOTE: If a concrete width is set in this method, we should take the smallest.
        final maxWidth = outerConstraints.maxWidth - previousChild!.size.width - minDataColumnWidth;

        child.layout(
          constraints.copyWith(
            maxWidth: width != null ? max(width, maxWidth) : maxWidth,
            minWidth: width,
            minHeight: height,
          ),
          parentUsesSize: true,
        );
      } else {
        // Layout with constraints, these type of cells should take their intrinsic width.
        child.layout(constraints.copyWith(minWidth: width, minHeight: height), parentUsesSize: true);
      }
    }

    // This method makes sure the right [startOffset] is used.
    void setCellPosition({
      required RenderBox child,
      required int? previousRowIndex,
      required int currentRowIndex,
    }) {
      final childParentData = child.parentData! as InternalTableCellParentData;

      // Set the correct start offset.
      // The startOffset should take the previous child into account and move horizontally.
      startOffset = Offset(startOffset.dx + (previousChild?.size.width ?? 0.0), startOffset.dy);

      // If the row index moved, we should set the offset to x=0 and y to the height of the largest cell.
      if (previousRowIndex != null && currentRowIndex > previousRowIndex) {
        // Set the new offset based on the size of the previous row.
        // Reset the [columnIndex] as we're starting on a new line.
        startOffset = Offset(0, startOffset.dy + sizeManager.rowHeightForIndex(previousRowIndex));
      }

      childParentData.offset = startOffset;
    }

    // This method changes the column index if the row index [previousRowIndex] and [currentRowIndex] differ.
    void updateColumnIndex({
      required int? previousRowIndex,
      required int currentRowIndex,
    }) {
      // If the row index moved, we should set the offset to x=0 and y to the height of the largest cell.
      if (previousRowIndex != null && currentRowIndex > previousRowIndex) {
        // Reset the [columnIndex] as we're starting on a new line.
        currentColumnIndex = 0;
      }
    }

    // Loop through the children initially to determine their size.
    while (child != null) {
      final childParentData = child.parentData! as InternalTableCellParentData;
      final cellType = childParentData.cellType;
      final currentRowIndex = childParentData.rowIndex;
      final previousRowIndex = (previousChild?.parentData as InternalTableCellParentData?)?.rowIndex;

      // The row index and cell type should be set by the applyParentData method. If this is not the case, it should throw.
      if (currentRowIndex == null || cellType == null) {
        throw Exception(
          'The row index and cellType of the current child should never be null',
        );
      }

      // Layout the cell in the ui, this renders the cell and let's us determine its size.
      layoutCell(child: child, cellType: cellType);

      // Pick the appropriate position based on the row index.
      setCellPosition(
        child: child,
        previousRowIndex: previousRowIndex,
        currentRowIndex: currentRowIndex,
      );

      // Update the column index if necessary.
      updateColumnIndex(
        previousRowIndex: previousRowIndex,
        currentRowIndex: currentRowIndex,
      );

      // Report the size to the manager, so we can use it to derive the largest row height and largest column height
      // when we want to do the relayout.
      sizeManager.reportCellSize(
        columnIndex: currentColumnIndex,
        rowIndex: currentRowIndex,
        size: child.size,
      );

      // Move to the next child cell.
      previousChild = child;
      child = childParentData.nextSibling;
      currentColumnIndex++;
    }

    // Now that the initial layout has finished, all the cell should obey two rules:
    // 1. The minWidth should be set to the widest cell in that column (columnWidthForIndex)
    // 2. The minHeight should be set to the largest cell (rowHeightForIndex)

    // Set back the loop properties.
    child = firstChild;
    previousChild = null;
    startOffset = Offset.zero;
    currentColumnIndex = 0;

    // If the sum of the column widths is smaller than the constrains.maxWidth we should allocate the difference extra space
    // inside the player rows, we will call this the `underflow`.
    final underflow = max(_outerConstraints.maxWidth - sizeManager.totalColumnWidth, 0);

    while (child != null) {
      final childParentData = child.parentData! as InternalTableCellParentData;
      final previousRowIndex = (previousChild?.parentData as InternalTableCellParentData?)?.rowIndex;
      final currentRowIndex = childParentData.rowIndex!;
      final cellType = childParentData.cellType!;

      // Update the column index if necessary.
      updateColumnIndex(
        previousRowIndex: previousRowIndex,
        currentRowIndex: currentRowIndex,
      );

      // If the cellType is definition, we want to give back the underflow to the definition column.
      var columnWidth = sizeManager.columnWidthForIndex(currentColumnIndex);
      if (cellType == InternalTableCellType.definition) columnWidth += underflow;

      // Layout the cell in the UI, but this time with the width and height that are now known.
      layoutCell(
        child: child,
        cellType: childParentData.cellType!,
        width: columnWidth,
        height: sizeManager.rowHeightForIndex(currentRowIndex),
      );

      // Since layout might have shifted (Horizontally), we need to set the new offsets.
      setCellPosition(
        child: child,
        previousRowIndex: previousRowIndex,
        currentRowIndex: currentRowIndex,
      );

      // Move to the next child cell.
      previousChild = child;
      child = childParentData.nextSibling;
      currentColumnIndex++;
    }

    // Set the [sizeManager] so the [paint] method knows the sizes of the rows and columns.
    _tableSizeManager = sizeManager;

    // The size can be easily derived from the last [startOffset].
    // The startOffset + size of the previous child yields to the complete size.
    // The width should always be at least the width of the [outerConstraints].
    size = previousChild != null
        ? Size(
            max(startOffset.dx + previousChild.size.width, _outerConstraints.maxWidth),
            startOffset.dy + previousChild.size.height,
          )
        : Size.zero;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // For drawing, we separate a left container with fixed items, and a right container with scrollable items.

    // Determine whether the widget is scrolled.
    final isScrolled = offset.dx < 0;

    final rightChildren = List<RenderBox>.empty(growable: true);
    final leftChildren = List<RenderBox>.empty(growable: true);

    // Find the first child that is of type data.
    // All the widths of the columns are equal, so we can just look this up once.
    Offset? rightContainerOffset;

    // Inspects the children and determines the values for: [rightContainerOffset], [rightChildren] and [leftChildren].
    void inspectChildren() {
      RenderBox? child = firstChild;
      while (child != null) {
        final childParentData = child.parentData! as InternalTableCellParentData;
        // Get the x-start of the data column, so the min value.
        // Get the width of the data columns together.
        if (childParentData.cellType == InternalTableCellType.data) {
          rightContainerOffset ??= Offset(childParentData.offset.dx, 0);
          rightChildren.add(child);
        } else {
          leftChildren.add(child);
        }

        child = childParentData.nextSibling;
      }
    }

    // Draws the container on the right with the data columns.
    void drawRightContainer(Offset start) {
      // We can derive the size of the container if we have the offset.
      final containerSize = Size(size.width - start.dx, size.height);

      final containerRect = Rect.fromLTWH(
        start.dx,
        start.dy,
        containerSize.width,
        containerSize.height,
      );

      // Draw the background.
      context.canvas.drawRect(
        containerRect,
        Paint()..color = isScrolled ? _rightSectionBackgroundColorWhenScrolled : _rightSectionBackgroundColor,
      );

      // We only want to paint the selected background once.
      bool didPaintSelected = false;

      // Now draw the data cells on this background.
      // This should be done after the background drawing since their z-index is higher.
      for (final child in rightChildren) {
        final childParentData = child.parentData! as InternalTableCellParentData;
        final rowIndex = childParentData.rowIndex;
        final isSelectedRow = rowIndex == _selectedRowIndex;

        if (isSelectedRow && !didPaintSelected && rowIndex != null) {
          context.canvas.drawRect(
            Rect.fromLTWH(
              0,
              childParentData.offset.dy,
              size.width,
              _tableSizeManager.rowHeightForIndex(rowIndex),
            ),
            Paint()..color = _selectedRowColor,
          );

          didPaintSelected = true;
        }

        // Note that we use the offset for the scrolling here.
        context.paintChild(child, offset + childParentData.offset);
      }
    }

    // Draw the left container with the ranking and definition.
    void drawLeftContainer({required Rect rect}) {
      if (rightContainerOffset != null && isScrolled && _applyShadowWhenScrolled) {
        // Create a wider path at the division line
        final shadowPath = Path()..addRect(rect); // Create a thin vertical rectangle

        // Draw the shadow
        context.canvas.drawShadow(
          shadowPath,
          _rightSectionBackgroundColorWhenScrolled,
          _shadowBlurWhenScrolled,
          false,
        );
      }

      context.canvas.drawRect(
        rect,
        Paint()..color = _leftSectionBackgroundColor,
      );

      // We only want to paint the selected background once.
      bool didPaintSelected = false;

      // Consequently, draw the children.
      for (final child in leftChildren) {
        final childParentData = child.parentData! as InternalTableCellParentData;
        final rowIndex = childParentData.rowIndex;
        final isSelectedRow = rowIndex == _selectedRowIndex;

        if (isSelectedRow && !didPaintSelected && rowIndex != null) {
          context.canvas.drawRect(
            Rect.fromLTWH(
              0,
              childParentData.offset.dy,
              rect.width,
              _tableSizeManager.rowHeightForIndex(rowIndex),
            ),
            Paint()..color = const Color.fromRGBO(247, 248, 250, 1),
          );

          didPaintSelected = true;
        }

        // Note that we don't use the offset for the scrolling here.
        context.paintChild(child, childParentData.offset);
      }
    }

    // Draws the dividers in the table, only draws the dividers if the [dividerWidth] is more then 0.
    void drawDividers() {
      var startY = 0.0;

      if (dividerWidth <= 0) return;

      final dividerPaint = Paint()
        ..color = dividerColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = dividerWidth;

      // Loop through the manager with and use the row height.
      for (var index = 0; index < _tableSizeManager.numberOfRows; index++) {
        final rowHeight = _tableSizeManager.rowHeightForIndex(index);

        if (skipDividerForHeader && index == 0) {
          // If the user indicated there's no need for a divider in the header row, we only calculate the new startY
          // and proceed with the next row.
          startY += rowHeight;
          continue;
        }

        context.canvas.drawLine(Offset(0, startY), Offset(size.width, startY), dividerPaint);

        startY += rowHeight;
      }
    }

    // Inspect the children, split them up in the [leftChildren] and [rightChildren]
    // and determine the [rightContainerOffset].
    inspectChildren();

    // Draw right container (RIGHT).
    // We do a force cast for the right container offset, as this should always be known at this point.
    drawRightContainer(rightContainerOffset!);

    // Now draw with the other paint another rectangle for the definition column and raking (LEFT).
    drawLeftContainer(rect: Rect.fromLTWH(0, 0, rightContainerOffset?.dx ?? 0.0, size.height));

    // Finally, draw the dividers.
    drawDividers();
  }
}
