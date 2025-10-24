import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Advanced Tic Tac Toe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFA8C69F), // Matcha sage green
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const GameModeSelection(),
    );
  }
}

class GameModeSelection extends StatelessWidget {
  const GameModeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Tic Tac Toe'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xFFEFF5EC), const Color(0xFFD8E5D3)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Choose Game Mode',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2C3E2A),
                ),
              ),
              const SizedBox(height: 40),
              _buildModeCard(
                context,
                'Player vs Player',
                'Play with a friend',
                Icons.people,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PlayerSetupScreen(
                      gameMode: GameMode.playerVsPlayer,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildModeCard(
                context,
                'Player vs AI (Easy)',
                'Play against beginner AI',
                Icons.smart_toy,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PlayerSetupScreen(
                      gameMode: GameMode.playerVsAI,
                      aiDifficulty: AIDifficulty.easy,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildModeCard(
                context,
                'Player vs AI (Hard)',
                'Play against expert AI',
                Icons.psychology,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PlayerSetupScreen(
                      gameMode: GameMode.playerVsAI,
                      aiDifficulty: AIDifficulty.hard,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModeCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFF0),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 40, color: const Color(0xFF6B8F71)),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
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

enum GameMode { playerVsPlayer, playerVsAI }

enum AIDifficulty { easy, hard }

enum BoardSize { small, medium, large }

class PlayerSetupScreen extends StatefulWidget {
  final GameMode gameMode;
  final AIDifficulty aiDifficulty;

  const PlayerSetupScreen({
    super.key,
    required this.gameMode,
    this.aiDifficulty = AIDifficulty.easy,
  });

  @override
  State<PlayerSetupScreen> createState() => _PlayerSetupScreenState();
}

class _PlayerSetupScreenState extends State<PlayerSetupScreen> {
  final TextEditingController _player1Controller = TextEditingController();
  final TextEditingController _player2Controller = TextEditingController();
  BoardSize _selectedSize = BoardSize.small;
  bool _enableTimer = false;
  int _timerSeconds = 30;

  @override
  void dispose() {
    _player1Controller.dispose();
    _player2Controller.dispose();
    super.dispose();
  }

  int _getBoardSize() {
    switch (_selectedSize) {
      case BoardSize.small:
        return 3;
      case BoardSize.medium:
        return 4;
      case BoardSize.large:
        return 5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Setup'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xFFEFF5EC), const Color(0xFFD8E5D3)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              // Player 1 Name
              TextField(
                controller: _player1Controller,
                decoration: InputDecoration(
                  labelText: 'Player 1 Name (X)',
                  hintText: 'Enter player 1 name',
                  prefixIcon: const Icon(Icons.person),
                  filled: true,
                  fillColor: const Color(0xFFFFFFF0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Player 2 Name (if not AI)
              if (widget.gameMode == GameMode.playerVsPlayer)
                TextField(
                  controller: _player2Controller,
                  decoration: InputDecoration(
                    labelText: 'Player 2 Name (O)',
                    hintText: 'Enter player 2 name',
                    prefixIcon: const Icon(Icons.person_outline),
                    filled: true,
                    fillColor: const Color(0xFFFFFFF0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              if (widget.gameMode == GameMode.playerVsPlayer)
                const SizedBox(height: 16),

              // Board Size Selection
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFF0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Board Size',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E2A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SegmentedButton<BoardSize>(
                      segments: const [
                        ButtonSegment(
                          value: BoardSize.small,
                          label: Text('3x3'),
                          icon: Icon(Icons.grid_3x3),
                        ),
                        ButtonSegment(
                          value: BoardSize.medium,
                          label: Text('4x4'),
                          icon: Icon(Icons.grid_4x4),
                        ),
                        ButtonSegment(
                          value: BoardSize.large,
                          label: Text('5x5'),
                          icon: Icon(Icons.grid_on),
                        ),
                      ],
                      selected: {_selectedSize},
                      onSelectionChanged: (Set<BoardSize> newSelection) {
                        setState(() {
                          _selectedSize = newSelection.first;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Timer Settings
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFF0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Enable Timer',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C3E2A),
                          ),
                        ),
                        Switch(
                          value: _enableTimer,
                          onChanged: (value) {
                            setState(() {
                              _enableTimer = value;
                            });
                          },
                        ),
                      ],
                    ),
                    if (_enableTimer) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Time per move: $_timerSeconds seconds',
                        style: const TextStyle(color: Color(0xFF4A6741)),
                      ),
                      Slider(
                        value: _timerSeconds.toDouble(),
                        min: 10,
                        max: 60,
                        divisions: 10,
                        label: '$_timerSeconds s',
                        onChanged: (value) {
                          setState(() {
                            _timerSeconds = value.toInt();
                          });
                        },
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Start Game Button
              ElevatedButton.icon(
                onPressed: () {
                  final player1Name = _player1Controller.text.isEmpty
                      ? 'Player 1'
                      : _player1Controller.text;
                  final player2Name = widget.gameMode == GameMode.playerVsAI
                      ? 'AI'
                      : (_player2Controller.text.isEmpty
                            ? 'Player 2'
                            : _player2Controller.text);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TicTacToeGame(
                        gameMode: widget.gameMode,
                        aiDifficulty: widget.aiDifficulty,
                        boardSize: _getBoardSize(),
                        player1Name: player1Name,
                        player2Name: player2Name,
                        enableTimer: _enableTimer,
                        timerSeconds: _timerSeconds,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Start Game', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B8F71),
                  foregroundColor: const Color(0xFF2C3E2A),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  final GameMode gameMode;
  final AIDifficulty aiDifficulty;
  final int boardSize;
  final String player1Name;
  final String player2Name;
  final bool enableTimer;
  final int timerSeconds;

  const TicTacToeGame({
    super.key,
    required this.gameMode,
    this.aiDifficulty = AIDifficulty.easy,
    this.boardSize = 3,
    this.player1Name = 'Player 1',
    this.player2Name = 'Player 2',
    this.enableTimer = false,
    this.timerSeconds = 30,
  });

  @override
  State<TicTacToeGame> createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame>
    with TickerProviderStateMixin {
  late List<List<String>> board;
  String currentPlayer = 'X';
  late String gameStatus;
  bool gameOver = false;
  List<List<int>>? winningLine;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  // Statistics
  int playerXWins = 0;
  int playerOWins = 0;
  int draws = 0;

  // Game history
  List<List<List<String>>> gameHistory = [];
  int currentMoveIndex = -1;

  // Timer
  Timer? _moveTimer;
  int _remainingTime = 0;

  // Achievements
  int totalGamesPlayed = 0;
  int fastestWin = 0;
  bool soundEnabled = true;

  @override
  void initState() {
    super.initState();
    board = List.generate(
      widget.boardSize,
      (_) => List.generate(widget.boardSize, (_) => ''),
    );
    gameStatus = '${widget.player1Name}\'s turn';
    _remainingTime = widget.timerSeconds;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _saveGameState();
    _loadStats();

    if (widget.enableTimer) {
      _startTimer();
    }
  }

  void _startTimer() {
    _moveTimer?.cancel();
    _remainingTime = widget.timerSeconds;
    _moveTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _handleTimeOut();
        }
      });
    });
  }

  void _handleTimeOut() {
    _moveTimer?.cancel();
    setState(() {
      gameOver = true;
      final winner = currentPlayer == 'X'
          ? widget.player2Name
          : widget.player1Name;
      gameStatus = '$winner wins by timeout!';
      _updateStats(currentPlayer == 'X' ? 'O' : 'X');
    });
  }

  Future<void> _loadStats() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      playerXWins = prefs.getInt('playerXWins') ?? 0;
      playerOWins = prefs.getInt('playerOWins') ?? 0;
      draws = prefs.getInt('draws') ?? 0;
      totalGamesPlayed = prefs.getInt('totalGamesPlayed') ?? 0;
    });
  }

  Future<void> _saveStats() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('playerXWins', playerXWins);
    await prefs.setInt('playerOWins', playerOWins);
    await prefs.setInt('draws', draws);
    await prefs.setInt('totalGamesPlayed', totalGamesPlayed);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _moveTimer?.cancel();
    super.dispose();
  }

  void _makeMove(int row, int col) {
    if (board[row][col].isEmpty && !gameOver) {
      setState(() {
        board[row][col] = currentPlayer;
        _saveGameState();

        // Haptic feedback
        HapticFeedback.lightImpact();

        if (_checkWinner()) {
          final winnerName = currentPlayer == 'X'
              ? widget.player1Name
              : widget.player2Name;
          gameStatus = '$winnerName wins!';
          gameOver = true;
          _moveTimer?.cancel();
          _updateStats(currentPlayer);
          _animationController.forward();
          totalGamesPlayed++;
          _saveStats();
        } else if (_isBoardFull()) {
          gameStatus = 'It\'s a draw!';
          gameOver = true;
          _moveTimer?.cancel();
          _updateStats('draw');
          totalGamesPlayed++;
          _saveStats();
        } else {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
          final playerName = currentPlayer == 'X'
              ? widget.player1Name
              : widget.player2Name;
          gameStatus =
              widget.gameMode == GameMode.playerVsAI && currentPlayer == 'O'
              ? 'AI is thinking...'
              : '$playerName\'s turn';

          // Restart timer for next player
          if (widget.enableTimer) {
            _startTimer();
          }

          // AI move if playing against AI
          if (widget.gameMode == GameMode.playerVsAI &&
              currentPlayer == 'O' &&
              !gameOver) {
            Future.delayed(const Duration(milliseconds: 500), () {
              _makeAIMove();
            });
          }
        }
      });
    }
  }

  void _makeAIMove() {
    if (gameOver) return;

    List<int> move = _getAIMove();
    if (move.isNotEmpty) {
      _makeMove(move[0], move[1]);
    }
  }

  List<int> _getAIMove() {
    if (widget.aiDifficulty == AIDifficulty.easy) {
      return _getRandomMove();
    } else {
      return _getBestMove();
    }
  }

  List<int> _getRandomMove() {
    List<List<int>> emptyCells = [];
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) {
          emptyCells.add([i, j]);
        }
      }
    }
    if (emptyCells.isNotEmpty) {
      return emptyCells[Random().nextInt(emptyCells.length)];
    }
    return [];
  }

  List<int> _getBestMove() {
    // Check for winning move
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) {
          board[i][j] = 'O';
          if (_checkWinner()) {
            board[i][j] = '';
            return [i, j];
          }
          board[i][j] = '';
        }
      }
    }

    // Check for blocking move
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) {
          board[i][j] = 'X';
          if (_checkWinner()) {
            board[i][j] = '';
            return [i, j];
          }
          board[i][j] = '';
        }
      }
    }

    // Prefer center
    if (board[1][1].isEmpty) return [1, 1];

    // Prefer corners
    List<List<int>> corners = [
      [0, 0],
      [0, 2],
      [2, 0],
      [2, 2],
    ];
    for (var corner in corners) {
      if (board[corner[0]][corner[1]].isEmpty) {
        return corner;
      }
    }

    // Random move
    return _getRandomMove();
  }

  void _updateStats(String result) {
    switch (result) {
      case 'X':
        playerXWins++;
        break;
      case 'O':
        playerOWins++;
        break;
      case 'draw':
        draws++;
        break;
    }
  }

  void _saveGameState() {
    List<List<String>> boardCopy = List.generate(
      3,
      (i) => List.generate(3, (j) => board[i][j]),
    );
    gameHistory.add(boardCopy);
    currentMoveIndex = gameHistory.length - 1;
  }

  bool _checkWinner() {
    final size = widget.boardSize;

    // Check rows
    for (int i = 0; i < size; i++) {
      bool rowWin = true;
      for (int j = 1; j < size; j++) {
        if (board[i][0].isEmpty || board[i][0] != board[i][j]) {
          rowWin = false;
          break;
        }
      }
      if (rowWin && board[i][0].isNotEmpty) {
        winningLine = List.generate(size, (j) => [i, j]);
        return true;
      }
    }

    // Check columns
    for (int j = 0; j < size; j++) {
      bool colWin = true;
      for (int i = 1; i < size; i++) {
        if (board[0][j].isEmpty || board[0][j] != board[i][j]) {
          colWin = false;
          break;
        }
      }
      if (colWin && board[0][j].isNotEmpty) {
        winningLine = List.generate(size, (i) => [i, j]);
        return true;
      }
    }

    // Check main diagonal
    bool mainDiagWin = true;
    for (int i = 1; i < size; i++) {
      if (board[0][0].isEmpty || board[0][0] != board[i][i]) {
        mainDiagWin = false;
        break;
      }
    }
    if (mainDiagWin && board[0][0].isNotEmpty) {
      winningLine = List.generate(size, (i) => [i, i]);
      return true;
    }

    // Check anti-diagonal
    bool antiDiagWin = true;
    for (int i = 1; i < size; i++) {
      if (board[0][size - 1].isEmpty ||
          board[0][size - 1] != board[i][size - 1 - i]) {
        antiDiagWin = false;
        break;
      }
    }
    if (antiDiagWin && board[0][size - 1].isNotEmpty) {
      winningLine = List.generate(size, (i) => [i, size - 1 - i]);
      return true;
    }

    return false;
  }

  bool _isBoardFull() {
    for (int i = 0; i < widget.boardSize; i++) {
      for (int j = 0; j < widget.boardSize; j++) {
        if (board[i][j].isEmpty) {
          return false;
        }
      }
    }
    return true;
  }

  void _resetGame() {
    setState(() {
      board = List.generate(
        widget.boardSize,
        (_) => List.generate(widget.boardSize, (_) => ''),
      );
      currentPlayer = 'X';
      gameStatus = '${widget.player1Name}\'s turn';
      gameOver = false;
      winningLine = null;
      gameHistory.clear();
      currentMoveIndex = -1;
      _animationController.reset();
      _saveGameState();

      if (widget.enableTimer) {
        _startTimer();
      }
    });
  }

  void _undoMove() {
    if (currentMoveIndex > 0) {
      setState(() {
        currentMoveIndex--;
        board = List.generate(
          3,
          (i) => List.generate(3, (j) => gameHistory[currentMoveIndex][i][j]),
        );
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        gameOver = false;
        winningLine = null;
        gameStatus = widget.gameMode == GameMode.playerVsAI
            ? 'Your turn'
            : 'Player $currentPlayer\'s turn';
        _animationController.reset();
      });
    }
  }

  void _showStats() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Statistics'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildStatRow(
              'Player X Wins',
              playerXWins,
              const Color(0xFF2C3E2A),
            ),
            _buildStatRow(
              'Player O Wins',
              playerOWins,
              const Color(0xFF3A5037),
            ),
            _buildStatRow('Draws', draws, const Color(0xFF4A6741)),
            const SizedBox(height: 16),
            Text(
              'Total Games: ${playerXWins + playerOWins + draws}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                playerXWins = 0;
                playerOWins = 0;
                draws = 0;
              });
              Navigator.pop(context);
            },
            child: const Text('Reset Stats'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, int value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.gameMode == GameMode.playerVsAI
              ? 'Tic Tac Toe vs AI'
              : 'Tic Tac Toe',
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _showStats,
            icon: const Icon(Icons.analytics),
            tooltip: 'Statistics',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xFFEFF5EC), const Color(0xFFD8E5D3)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Game Status
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 30),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFF0),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    gameStatus,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: gameOver
                          ? (gameStatus.contains('wins')
                                ? const Color(0xFF2C3E2A)
                                : const Color(0xFF3A5037))
                          : const Color(0xFF2C3E2A),
                    ),
                  ),
                ),

                // Timer Display
                if (widget.enableTimer && !gameOver)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: _remainingTime < 10
                          ? const Color(0xFFFF6B6B).withValues(alpha: 0.2)
                          : const Color(0xFFFFFFF0),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _remainingTime < 10
                            ? const Color(0xFFFF6B6B)
                            : const Color(0xFFA8C69F),
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.timer,
                          color: _remainingTime < 10
                              ? const Color(0xFFFF6B6B)
                              : const Color(0xFF6B8F71),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Time: $_remainingTime s',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _remainingTime < 10
                                ? const Color(0xFFFF6B6B)
                                : const Color(0xFF2C3E2A),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Game Board
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFF0),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: List.generate(widget.boardSize, (row) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(widget.boardSize, (col) {
                          bool isWinningCell =
                              winningLine != null &&
                              winningLine!.any(
                                (pos) => pos[0] == row && pos[1] == col,
                              );

                          return GestureDetector(
                            onTap: () => _makeMove(row, col),
                            child: AnimatedBuilder(
                              animation: _scaleAnimation,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: isWinningCell
                                      ? _scaleAnimation.value
                                      : 1.0,
                                  child: Container(
                                    width: widget.boardSize <= 3
                                        ? 80.0
                                        : (widget.boardSize == 4 ? 65.0 : 50.0),
                                    height: widget.boardSize <= 3
                                        ? 80.0
                                        : (widget.boardSize == 4 ? 65.0 : 50.0),
                                    margin: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: isWinningCell
                                          ? const Color(0xFFF4C2A5)
                                          : board[row][col].isEmpty
                                          ? const Color(0xFF7FA86F)
                                          : (board[row][col] == 'X'
                                                ? const Color(0xFFA8C69F)
                                                : const Color(0xFFE8F0E3)),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isWinningCell
                                            ? const Color(0xFFF4C2A5)
                                            : const Color(0xFFE8F0E3),
                                        width: isWinningCell ? 3 : 2,
                                      ),
                                    ),
                                    child: Center(
                                      child: AnimatedSwitcher(
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                        child: Text(
                                          board[row][col],
                                          key: ValueKey(board[row][col]),
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: board[row][col] == 'X'
                                                ? const Color(0xFF2C3E2A)
                                                : const Color(0xFF3A5037),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                      );
                    }),
                  ),
                ),

                const SizedBox(height: 30),

                // Control Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Undo Button
                    ElevatedButton.icon(
                      onPressed: currentMoveIndex > 0 ? _undoMove : null,
                      icon: const Icon(Icons.undo),
                      label: const Text('Undo'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA8C69F),
                        foregroundColor: const Color(0xFF2C3E2A),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 5,
                      ),
                    ),

                    // New Game Button
                    ElevatedButton.icon(
                      onPressed: _resetGame,
                      icon: const Icon(Icons.refresh),
                      label: const Text('New Game'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6B8F71),
                        foregroundColor: const Color(0xFF2C3E2A),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 5,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Statistics Summary
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7FA86F).withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildQuickStat(
                        'X',
                        playerXWins,
                        const Color(0xFF2C3E2A),
                      ),
                      _buildQuickStat(
                        'O',
                        playerOWins,
                        const Color(0xFF3A5037),
                      ),
                      _buildQuickStat('Draw', draws, const Color(0xFF4A6741)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStat(String label, int value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
