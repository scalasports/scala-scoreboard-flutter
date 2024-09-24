import 'package:flutter/material.dart';
import 'package:scala_scoreboard/scala_scoreboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scala Scoreboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'The beautiful scoreboard example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Scoreboard(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
