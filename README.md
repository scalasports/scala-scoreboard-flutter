# Scoreboard Widget

A Flutter widget that displays a scoreboard table, featuring a header and multiple rows. The scoreboard is designed to showcase standings for teams, players, or clubs, with a scrollable right section for data columns, making it ideal for mobile screens.

## Features

- **Customizable Appearance**: Easily change background colors, shadow effects, and divider styles.
- **Scrollable Data Columns**: The right section is scrollable, allowing for a clean and organized view of extensive data.
- **Header Support**: Includes a header section to define the table's columns and provide context.
- **Dynamic Row Content**: Supports varying content types in rows, including images and text.

## Preview

https://github.com/user-attachments/assets/5b9cf3b3-0013-435a-8389-c461b4ec3402


## Example

Checkout the example directory in this project, and run the main.dart file. 

The Scoreboard can be used as follows:

```dart
Scoreboard(
  rightSectionBackgroundColorWhenScrolled: const Color.fromRGBO(250, 250, 250, 1),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        offset: const Offset(0, 1),
        blurRadius: 1,
      ),
    ],
  ),
  header: const ScoreboardHeader(
    position: ScoreboardHeaderCell(child: Text('#')),
    title: ScoreboardHeaderCell(
      shouldCenter: false,
      child: Text(
        'PLAYER',
        textAlign: TextAlign.left,
      ),
    ),
    dataColumns: [
      ScoreboardHeaderCell(child: Text('MP')),
      ScoreboardHeaderCell(child: Text('W')),
      ScoreboardHeaderCell(child: Text('D')),
      ScoreboardHeaderCell(child: Text('L')),
      ScoreboardHeaderCell(child: Text('TBC')),
    ],
  ),
  rows: [
    ScoreboardRow(
      position: const ScoreboardPositionCell(trendMode: ScoreboardTrendMode.up, child: Text('1')),
      title: ScoreboardTitleCell(
        leading: LogoGroup.withImageUrls(
          const [
            'https://i.pravatar.cc/300?v=1',
            'https://i.pravatar.cc/300?v=2',
          ],
        ),
        title: const Text('Lennard Deurman, Gerard van bode'),
      ),
      dataColumns: const [
        ScoreboardCell(child: Text('10')),
        ScoreboardCell(child: Text('8')),
        ScoreboardCell(child: Text('2')),
        ScoreboardCell(child: Text('1')),
        ScoreboardCell(child: Text('15')),
      ],
    ),
    ScoreboardRow(
      position: const ScoreboardPositionCell(trendMode: ScoreboardTrendMode.down, child: Text('2')),
      title: ScoreboardTitleCell(
        leading: LogoGroup.withImageUrls(
          const [
            'https://i.pravatar.cc/300?v=3',
            'https://i.pravatar.cc/300?v=4',
          ],
        ),
        title: const Text('Bet Geert, Samule Cramer'),
      ),
      dataColumns: const [
        ScoreboardCell(child: Text('9')),
        ScoreboardCell(child: Text('7')),
        ScoreboardCell(child: Text('3')),
        ScoreboardCell(child: Text('2')),
        ScoreboardCell(child: Text('12')),
      ],
    ),
    ScoreboardRow(
      position: const ScoreboardPositionCell(child: Text('3')),
      title: ScoreboardTitleCell(
        leading: LogoGroup.withImageUrls(
          const [
            'https://i.pravatar.cc/300?v=5',
            'https://i.pravatar.cc/300?v=6',
          ],
        ),
        title: const Text('Lars Hansen, Peter Boon'),
      ),
      dataColumns: const [
        ScoreboardCell(child: Text('8')),
        ScoreboardCell(child: Text('6')),
        ScoreboardCell(child: Text('2')),
        ScoreboardCell(child: Text('3')),
        ScoreboardCell(child: Text('10')),
      ],
    ),
    ScoreboardRow(
      position: const ScoreboardPositionCell(trendMode: ScoreboardTrendMode.up, child: Text('4')),
      title: ScoreboardTitleCell(
        leading: LogoGroup.withImageUrls(
          const [
            'https://i.pravatar.cc/300?v=7',
            'https://i.pravatar.cc/300?v=8',
          ],
        ),
        title: const Text('Rik Jansen, Janneke Van Der Velde'),
      ),
      dataColumns: const [
        ScoreboardCell(child: Text('7')),
        ScoreboardCell(child: Text('5')),
        ScoreboardCell(child: Text('1')),
        ScoreboardCell(child: Text('4')),
        ScoreboardCell(child: Text('8')),
      ],
    ),
    ScoreboardRow(
      position: const ScoreboardPositionCell(trendMode: ScoreboardTrendMode.down, child: Text('5')),
      title: ScoreboardTitleCell(
        leading: LogoGroup.withImageUrls(
          const [
            'https://i.pravatar.cc/300?v=9',
            'https://i.pravatar.cc/300?v=10',
          ],
        ),
        title: const Text('Eva De Jong, Koen Stolk'),
      ),
      dataColumns: const [
        ScoreboardCell(child: Text('6')),
        ScoreboardCell(child: Text('4')),
        ScoreboardCell(child: Text('2')),
        ScoreboardCell(child: Text('5')),
        ScoreboardCell(child: Text('7')),
      ],
    ),
    ScoreboardRow(
      position: const ScoreboardPositionCell(child: Text('6')),
      title: ScoreboardTitleCell(
        leading: LogoGroup.withImageUrls(
          const [
            'https://i.pravatar.cc/300?v=11',
            'https://i.pravatar.cc/300?v=12',
          ],
        ),
        title: const Text('Dirk Mulder, Emma Smit'),
      ),
      dataColumns: const [
        ScoreboardCell(child: Text('5')),
        ScoreboardCell(child: Text('3')),
        ScoreboardCell(child: Text('3')),
        ScoreboardCell(child: Text('6')),
        ScoreboardCell(child: Text('6')),
      ],
    ),
    ScoreboardRow(
      position: const ScoreboardPositionCell(trendMode: ScoreboardTrendMode.up, child: Text('7')),
      title: ScoreboardTitleCell(
        leading: LogoGroup.withImageUrls(
          const [
            'https://i.pravatar.cc/300?v=13',
            'https://i.pravatar.cc/300?v=14',
          ],
        ),
        title: const Text('Pieter De Wit, Freek Brouwer'),
      ),
      dataColumns: const [
        ScoreboardCell(child: Text('4')),
        ScoreboardCell(child: Text('3')),
        ScoreboardCell(child: Text('1')),
        ScoreboardCell(child: Text('7')),
        ScoreboardCell(child: Text('5')),
      ],
    ),
    ScoreboardRow(
      position: const ScoreboardPositionCell(trendMode: ScoreboardTrendMode.down, child: Text('8')),
      title: ScoreboardTitleCell(
        leading: LogoGroup.withImageUrls(
          const [
            'https://i.pravatar.cc/300?v=15',
            'https://i.pravatar.cc/300?v=16',
          ],
        ),
        title: const Text('Sander Visser, Kim Vermeer'),
      ),
      dataColumns: const [
        ScoreboardCell(child: Text('3')),
        ScoreboardCell(child: Text('2')),
        ScoreboardCell(child: Text('2')),
        ScoreboardCell(child: Text('8')),
        ScoreboardCell(child: Text('4')),
      ],
    ),
  ],
)
```

## Installation

Add the `scoreboard` package to your `pubspec.yaml` file:

```yaml
dependencies:
  scoreboard: ^1.0.0
