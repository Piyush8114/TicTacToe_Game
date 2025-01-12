import 'package:complete_flutter_course/game.dart';
import 'package:flutter/material.dart';

class TwoPlayerScreen extends StatefulWidget {
  @override
  _TwoPlayerScreenState createState() => _TwoPlayerScreenState();
}

class _TwoPlayerScreenState extends State<TwoPlayerScreen> {
  final TextEditingController player1Controller = TextEditingController();
  final TextEditingController player2Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.pinkAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),

                // Title or Logo
                Icon(Icons.sports_esports, size: 80, color: Colors.white),
                const SizedBox(height: 40),
                Text(
                  'Enter Player Names',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Let the game begin!',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 40),

                // Player input form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Player 1 input
                      TextFormField(
                        controller: player1Controller,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Player 1 Name',
                          prefixIcon: Icon(Icons.person, color: Colors.white),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Player 1 name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Player 2 input
                      TextFormField(
                        controller: player2Controller,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Player 2 Name',
                          prefixIcon: Icon(Icons.person, color: Colors.white),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Player 2 name';
                            } else if (player1Controller.text.trim() == player2Controller.text.trim()) {
                              return 'Names must be unique'; // Return an error message
                            }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),

                      // Start Game Button
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              String player1 = player1Controller.text;
                              String player2 = player2Controller.text;

                              // Navigate to the game screen (replace with your actual game screen)
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Game(
                                    player1: player1,
                                    player2: player2,
                                  ),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.all(16),
                          ),
                          child: Text(
                            'Start Game',
                            style: TextStyle(
                              color: Colors.purpleAccent,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
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
}

// Game Screen (example placeholder for game screen)
class GameScreen extends StatelessWidget {
  final String player1;
  final String player2;

  GameScreen({required this.player1, required this.player2});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Screen'),
      ),
      body: Center(
        child: Text('Player 1: $player1 vs Player 2: $player2'),
      ),
    );
  }
}
