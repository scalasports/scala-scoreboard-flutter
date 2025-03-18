import 'package:flutter/material.dart';

import 'internal_table/internal_table.dart';
import 'scoreboard_element.dart';
import 'triangle_indicator.dart';

/// A widget that displays a standing table with a header and multiple rows.
/// The table consists of a left section for definitions or rankings and a right section for data columns.
/// The right section is scrollable, allowing for an organized view of extensive data while maintaining
/// the left section's visibility and layout.
///
/// This widget also supports customization options for background colors, shadow effects,
/// divider styles, and layout decorations.
class Scoreboard extends StatelessWidget {
  const Scoreboard({
    required this.header,
    required this.rows,
    this.leftSectionBackgroundColor,
    this.rightSectionBackgroundColor,
    this.rightSectionBackgroundColorWhenScrolled,
    this.applyShadowWhenScrolled = true,
    this.shadowColorWhenScrolled = const Color.fromRGBO(245, 245, 245, 1),
    this.shadowBlurWhenScrolled = 1.0,
    this.dividerWidth = 1.0,
    this.dividerColor = const Color.fromRGBO(230, 230, 230, 1),
    this.skipDividerForHeader = false,
    this.decoration,
    this.selectedRowColor = const Color.fromRGBO(247, 248, 250, 1),
    super.key,
  });

  /// The header of the scoreboard.
  /// Contains the elements defining the table's header row.
  final ScoreboardHeader header;

  /// The rows of the scoreboard.
  /// Represents the individual data rows, typically clubs, teams, or players.
  final List<ScoreboardRow> rows;

  /// {@template scala_scoreboard.Scoreboard.leftSectionBackgroundColor}
  /// Background color for the left section (e.g., definition column, ranking column).
  /// Defaults to [Colors.white] if not specified.
  /// {@endtemplate}
  final Color? leftSectionBackgroundColor;

  /// {@template scala_scoreboard.Scoreboard.rightSectionBackgroundColor}
  /// Background color for the right section (e.g., data columns).
  /// Defaults to [Colors.white] if not specified.
  /// {@endtemplate}
  final Color? rightSectionBackgroundColor;

  /// {@template scala_scoreboard.Scoreboard.rightSectionBackgroundColorWhenScrolled}
  /// Background color for the right section when scrolled.
  /// Defaults to [rightSectionBackgroundColor] if not specified.
  /// {@endtemplate}
  final Color? rightSectionBackgroundColorWhenScrolled;

  /// {@template scala_scoreboard.Scoreboard.applyShadowWhenScrolled}
  /// Determines whether the shadow is applied when the section is scrolled.
  /// Defaults to `true`.
  /// {@endtemplate}
  final bool applyShadowWhenScrolled;

  /// {@template scala_scoreboard.Scoreboard.shadowColorWhenScrolled}
  /// Color of the shadow applied when scrolled.
  /// Defaults to [Color.fromRGBO(245, 245, 245, 1)] if not specified.
  /// {@endtemplate}
  final Color shadowColorWhenScrolled;

  /// {@template scala_scoreboard.Scoreboard.shadowBlurWhenScrolled}
  /// Blur radius for the shadow when scrolled.
  /// Defaults to `1.0`.
  /// {@endtemplate}
  final double shadowBlurWhenScrolled;

  /// {@template scala_scoreboard.Scoreboard.dividerWidth}
  /// Width of the dividers between rows.
  /// Defaults to `1.0`.
  /// {@endtemplate}
  final double dividerWidth;

  /// {@template scala_scoreboard.Scoreboard.dividerColor}
  /// Color of the divider between the rows.
  /// Defaults to [Color.fromRGBO(230, 230, 230, 1)] if not specified.
  /// {@endtemplate}
  final Color dividerColor;

  /// {@template scala_scoreboard.Scoreboard.skipDividerForHeader}
  /// Determines whether to skip the divider for the header row.
  /// Defaults to `false`.
  /// {@endtemplate}
  final bool skipDividerForHeader;

  /// {@template scala_scoreboard.Scoreboard.selectedRowColor}
  /// The color of the selected row.
  /// Defaults to [Color.fromRGBO(247, 248, 250, 1)].
  /// {@endtemplate}
  final Color selectedRowColor;

  /// The decoration that may be applied on the container of the scoreboard.
  /// If null, a [BoxDecoration] with `borderRadius` set to 12 will be used.
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    // We need the layout builder to determine the exact width of the table.
    return Container(
      decoration: decoration ?? BoxDecoration(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.hardEdge,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Combine the header and rows into a single list of table cells.
          final cells = [...header.toInternalCells(rowIndex: 0)];

          int? selectedRowIndex;

          for (var index = 0; index < rows.length; index++) {
            final row = rows[index];

            // Real position is index + 1 since we have the header cells.
            final position = index + 1;
            if (row.isSelected) selectedRowIndex = position;
            cells.addAll(rows[index].toInternalCells(rowIndex: position));
          }

          // Make the right side scrollable.
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: InternalTable(
              outerConstraints: constraints,
              leftSectionBackgroundColor: leftSectionBackgroundColor ?? Colors.white,
              rightSectionBackgroundColor: rightSectionBackgroundColor ?? Colors.white,
              rightSectionBackgroundColorWhenScrolled:
                  rightSectionBackgroundColorWhenScrolled ?? rightSectionBackgroundColor ?? Colors.white,
              applyShadowWhenScrolled: applyShadowWhenScrolled,
              shadowColorWhenScrolled: shadowColorWhenScrolled,
              shadowBlurWhenScrolled: shadowBlurWhenScrolled,
              dividerWidth: dividerWidth,
              dividerColor: dividerColor,
              skipDividerForHeader: skipDividerForHeader,
              selectedRowColor: selectedRowColor,
              selectedRowIndex: selectedRowIndex,
              children: cells,
            ),
          );
        },
      ),
    );
  }
}

