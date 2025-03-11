# Minion Rush Game

A 2D side-scrolling game inspired by Minion Rush, developed entirely in Assembly language. The game features player movement, obstacle generation, collision detection, and a scoring system. Graphics rendering is handled using `Canvas.dll`.

## 🕹️ Features
- Real-time player movement and jumping
- Obstacles (bricks) and collectibles (bananas)
- Collision detection and score tracking
- Simple graphics rendering using `Canvas.dll`
- Keyboard input for gameplay control

## 🚀 Technologies Used
- Assembly Language (x86)
- `Canvas.dll` for rendering graphics
- Custom `.inc` files for sprite data (Minion, bricks, bananas)

## 📁 Folder Structure

"""
/Minion-Rush 
├── test.asm # Main game logic 
├── minion.inc # Minion sprite data 
├── bananas.inc # Collectible sprite data 
├── brick.inc # Obstacle sprite data 
├── digits.inc # Digits sprite data 
├── greenblock.inc # Green block sprite data 
├── letters.inc # Letters sprite data 
├── onebanana.inc # Single banana sprite data 
├── picture.inc # Picture/sprite data 
├── canvas.dll # Graphics library (not included in repo) 
├── canvas.lib # Library file (not included in repo) 
├── README.md # Project documentation 
├── LICENSE # Project license 
└── .gitignore # Git ignore rules
"""


## ⚙️ How to Run the Game
1. Install an x86-compatible assembler (e.g., MASM, TASM, FASM).
2. Place `canvas.dll` in the same directory as your executable.
3. Assemble and link `test.asm`.
4. Run the executable.
5. Use keyboard controls to play the game.

## ❗ Note
- `canvas.dll` and `canvas.lib` are required to run the game but are not included in this repository.
- The project is for educational purposes and demonstrates low-level programming concepts.

## 📜 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
