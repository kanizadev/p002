# 🎮 Advanced Tic Tac Toe Game

A sophisticated Flutter implementation of the classic Tic Tac Toe game with modern UI, AI opponents, multiple board sizes, timer challenges, and advanced features.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

## ✨ Features

### 🎯 Game Modes
- **Player vs Player**: Traditional two-player gameplay with custom names
- **Player vs AI (Easy)**: Beginner AI with random moves
- **Player vs AI (Hard)**: Expert AI with strategic gameplay using minimax-inspired algorithm

### 📏 Multiple Board Sizes
- **3x3 Classic**: Traditional Tic Tac Toe experience
- **4x4 Medium**: Increased challenge and strategy
- **5x5 Expert**: Advanced gameplay for serious players
- Dynamic board rendering that adapts to size
- Smart win detection for all board sizes

### ⏱️ Game Timer System
- **Optional Timer**: Enable/disable per game
- **Adjustable Duration**: 10-60 seconds per move
- **Visual Countdown**: Real-time timer display
- **Color Warning**: Red alert when time is low (<10 seconds)
- **Timeout Handling**: Automatic win for opponent on timeout
- **Auto-Reset**: Timer resets after each move

### 👥 Player Customization
- **Custom Names**: Personalize player identities
- **Profile Setup**: Pre-game configuration screen
- **Player Display**: Names shown throughout gameplay
- **AI Naming**: Clear AI opponent identification

### 🤖 Intelligent AI System
- **Easy AI**: Makes random moves for casual play
- **Hard AI**: Advanced strategy including:
  - Prioritizes winning moves
  - Blocks opponent's winning moves
  - Prefers center and corner positions
  - Strategic placement for optimal gameplay
  - Adapts to all board sizes

### 📊 Statistics & Tracking
- **Persistent Storage**: Stats saved across sessions
- **Real-time Score Tracking**: Wins, losses, and draws
- **Detailed Statistics Dialog**: Complete game history
- **Quick Stats Display**: Live score summary at bottom
- **Total Games Counter**: Lifetime game tracking
- **Reset Statistics**: Clear all data option

### 🎨 Modern UI Design
- **Matcha Sage Green Theme**: Calming, natural aesthetic with dark fonts
- **Creamy Backgrounds**: Soft ivory and sage tones
- **Material Design 3**: Modern Flutter design principles
- **Smooth Animations**: Elastic scaling effects for winning cells
- **Responsive Layout**: Adapts to all screen sizes
- **Dark Readable Fonts**: Excellent contrast and readability

### 🎮 Advanced Gameplay
- **Undo Functionality**: Take back moves during gameplay
- **Game History**: Complete move tracking
- **Replay Capability**: Review game moves
- **Haptic Feedback**: Tactile response on moves
- **Smart Game Status**: Context-aware status messages with player names
- **Winning Detection**: Enhanced with line highlighting
- **Dynamic Cell Sizing**: Adapts to board size (80px for 3x3, 65px for 4x4, 50px for 5x5)

### ⚙️ User Experience
- **Game Mode Selection**: Beautiful menu with mode cards
- **Player Setup Screen**: Configure game before starting
- **Board Size Selector**: Segmented button for easy selection
- **Timer Controls**: Slider for precise time adjustment
- **Intuitive Navigation**: Smooth transitions between screens
- **Statistics Access**: Quick stats button in app bar
- **Settings Toggle**: Enable/disable timer easily


## 🎮 How to Play

### Starting a Game

1. **Choose Game Mode**: Select Player vs Player or AI difficulty
2. **Enter Player Names**: Customize player identities (optional)
3. **Select Board Size**: Choose 3x3, 4x4, or 5x5
4. **Enable Timer** (Optional): Set time limit per move (10-60 seconds)
5. **Start Game**: Begin playing!

### During the Game

- **Make Moves**: Tap empty cells to place your mark
- **Watch Timer**: Keep an eye on the countdown if enabled
- **View Status**: Game status shows current player's turn
- **Check Stats**: View live win/loss counts at bottom

### Winning

- Get all marks in a row (horizontally, vertically, or diagonally)
- Win by timeout if opponent runs out of time
- Winning line highlights in peachy cream color
- Statistics automatically update and save

### Additional Features

- **Undo**: Tap the Undo button to take back moves
- **New Game**: Start fresh anytime
- **Statistics**: View detailed game history via analytics icon
- **Back Navigation**: Return to setup or mode selection


## 🎨 Customization

### Changing Colors

The app uses a matcha sage green color scheme. To customize:

**Seed Color**: Modify in `TicTacToeApp`:
```dart
seedColor: const Color(0xFFA8C69F) // Matcha sage green
```

**Background Gradients**:
```dart
colors: [const Color(0xFFEFF5EC), const Color(0xFFD8E5D3)]
```

**Card Backgrounds**:
```dart
color: const Color(0xFFFFFFF0) // Ivory cream
```

**Text Colors**:
```dart
color: const Color(0xFF2C3E2A) // Dark green (main)
color: const Color(0xFF3A5037) // Dark olive (secondary)
```

### Adding New Features

- **Sound Effects**: Audioplayers package already integrated
- **More Board Sizes**: Extend `BoardSize` enum
- **Custom Themes**: Implement theme selector
- **Online Multiplayer**: Add networking layer
- **Achievements**: Expand existing achievement system

## 📱 Screenshots

| Mode Selection | Player Setup | Game Board (3x3) |
|----------------|--------------|------------------|
| ![Mode](screenshots/mode-selection.png) | ![Setup](screenshots/player-setup.png) | ![Game](screenshots/game-3x3.png) |

| Game Board (4x4) | Game Board (5x5) | Timer Warning |
|------------------|------------------|---------------|
| ![4x4](screenshots/game-4x4.png) | ![5x5](screenshots/game-5x5.png) | ![Timer](screenshots/timer-warning.png) |

| Statistics | Winning Animation | AI Gameplay |
|------------|-------------------|-------------|
| ![Stats](screenshots/statistics.png) | ![Win](screenshots/winning.png) | ![AI](screenshots/ai-game.png) |


## 📞 Support

If you have any questions or run into issues:

1. Check the [Issues](https://github.com/kanizadev/p002/issues) page
2. Create a new issue with detailed information
3. Contact the maintainers

### Version 1.0.0 
- ✨ Added multiple board sizes (3x3, 4x4, 5x5)
- ✨ Implemented game timer system
- ✨ Added player name customization
- ✨ Created player setup screen
- ✨ Persistent statistics with SharedPreferences
- ✨ Enhanced UI with matcha sage green theme
- ✨ Dynamic cell sizing
- ✨ Timeout win conditions
- 🐛 Fixed win detection for all board sizes
- 🎨 Improved color contrast and readability

**Made with ❤️ and ☕ using Flutter**

⭐ Star this repository if you found it helpful!

🍵 Enjoy your matcha-themed Tic Tac Toe experience!
