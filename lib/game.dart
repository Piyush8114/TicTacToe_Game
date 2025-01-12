import 'package:complete_flutter_course/Player_name_inut.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  final String player1;
  final String player2;
  Game({super.key, required this.player1, required this.player2});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  var grid = List.filled(9, "-");
  var currentPlayer = ""; // Will be set to player1 at the start
  var winner = "";

  @override
  void initState() {
    super.initState();
    currentPlayer = widget.player1; // Set current player to player1 initially
  }

  void DrawXo(i) {
    if (grid[i] == "-") {
      setState(() {
        grid[i] = currentPlayer == widget.player1 ? "X" : "O";
        currentPlayer = currentPlayer == widget.player1 ? widget.player2 : widget.player1;
      });
      findWinner(grid[i]);
    }
  }

  bool checkValue(i1, i2, i3, sign) {
    return grid[i1] == sign && grid[i2] == sign && grid[i3] == sign;
  }

  void findWinner(currentSign) {
    if (checkValue(0, 1, 2, currentSign) ||
        checkValue(3, 4, 5, currentSign) ||
        checkValue(6, 7, 8, currentSign) || // row
        checkValue(0, 3, 6, currentSign) ||
        checkValue(1, 4, 7, currentSign) ||
        checkValue(2, 5, 8, currentSign) || // column
        checkValue(0, 4, 8, currentSign) ||
        checkValue(2, 4, 6, currentSign)) {
      winner = currentSign == "X" ? widget.player1 : widget.player2;
      ShowDialogBox();
    } else if (!grid.contains("-")) {
      // If no empty cell is left and no winner, it’s a draw
      ShowDrawDialogBox();
    }
  }


  void resetGame() {
    setState(() {
      grid = List.filled(9, "-");
      currentPlayer = widget.player1;
      winner = "";
    });
  }

  void ShowDrawDialogBox() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            'Game Over',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orangeAccent),
          ),
          content: Text(
            'It\'s a Draw!',
            style: TextStyle(fontSize: 20, color: Colors.red),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Re-play', style: TextStyle(color: Colors.blueAccent)),
              onPressed: () {
                resetGame();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Exit', style: TextStyle(color: Colors.blueAccent)),
              onPressed: () {
                resetGame();
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => TwoPlayerScreen(),));
              },
            ),
          ],
        );
      },
    );
  }


  void ShowDialogBox() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            'Congratulations!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),
          ),
          content: Text(
            '$winner has won!',
            style: TextStyle(fontSize: 20, color: Colors.green),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: TextStyle(color: Colors.blueAccent)),
              onPressed: () {
                resetGame();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Exit', style: TextStyle(color: Colors.blueAccent)),
              onPressed: () {
                resetGame();
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => TwoPlayerScreen(),));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Tic Tac Toe",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.cyan],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "${widget.player1.toUpperCase()} ",style: TextStyle(fontSize: 25, color: Colors.green.shade500, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: " VS ",style: TextStyle(fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),
                    ),
                    TextSpan(
                      text: " ${widget.player2.toUpperCase()}",style: TextStyle(fontSize: 25, color: Colors.red.shade500, fontWeight: FontWeight.bold),
                    ),
                  ],
            ),
            ),

                SizedBox(height: 50,),

                Text(
                  winner != "" ? "$winner has won!" : " ${currentPlayer} turn",
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),

                const SizedBox(height: 20),

                GridView.builder(
                  shrinkWrap: true,
                  itemCount: grid.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) => Material(
                    color: grid[index] == "-"
                        ? Colors.white.withOpacity(0.2)
                        : grid[index] == "X"
                        ? Colors.greenAccent
                        : Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () => DrawXo(index),
                      child: Center(
                        child: Text(
                          grid[index],
                          style: const TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: resetGame,
                  label: const Text(
                    "Reset",
                    style: TextStyle(fontSize: 18),
                  ),
                  icon: const Icon(Icons.refresh),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
