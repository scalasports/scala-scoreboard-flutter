import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'package:scala_scoreboard/scala_scoreboard.dart';

class TestScoreboard extends StatefulWidget {
  const TestScoreboard({super.key});

  @override
  State<TestScoreboard> createState() => TestScoreboardState();
}

class TestScoreboardState extends State<TestScoreboard> {
  Color? _leftSectionBackgroundColor = Colors.lightBlue;
  Color? _rightSectionBackgroundColor = Colors.lightGreen;
  Color? _rightSectionBackgroundColorWhenScrolled = Colors.grey;
  bool _applyShadowWhenScrolled = true;
  Color _shadowColorWhenScrolled = const Color.fromRGBO(245, 245, 245, 1);
  double _shadowBlurWhenScrolled = 1;
  double _dividerWidth = 1;
  Color _dividerColor = const Color.fromRGBO(230, 230, 230, 1);
  bool _skipDividerForHeader = false;

  ScoreboardHeader _header = const ScoreboardHeader(
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
  );

  List<ScoreboardRow> _rows = const [
    ScoreboardRow(
      position: ScoreboardPositionCell(trendMode: ScoreboardTrendMode.up, child: Text('1')),
      title: ScoreboardTitleCell(
        leading: LogoGroup(
          children: [
            CircleAvatar(
              radius: 15,
              child: ColoredBox(color: Colors.red),
            ),
            CircleAvatar(
              radius: 15,
              child: ColoredBox(color: Colors.red),
            ),
          ],
        ),
        title: Text('Lennard Deurman, Gerard van bode'),
      ),
      dataColumns: [
        ScoreboardCell(child: Text('10')),
        ScoreboardCell(child: Text('8')),
        ScoreboardCell(child: Text('2')),
        ScoreboardCell(child: Text('1')),
        ScoreboardCell(child: Text('15')),
      ],
    ),
    ScoreboardRow(
      position: ScoreboardPositionCell(trendMode: ScoreboardTrendMode.down, child: Text('2')),
      title: ScoreboardTitleCell(
        leading: LogoGroup(
          children: [
            CircleAvatar(
              radius: 15,
              child: ColoredBox(color: Colors.red),
            ),
            CircleAvatar(
              radius: 15,
              child: ColoredBox(color: Colors.red),
            ),
          ],
        ),
        title: Text('Bet Geert, Samule Cramer'),
      ),
      dataColumns: [
        ScoreboardCell(child: Text('9')),
        ScoreboardCell(child: Text('7')),
        ScoreboardCell(child: Text('3')),
        ScoreboardCell(child: Text('2')),
        ScoreboardCell(child: Text('12')),
      ],
    ),
    ScoreboardRow(
      position: ScoreboardPositionCell(child: Text('3')),
      title: ScoreboardTitleCell(
        leading: LogoGroup(
          children: [
            CircleAvatar(
              radius: 15,
              child: ColoredBox(color: Colors.red),
            ),
            CircleAvatar(
              radius: 15,
              child: ColoredBox(color: Colors.red),
            ),
          ],
        ),
        title: Text('Lars Hansen, Peter Boon'),
      ),
      dataColumns: [
        ScoreboardCell(child: Text('8')),
        ScoreboardCell(child: Text('6')),
        ScoreboardCell(child: Text('2')),
        ScoreboardCell(child: Text('3')),
        ScoreboardCell(child: Text('10')),
      ],
    ),
    ScoreboardRow(
      position: ScoreboardPositionCell(trendMode: ScoreboardTrendMode.up, child: Text('4')),
      title: ScoreboardTitleCell(
        leading: LogoGroup(
          children: [
            CircleAvatar(
              radius: 15,
              child: ColoredBox(color: Colors.red),
            ),
            CircleAvatar(
              radius: 15,
              child: ColoredBox(color: Colors.red),
            ),
          ],
        ),
        title: Text('Rik Jansen, Janneke Van Der Velde'),
      ),
      dataColumns: [
        ScoreboardCell(child: Text('7')),
        ScoreboardCell(child: Text('5')),
        ScoreboardCell(child: Text('1')),
        ScoreboardCell(child: Text('4')),
        ScoreboardCell(child: Text('8')),
      ],
    ),
    ScoreboardRow(
      position: ScoreboardPositionCell(trendMode: ScoreboardTrendMode.down, child: Text('5')),
      title: ScoreboardTitleCell(
        leading: LogoGroup(
          children: [
            CircleAvatar(
              radius: 15,
              child: ColoredBox(color: Colors.red),
            ),
            CircleAvatar(
              radius: 15,
              child: ColoredBox(color: Colors.red),
            ),
          ],
        ),
        title: Text('Eva De Jong, Koen Stolk'),
      ),
      dataColumns: [
        ScoreboardCell(child: Text('6')),
        ScoreboardCell(child: Text('4')),
        ScoreboardCell(child: Text('2')),
        ScoreboardCell(child: Text('5')),
        ScoreboardCell(child: Text('7')),
      ],
    ),
    ScoreboardRow(
      position: ScoreboardPositionCell(child: Text('6')),
      title: ScoreboardTitleCell(
        leading: LogoGroup(
          children: [
            CircleAvatar(
              radius: 15,
              child: ColoredBox(color: Colors.red),
            ),
            CircleAvatar(
              radius: 15,
              child: ColoredBox(color: Colors.red),
            ),
          ],
        ),
        title: Text('Dirk Mulder, Emma Smit'),
      ),
      dataColumns: [
        ScoreboardCell(child: Text('5')),
        ScoreboardCell(child: Text('3')),
        ScoreboardCell(child: Text('3')),
        ScoreboardCell(child: Text('6')),
        ScoreboardCell(child: Text('6')),
      ],
    ),
    ScoreboardRow(
      position: ScoreboardPositionCell(trendMode: ScoreboardTrendMode.up, child: Text('7')),
      title: ScoreboardTitleCell(
        leading: LogoGroup(
          children: [
            CircleAvatar(
              radius: 15,
              child: ColoredBox(color: Colors.red),
            ),
            CircleAvatar(
              radius: 15,
              child: ColoredBox(color: Colors.red),
            ),
          ],
        ),
        title: Text('Pieter De Wit, Freek Brouwer'),
      ),
      dataColumns: [
        ScoreboardCell(child: Text('4')),
        ScoreboardCell(child: Text('3')),
        ScoreboardCell(child: Text('1')),
        ScoreboardCell(child: Text('7')),
        ScoreboardCell(child: Text('5')),
      ],
    ),
    ScoreboardRow(
      position: ScoreboardPositionCell(trendMode: ScoreboardTrendMode.down, child: Text('8')),
      title: ScoreboardTitleCell(
        leading: LogoGroup(
          children: [
            CircleAvatar(
              radius: 15,
              child: ColoredBox(color: Colors.red),
            ),
            CircleAvatar(
              radius: 15,
              child: ColoredBox(color: Colors.red),
            ),
          ],
        ),
        title: Text('Sander Visser, Kim Vermeer'),
      ),
      dataColumns: [
        ScoreboardCell(child: Text('3')),
        ScoreboardCell(child: Text('2')),
        ScoreboardCell(child: Text('2')),
        ScoreboardCell(child: Text('8')),
        ScoreboardCell(child: Text('4')),
      ],
    ),
  ];

