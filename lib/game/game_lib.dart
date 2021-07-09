import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Game {
  final GameView gameView;
  final GameEngine gameEngine;

  Game(this.gameView, this.gameEngine);
}

abstract class GameView extends StatelessWidget {
  final String title;

  GameView(this.title);

  Widget getStartPageContent(BuildContext context);

  Widget getClassicPageContent(BuildContext context);
  Widget getVoicePageContent(BuildContext context);

  Widget getRunningPageContentClassic(BuildContext context);
  Widget getRunningPageContentVoice(BuildContext context);

  Widget getEndOfGamePageContentClassic(BuildContext context);
  Widget getEndOfGamePageContentVoice(BuildContext context);

  @override
  Widget build(BuildContext context) {
    GameEngine game = Provider.of<GameEngine>(context);
    return Scaffold(
      /*appBar: AppBar(
        title: Text(title),
      ),*/
      body: _getPageContents(context, game),
    );
  }

  Widget _getPageContents(BuildContext context, GameEngine game) {
    switch (game.gameState) {
      case GameState.waitForStart:
        return getStartPageContent(context);
      case GameState.waitForStartClassic:
        return getClassicPageContent(context);
      case GameState.waitForStartVoice:
        return getVoicePageContent(context);
      case GameState.runningClassic:
        return getRunningPageContentClassic(context);
      case GameState.runningVoice:
        return getRunningPageContentVoice(context);
      case GameState.endOfClassicGame:
        return getEndOfGamePageContentClassic(context);
      case GameState.endOfVoiceGame:
        return getEndOfGamePageContentVoice(context);
    }
  }
}

enum GameState { waitForStart, waitForStartClassic, waitForStartVoice, runningClassic, runningVoice, endOfClassicGame, endOfVoiceGame }

abstract class GameEngine extends ChangeNotifier {
  Timer? _timer;
  int _tickCounter;
  GameState _gameState;

  GameEngine()
      : _gameState = GameState.waitForStart,
        _tickCounter = 0;

  void stateChanged(GameState oldState, GameState newState);

  void updatePhysicsEngine(int _tickCounter);

  String printFeedback();

  int get tickCounter => _tickCounter;

  GameState get gameState => _gameState;

  set gameState(GameState newState) {
    if (_gameState == newState) return;

    stateChanged(_gameState, newState);
    _gameState = newState;

    if (_gameState == GameState.runningClassic || _gameState == GameState.runningVoice) {
      startGameLoop();
      _tickCounter = 0;
    } else {
      stopGameLoop();
    }
    updateViews();
  }

  void startGameLoop() {
    _timer?.cancel(); // equals: if(_timer!= null){ _timer.cancel();}
    _timer = new Timer.periodic(Duration(milliseconds: 20), _processTick);
  }

  void stopGameLoop() {
    _timer?.cancel();
  }

  /** Alternative ohne start-/stopGameLoop:
      if(_gameState == GameState.running){
      _timer?.cancel();
      _timer= new Timer(Duration(milliseconds:20), () => {});
      }else
      if(_gameState != GameState.running){
      _timer?.cancel();
      }**/
  void updateViews() {
    notifyListeners();
  }

  void _processTick(dynamic notUsed) {
    ++_tickCounter;
    updatePhysicsEngine(_tickCounter);
  }
}