/// A default cell widget for the scoreboard table.
class ScoreboardCell extends StatelessWidget {
  const ScoreboardCell({
    required this.child,
    this.padding,
    this.textStyle,
    this.shouldCenter = true,
    super.key,
  });

  /// {@template scala_scoreboard.ScoreboardCell.child}
  /// The content of the cell.
  /// {@endtemplate}
  final Widget child;

  /// {@template scala_scoreboard.ScoreboardCell.padding}
  /// The padding inside the cell.
  /// {@endtemplate}
  final EdgeInsets? padding;

  /// The text style applied to the cell content.
  final TextStyle? textStyle;

  /// Whether the content should be centered horizontally.
  final bool shouldCenter;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      textAlign: TextAlign.center,
      style: textStyle ?? Theme.of(context).textTheme.labelMedium ?? const TextStyle(),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: shouldCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [child],
        ),
      ),
    );
  }
}

/// A default header cell widget for the scoreboard table.
class ScoreboardHeaderCell extends StatelessWidget {
  const ScoreboardHeaderCell({
    required this.child,
    this.padding,
    this.shouldCenter = true,
    super.key,
  });

  /// {@macro scala_scoreboard.ScoreboardCell.child}
  final Widget child;

  /// {@macro scala_scoreboard.ScoreboardCell.padding}
  final EdgeInsets? padding;

  /// Whether the content should be centered horizontally.
  final bool shouldCenter;

  @override
  Widget build(BuildContext context) {
    return ScoreboardCell(
      padding: padding,
      shouldCenter: shouldCenter,
      textStyle: Theme.of(context).textTheme.labelMedium,
      child: child,
    );
  }
}

/// {@template scala_scoreboard.ScoreboardTrendMode}
/// The trend mode defines whether the score or ranking is going up or down.
/// {@endtemplate}
enum ScoreboardTrendMode {
  down,
  up,
}

/// A position cell in the scoreboard table, which can optionally show an upward or downward trend.
class ScoreboardPositionCell extends StatelessWidget {
  const ScoreboardPositionCell({
    required this.child,
    this.padding,
    this.customDownIcon,
    this.customUpIcon,
    this.trendMode,
    super.key,
  });

  /// The content of the position cell (e.g., the rank).
  ///
  /// {@macro scala_scoreboard.ScoreboardCell.child}
  final Widget child;

  /// {@macro scala_scoreboard.ScoreboardCell.padding}
  final EdgeInsets? padding;

  /// A custom widget for the downward trend indicator.
  final Widget? customDownIcon;

  /// A custom widget for the upward trend indicator.
  final Widget? customUpIcon;

  /// {@macro scala_scoreboard.ScoreboardTrendMode}
  ///
  /// If left empty, nothing will be shown.
  final ScoreboardTrendMode? trendMode;

  @override
  Widget build(BuildContext context) {
    final trendMode = this.trendMode;
    if (trendMode == null) {
      return ScoreboardCell(
        textStyle: Theme.of(context).textTheme.labelLarge,
        child: child,
      );
    }
    final iconUp = customUpIcon ?? const TriangleUp(color: Colors.green, size: 6);
    final iconDown = customDownIcon ?? const TriangleDown(color: Colors.red, size: 6);
    return ScoreboardCell(
      padding: padding,
      textStyle: Theme.of(context).textTheme.labelLarge,
      child: Column(
        children: [
          child,
          const SizedBox(height: 1),
          if (trendMode == ScoreboardTrendMode.up) iconUp else if (trendMode == ScoreboardTrendMode.down) iconDown,
        ],
      ),
    );
  }
}

/// A title cell that can include a leading widget, such as an icon or logo.
class ScoreboardTitleCell extends StatelessWidget {
  const ScoreboardTitleCell({
    required this.title,
    this.leading,
    this.padding,
    this.spacing = 10,
    super.key,
  });

  /// The title content to display in the cell.
  final Widget title;

  /// A leading widget to display before the title (e.g., a logo).
  final Widget? leading;

  /// {@macro scala_scoreboard.ScoreboardCell.padding}
  final EdgeInsets? padding;

  /// The spacing between the leading widget and the title.
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return ScoreboardCell(
      padding: padding,
      shouldCenter: false,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[
            leading!,
            SizedBox(width: spacing),
          ],
          Flexible(
            child: DefaultTextStyle(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelLarge ?? const TextStyle(),
              child: title,
            ),
          ),
        ],
      ),
    );
  }
}