  Color? get leftSectionBackgroundColor => _leftSectionBackgroundColor;
  set leftSectionBackgroundColor(Color? value) {
    setState(() => _leftSectionBackgroundColor = value);
  }

  Color? get rightSectionBackgroundColor => _rightSectionBackgroundColor;
  set rightSectionBackgroundColor(Color? value) {
    setState(() => _rightSectionBackgroundColor = value);
  }

  Color? get rightSectionBackgroundColorWhenScrolled => _rightSectionBackgroundColorWhenScrolled;
  set rightSectionBackgroundColorWhenScrolled(Color? value) {
    setState(() => _rightSectionBackgroundColorWhenScrolled = value);
  }

  bool get applyShadowWhenScrolled => _applyShadowWhenScrolled;
  set applyShadowWhenScrolled(bool value) {
    setState(() => _applyShadowWhenScrolled = value);
  }

  Color get shadowColorWhenScrolled => _shadowColorWhenScrolled;
  set shadowColorWhenScrolled(Color value) {
    setState(() => _shadowColorWhenScrolled = value);
  }

  double get shadowBlurWhenScrolled => _shadowBlurWhenScrolled;
  set shadowBlurWhenScrolled(double value) {
    setState(() => _shadowBlurWhenScrolled = value);
  }

  double get dividerWidth => _dividerWidth;
  set dividerWidth(double value) {
    setState(() => _dividerWidth = value);
  }

