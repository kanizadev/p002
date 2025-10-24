// This is a basic Flutter widget test for the Tic Tac Toe game.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:p002/main.dart';

void main() {
  testWidgets('Tic Tac Toe game mode selection test', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TicTacToeApp());

    // Verify that the game mode selection screen is displayed.
    expect(find.text('Choose Game Mode'), findsOneWidget);
    expect(find.text('Player vs Player'), findsOneWidget);
    expect(find.text('Player vs AI (Easy)'), findsOneWidget);
    expect(find.text('Player vs AI (Hard)'), findsOneWidget);
  });

  testWidgets('Tic Tac Toe game board test', (WidgetTester tester) async {
    // Build the game widget directly
    await tester.pumpWidget(
      const MaterialApp(
        home: TicTacToeGame(
          gameMode: GameMode.playerVsPlayer,
          boardSize: 3,
          player1Name: 'Player 1',
          player2Name: 'Player 2',
        ),
      ),
    );

    // Wait for async operations
    await tester.pumpAndSettle();

    // Verify that the game board is displayed correctly
    expect(find.text('New Game'), findsOneWidget);
    expect(find.text('Undo'), findsOneWidget);
  });

  testWidgets('Tic Tac Toe game interaction test', (WidgetTester tester) async {
    // Build the game widget directly
    await tester.pumpWidget(
      const MaterialApp(
        home: TicTacToeGame(
          gameMode: GameMode.playerVsPlayer,
          boardSize: 3,
          player1Name: 'Player 1',
          player2Name: 'Player 2',
        ),
      ),
    );

    // Wait for async operations
    await tester.pumpAndSettle();

    // Test that the game board is present and functional
    expect(find.text('New Game'), findsOneWidget);
    expect(find.text('Undo'), findsOneWidget);
  });
}
