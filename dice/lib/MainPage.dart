import 'dart:math';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: const Dices(),
    );
  }
}

class Dices extends StatefulWidget {
  const Dices({Key? key}) : super(key: key);

  @override
  _DicesState createState() => _DicesState();
}

class _DicesState extends State<Dices> {

  Random random = Random();

  final Map dices = {
    1: 'Dice/dice1.png',
    2: 'Dice/dice2.png',
    3: 'Dice/dice3.png',
    4: 'Dice/dice4.png',
    5: 'Dice/dice5.png',
    6: 'Dice/dice6.png',
  };

  List<String> currentDices = [];

  void newPair() {
    currentDices = [];
    setState(() {
      currentDices.add(dices[random.nextInt(dices.length)]);
      currentDices.add(dices[random.nextInt(dices.length)]);
    });
  }

  Widget optionalButton() {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 50,
      ),
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.width / 10,
      child: MaterialButton(
        color: Colors.blueAccent[200],
        elevation: 10,
        hoverColor: Colors.black12,
        child: Text(
          (currentDices.isEmpty) ? 'Roll the dices!' : 'Next',
          style: const TextStyle(fontSize: 20),
        ),
        onPressed: newPair,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (currentDices.isEmpty)
              ? const SizedBox(
                  height: 0,
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        margin: const EdgeInsets.all(10),
                        child: Center(
                          child: Image.asset(
                            currentDices[index],
                            width: MediaQuery.of(context).size.width / 2.2,
                            height: MediaQuery.of(context).size.height / 3.2,
                          ),
                        ),
                      );
                    },
                  ),
                ),
          optionalButton(),
        ],
      ),
    );
  }
}