  Color get dividerColor => _dividerColor;
  set dividerColor(Color value) {
    setState(() => _dividerColor = value);
  }

  bool get skipDividerForHeader => _skipDividerForHeader;
  set skipDividerForHeader(bool value) {
    setState(() => _skipDividerForHeader = value);
  }

  ScoreboardHeader get header => _header;
  set header(ScoreboardHeader value) {
    setState(() => _header = value);
  }

  List<ScoreboardRow> get rows => _rows;
  set rows(List<ScoreboardRow> value) {
    setState(() => _rows = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scoreboard(
      header: _header,
      rows: _rows,
      leftSectionBackgroundColor: _leftSectionBackgroundColor,
      rightSectionBackgroundColor: _rightSectionBackgroundColor,
      rightSectionBackgroundColorWhenScrolled: _rightSectionBackgroundColorWhenScrolled,
      applyShadowWhenScrolled: _applyShadowWhenScrolled,
      shadowColorWhenScrolled: _shadowColorWhenScrolled,
      shadowBlurWhenScrolled: _shadowBlurWhenScrolled,
      dividerWidth: _dividerWidth,
      dividerColor: _dividerColor,
      skipDividerForHeader: _skipDividerForHeader,
    );
  }
}


void main() {
  late GlobalKey<TestScoreboardState> testScoreboardKey;

  setUp(() {
    testScoreboardKey = GlobalKey<TestScoreboardState>();
  });

  Future<void> buildWidgetUnderTest(WidgetTester tester) async {
    // Build the scoreboard widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TestScoreboard(key: testScoreboardKey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('Scoreboard widget renders correctly', (tester) async {
    await buildWidgetUnderTest(tester);

    // Run a pumpAndSettle.
    await tester.pumpAndSettle();

    // Check if the Scoreboard is displayed
    expect(find.byType(Scoreboard), findsOneWidget);

    // Check if the header titles are displayed correctly
    expect(find.text('PLAYER'), findsOneWidget);
    expect(find.text('MP'), findsOneWidget);
    expect(find.text('W'), findsOneWidget);
    expect(find.text('D'), findsOneWidget);
    expect(find.text('L'), findsOneWidget);
    expect(find.text('TBC'), findsOneWidget);

    // List of expected player names
    final List<String> playerNames = [
      'Lennard Deurman, Gerard van bode',
      'Bet Geert, Samule Cramer',
      'Lars Hansen, Peter Boon',
      'Rik Jansen, Janneke Van Der Velde',
      'Eva De Jong, Koen Stolk',
      'Dirk Mulder, Emma Smit',
      'Pieter De Wit, Freek Brouwer',
      'Sander Visser, Kim Vermeer',
    ];

    // Check if all player names are displayed correctly
    for (final name in playerNames) {
      expect(find.text(name), findsOneWidget);
    }
  });

  testWidgets('Scoreboard should be scrollable', (tester) async {
    await buildWidgetUnderTest(tester);

    // Attempt to scroll horizontally
    await tester.drag(find.byType(SingleChildScrollView), const Offset(-300, 0)); // Drag left
    await tester.pumpAndSettle(); // Allow the scroll to finish

    // Check if the first player name is still visible after scrolling
    expect(find.text('Lennard Deurman, Gerard van bode'), findsOneWidget);
  });

