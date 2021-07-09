import 'dart:math';

import 'package:audiofileplayer/audiofileplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_game/game/game_lib.dart';
import 'package:provider/provider.dart';

/**
 *  https://github.com/maexeler/mini_game.git
 */
class MiniGameEngine extends GameEngine {
  Random rnd = Random();
  double time = 0.0;
  double runningTime = 0.0;

  @override
  void setRunningTimeClassic(double seconds) {
    runningTime = seconds;
    gameState = GameState.endOfClassicGame;
  }

  @override
  void setRunningTimeVoice(double seconds) {
    runningTime = seconds;
    gameState = GameState.endOfVoiceGame;
  }

  @override
  void stateChanged(GameState oldState, GameState newState) {
    if (newState == GameState.waitForStartClassic ||
        newState == GameState.waitForStartVoice) {
      time = rnd.nextDouble() * 5;
    }
  }

  @override
  void updatePhysicsEngine(int _tickCounter) {
    updateViews();
  }

  @override
  String printFeedback() {
    if (time.toStringAsFixed(2) == runningTime.toStringAsFixed(2)) {
      Audio.load('assets/win_sound.wav')
        ..play()
        ..dispose();
      return "Good Job!";
    } else
      Audio.load('assets/fail_sound.wav')
        ..play()
        ..dispose();
    return "Too bad";
  }
}

class MiniGameView extends GameView {
  MiniGameView(String title) : super(title);

  @override
  Widget getStartPageContent(BuildContext context) {
    GameEngine engine = Provider.of<GameEngine>(context);
    return Container(
        alignment: Alignment.center,
        color: Color.fromRGBO(255, 231, 231, 1),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 25), child: Text('')),
            // Picture
            Expanded(flex: 0, child: Image.asset('assets/secondCatcher.png')),

            Padding(padding: EdgeInsets.only(top: 45), child: Text('')),
            // Lets play Text
            Padding(
                padding: EdgeInsets.only(top: 55, bottom: 45),
                child: Text('Lets Play!',
                    style: TextStyle(fontFamily: 'Forte', fontSize: 30))),
            Padding(padding: EdgeInsets.only(top: 5), child: Text('')),