  group('Test changing properties, and updateRenderObject', () {
    testWidgets('Divider color changes', (tester) async {
      await buildWidgetUnderTest(tester);

      // Change the divider color
      testScoreboardKey.currentState?.dividerColor = Colors.blue;
      await tester.pumpAndSettle();

      // Verify the change
      expect(testScoreboardKey.currentState?.dividerColor, Colors.blue);
    });

    testWidgets('Shadow color when scrolled changes', (tester) async {
      await buildWidgetUnderTest(tester);

      // Change the shadow color when scrolled
      testScoreboardKey.currentState?.shadowColorWhenScrolled = Colors.red;
      await tester.pumpAndSettle();

      // Verify the change
      expect(testScoreboardKey.currentState?.shadowColorWhenScrolled, Colors.red);
    });

    testWidgets('Shadow blur when scrolled changes', (tester) async {
      await buildWidgetUnderTest(tester);

      // Change the shadow blur when scrolled
      testScoreboardKey.currentState?.shadowBlurWhenScrolled = 2.0;
      await tester.pumpAndSettle();

      // Verify the change
      expect(testScoreboardKey.currentState?.shadowBlurWhenScrolled, 2.0);
    });

    testWidgets('Apply shadow when scrolled changes', (tester) async {
      await buildWidgetUnderTest(tester);

      // Change the apply shadow when scrolled property
      testScoreboardKey.currentState?.applyShadowWhenScrolled = false;
      await tester.pumpAndSettle();

      // Verify the change
      expect(testScoreboardKey.currentState?.applyShadowWhenScrolled, false);
    });

    testWidgets('Left section background color changes', (tester) async {
      await buildWidgetUnderTest(tester);

      // Change the left section background color
      testScoreboardKey.currentState?.leftSectionBackgroundColor = Colors.yellow;
      await tester.pumpAndSettle();

      // Verify the change
      expect(testScoreboardKey.currentState?.leftSectionBackgroundColor, Colors.yellow);
    });

    testWidgets('Right section background color changes', (tester) async {
      await buildWidgetUnderTest(tester);

      // Change the right section background color
      testScoreboardKey.currentState?.rightSectionBackgroundColor = Colors.orange;
      await tester.pumpAndSettle();

      // Verify the change
      expect(testScoreboardKey.currentState?.rightSectionBackgroundColor, Colors.orange);
    });

    testWidgets('Right section background color when scrolled changes', (tester) async {
      await buildWidgetUnderTest(tester);

      // Change the right section background color when scrolled
      testScoreboardKey.currentState?.rightSectionBackgroundColorWhenScrolled = Colors.purple;
      await tester.pumpAndSettle();

      // Verify the change
      expect(testScoreboardKey.currentState?.rightSectionBackgroundColorWhenScrolled, Colors.purple);
    });

    testWidgets('Divider width changes', (tester) async {
      await buildWidgetUnderTest(tester);

      // Change the divider width
      testScoreboardKey.currentState?.dividerWidth = 2.0;
      await tester.pumpAndSettle();

      // Verify the change
      expect(testScoreboardKey.currentState?.dividerWidth, 2.0);
    });

    testWidgets('Skip divider for header changes', (tester) async {
      await buildWidgetUnderTest(tester);

      // Change the skip divider for header property
      testScoreboardKey.currentState?.skipDividerForHeader = true;
      await tester.pumpAndSettle();

      // Verify the change
      expect(testScoreboardKey.currentState?.skipDividerForHeader, true);
    });

    testWidgets('Rows and header changes', (tester) async {
      await buildWidgetUnderTest(tester);

      // Change the rows
      testScoreboardKey.currentState?.header = const ScoreboardHeader(
        position: ScoreboardHeaderCell(child: Text('#')),
        title: ScoreboardHeaderCell(child: Text('NEW PLAYER', textAlign: TextAlign.left)),
        dataColumns: [
          ScoreboardHeaderCell(child: Text('NEW MP')),
          ScoreboardHeaderCell(child: Text('NEW W')),
        ],
      );

      testScoreboardKey.currentState?.rows = const [
        ScoreboardRow(
          position: ScoreboardPositionCell(child: Text('1')),
          title: ScoreboardTitleCell(title: Text('LENNARD DEURMAN')),
          dataColumns: [
            ScoreboardCell(child: Text('0')),
            ScoreboardCell(child: Text('0')),
          ],
        ),
      ];
      await tester.pumpAndSettle();

      // Verify the change
      expect(find.text('NEW PLAYER'), findsOneWidget);
      expect(find.text('NEW MP'), findsOneWidget);
      expect(find.text('NEW W'), findsOneWidget);
    });
  });

  group('Golden tests for Scoreboard', () {
    testGoldens('Scoreboard renders correctly', (tester) async {
      await buildWidgetUnderTest(tester);
      await screenMatchesGolden(tester, 'scala_scoreboard');
    });

    testGoldens('Scoreboard (Scrolled) renders correctly', (tester) async {
      await buildWidgetUnderTest(tester);

      // Attempt to scroll horizontally
      await tester.drag(find.byType(SingleChildScrollView), const Offset(-300, 0)); // Drag left
      await tester.pumpAndSettle(); // Allow the scroll to finish

      await screenMatchesGolden(tester, 'scala_scoreboard_scrolled');
    });
  });

}