            // Buttons
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(155, 150, 150, 1), // background
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                ),
                onPressed: () =>
                    {engine.gameState = GameState.waitForStartClassic},
                child: Text('Classic',
                    style: TextStyle(fontFamily: 'Forte', fontSize: 30))),

            Padding(padding: EdgeInsets.only(bottom: 1), child: Text('')),

            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(209, 85, 85, 1), // background
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                ),
                onPressed: () =>
                    {engine.gameState = GameState.waitForStartVoice},
                child: Text('Vocie',
                    style: TextStyle(fontFamily: 'Forte', fontSize: 30))),
          ], // Children
        ));
  }

  @override
  Widget getClassicPageContent(BuildContext context) {
    MiniGameEngine engine = Provider.of<GameEngine>(context) as MiniGameEngine;
    double seconds = engine.tickCounter * 20 / 1000;
    return Container(
        alignment: Alignment.center,
        color: Color.fromRGBO(255, 231, 231, 1),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 25), child: Text('')),
            // Picture
            Expanded(flex: 0, child: Image.asset('assets/secondCatcher.png')),

            Padding(padding: EdgeInsets.only(top: 45), child: Text('')),
            // Time
            Padding(
                padding: EdgeInsets.only(top: 55, bottom: 5),
                child: Text('${engine.time.toStringAsFixed(2)}',
                    style: TextStyle(fontFamily: 'Forte', fontSize: 60))),
            // Timer
            Padding(
                padding: EdgeInsets.only(bottom: 45),
                child: Text('0',
                    style: TextStyle(fontFamily: 'Arial', fontSize: 30))),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(155, 150, 150, 1), // background
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                ),
                onPressed: () => {engine.gameState = GameState.runningClassic},
                child: Text('Ready',
                    style: TextStyle(fontFamily: 'Forte', fontSize: 30))),
          ], // Children
        ));
  }

  @override
  Widget getVoicePageContent(BuildContext context) {
    MiniGameEngine engine = Provider.of<GameEngine>(context) as MiniGameEngine;
    double seconds = engine.tickCounter * 20 / 1000;
    return Container(
        alignment: Alignment.center,
        color: Color.fromRGBO(255, 231, 231, 1),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 25), child: Text('')),
            // Picture
            Expanded(flex: 0, child: Image.asset('assets/secondCatcher.png')),

            Padding(padding: EdgeInsets.only(top: 45), child: Text('')),
            // Time
            Padding(
                padding: EdgeInsets.only(top: 55, bottom: 5),
                child: Text('${engine.time.toStringAsFixed(2)}',
                    style: TextStyle(fontFamily: 'Forte', fontSize: 60))),
            // Timer
            Padding(
                padding: EdgeInsets.only(bottom: 45),
                child: Text('0',
                    style: TextStyle(fontFamily: 'Arial', fontSize: 30))),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(155, 150, 150, 1), // background
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                ),
                onPressed: () => {engine.gameState = GameState.runningVoice},
                child: Text('Ready',
                    style: TextStyle(fontFamily: 'Forte', fontSize: 30))),
          ], // Children
        ));
  }

  @override
  Widget getRunningPageContentClassic(BuildContext context) {
    MiniGameEngine engine = Provider.of<GameEngine>(context) as MiniGameEngine;
    double seconds = engine.tickCounter * 20 / 1000;

    return Container(
        alignment: Alignment.center,
        color: Color.fromRGBO(255, 231, 231, 1),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 25), child: Text('')),
            // Picture
            Expanded(flex: 0, child: Image.asset('assets/secondCatcher.png')),

            Padding(padding: EdgeInsets.only(top: 45), child: Text('')),
            // Time
            Padding(
                padding: EdgeInsets.only(top: 55, bottom: 5),
                child: Text('${engine.time.toStringAsFixed(2)}',
                    style: TextStyle(fontFamily: 'Forte', fontSize: 60))),
            // Timer
            Padding(
                padding: EdgeInsets.only(bottom: 45),
                child: Text('${seconds.toStringAsFixed(2)}',
                    style: TextStyle(fontFamily: 'Arial', fontSize: 30))),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(155, 150, 150, 1), // background
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                ),
                onPressed: () =>
                    {engine.setRunningTimeClassic(seconds)},
                child: Text('STOP!',
                    style: TextStyle(fontFamily: 'Forte', fontSize: 30))),
          ],
        ));
  }

  @override
  Widget getRunningPageContentVoice(BuildContext context) {
    MiniGameEngine engine = Provider.of<GameEngine>(context) as MiniGameEngine;
    double time = 0.0;
    double seconds = engine.tickCounter * 20 / 1000;
    return Container(
        alignment: Alignment.center,
        color: Color.fromRGBO(255, 231, 231, 1),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 25), child: Text('')),
            // Picture
            Expanded(flex: 0, child: Image.asset('assets/secondCatcher.png')),

            Padding(padding: EdgeInsets.only(top: 45), child: Text('')),
            // Time
            Padding(
                padding: EdgeInsets.only(top: 55, bottom: 5),
                child: Text('${engine.time.toStringAsFixed(2)}',
                    style: TextStyle(fontFamily: 'Forte', fontSize: 60))),
            // Timer
            Padding(
                padding: EdgeInsets.only(bottom: 45),
                child: Text('${seconds.toStringAsFixed(2)}',
                    style: TextStyle(fontFamily: 'Arial', fontSize: 30))),
            ElevatedButton(
                //todo button weg und mit stimmerkennung ersetzen
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(155, 150, 150, 1), // background
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                ),
                onPressed: () => {engine.setRunningTimeVoice(seconds)},
                child: Text('STOP!',
                    style: TextStyle(fontFamily: 'Forte', fontSize: 30))),
          ],
        ));
  }

  @override
  Widget getEndOfGamePageContentClassic(BuildContext context) {
    MiniGameEngine engine = Provider.of<GameEngine>(context) as MiniGameEngine;
    double time = 0.0;
    double seconds = engine.tickCounter * 20 / 1000;
    return Container(
        alignment: Alignment.center,
        color: Color.fromRGBO(255, 231, 231, 1),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 25), child: Text('')),
            // Picture
            Expanded(flex: 0, child: Image.asset('assets/secondCatcher.png')),

            Padding(
                padding: EdgeInsets.only(top: 75),
                child: Text('${engine.printFeedback()}',
                    style: TextStyle(fontFamily: 'Forte', fontSize: 30))),
            // Time
            Padding(
                padding: EdgeInsets.only(top: 15, bottom: 5),
                child: Text('${engine.time.toStringAsFixed(2)}',
                    style: TextStyle(fontFamily: 'Forte', fontSize: 60))),
            // Timer
            Padding(
                padding: EdgeInsets.only(bottom: 45),
                child: Text('${seconds.toStringAsFixed(2)}',
                    style: TextStyle(fontFamily: 'Arial', fontSize: 30))),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(155, 150, 150, 1), // background
                  padding: EdgeInsets.symmetric(horizontal: 45, vertical: 5),
                ),
                onPressed: () =>
                    {engine.gameState = GameState.waitForStartClassic},
                child: Text('Retry',
                    style: TextStyle(fontFamily: 'Forte', fontSize: 30))),

            Padding(padding: EdgeInsets.only(bottom: 1), child: Text('')),

            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(209, 85, 85, 1), // background
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                ),
                onPressed: () => {engine.gameState = GameState.waitForStart},
                child: Text('Home',
                    style: TextStyle(fontFamily: 'Forte', fontSize: 30))),
          ],
        ));
  }

  @override
  Widget getEndOfGamePageContentVoice(BuildContext context) {
    MiniGameEngine engine = Provider.of<GameEngine>(context) as MiniGameEngine;
    double time = 0.0;
    double seconds = engine.tickCounter * 20 / 1000;
    return Container(
        alignment: Alignment.center,
        color: Color.fromRGBO(255, 231, 231, 1),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 25), child: Text('')),
            // Picture
            Expanded(flex: 0, child: Image.asset('assets/secondCatcher.png')),

            Padding(
                padding: EdgeInsets.only(top: 85),
                child: Text('${engine.printFeedback()}',
                    style: TextStyle(fontFamily: 'Forte', fontSize: 30))),
            // Time
            Padding(
                padding: EdgeInsets.only(top: 15, bottom: 5),
                child: Text('${engine.time.toStringAsFixed(2)}',
                    style: TextStyle(fontFamily: 'Forte', fontSize: 60))),
            // Timer
            Padding(
                padding: EdgeInsets.only(bottom: 45),
                child: Text('${seconds.toStringAsFixed(2)}',
                    style: TextStyle(fontFamily: 'Arial', fontSize: 30))),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(155, 150, 150, 1), // background
                  padding: EdgeInsets.symmetric(horizontal: 45, vertical: 5),
                ),
                onPressed: () =>
                    {engine.gameState = GameState.waitForStartVoice},
                child: Text('Retry',
                    style: TextStyle(fontFamily: 'Forte', fontSize: 30))),

            Padding(padding: EdgeInsets.only(bottom: 1), child: Text('')),

            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(209, 85, 85, 1), // background
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                ),
                onPressed: () => {engine.gameState = GameState.waitForStart},
                child: Text('Home',
                    style: TextStyle(fontFamily: 'Forte', fontSize: 30))),
          ],
        ));
  }
}
