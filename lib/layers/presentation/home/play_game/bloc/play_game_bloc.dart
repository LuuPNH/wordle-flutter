import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wordle_exam/layers/domain/usecase/get_word_usecase.dart';
import 'package:wordle_exam/layers/presentation/base/base_bloc/base_bloc.dart';
import 'package:wordle_exam/layers/presentation/resources/app_constant.dart';

import '../../../../domain/entity/word.dart';
import '../../../../domain/usecase/random_word_usecase.dart';
import '../../../base/base_bloc/base_event.dart';

part 'play_game_event.dart';
part 'play_game_state.dart';

const errLoadWord = 'error-load-word';

@injectable
class PlayGameBloc extends BaseBloc<PlayGameState> {
  final GuessWordUsecase guessWordUsecase;
  final GetWordUsecase getWordUsecase;

  PlayGameBloc(
    this.guessWordUsecase,
    this.getWordUsecase,
  ) : super(const PlayGameState()) {
    on<GuessWordEvent>(_onAddGuessWordEvent);
    on<SelectWordEvent>(_onAddSelectWordEvent);
    on<RemoveWordEvent>(_onAddRemoveWordEvent);
  }

  @override
  void onAddErrorEvent(ErrorEvent event, Emitter<PlayGameState> emit) async {
    emit(state.copyWith(error: event.error));
  }

  @override
  void onAddInitialEvent(
      InitialEvent event, Emitter<PlayGameState> emit) async {
    final res = await getWordUsecase.call(AppConstant.lengthWord);
    emit(state.copyWith(word: res));
  }

  @override
  void onAddRefreshEvent(
      RefreshEvent event, Emitter<PlayGameState> emit) async {
    final res = await getWordUsecase.call(AppConstant.lengthWord);
    emit(state.copyWith(word: res));
  }

  Future<void> _onAddGuessWordEvent(
      GuessWordEvent event, Emitter<PlayGameState> emit) async {
    emit(state.copyWith(isLoading: true));
    final guess = state.selectedWord.map((e) => e.guess).toList().join();
    final res = await guessWordUsecase.call(word: state.word, guess: guess);
    //Correct answer
    if (res.every((s) => s.result == WordResult.correct)) {
      await _makeNewGame(emit);
      return;
    }
    if (state.words.length == AppConstant.lengthWord - 1) {
      await _makeNewGame(emit, isCorrect: false);
      throw 'You lose!!!';
    }
    final newList = List<List<Word>>.from(state.words);
    newList.add(res);
    emit(state.copyWith(words: newList, selectedWord: const []));
  }

  Future<void> _onAddSelectWordEvent(
      SelectWordEvent event, Emitter<PlayGameState> emit) async {
    final newS = List<Word>.from(state.selectedWord);
    if (newS.length >= AppConstant.lengthWord) return;
    newS.add(Word.create(slot: newS.length + 1, guess: event.s));
    emit(state.copyWith(selectedWord: newS));
  }

  Future<void> _onAddRemoveWordEvent(
      RemoveWordEvent event, Emitter<PlayGameState> emit) async {
    if (state.selectedWord.isEmpty) return;
    final newS = List<Word>.from(state.selectedWord);
    newS.removeLast();
    emit(state.copyWith(selectedWord: newS));
  }

  Future<void> _makeNewGame(Emitter<PlayGameState> emit, {bool isCorrect = true}) async {
    final res = await getWordUsecase.call(AppConstant.lengthWord);
    emit(state
        .copyWith(selectedWord: [], words: [], isCorrect: isCorrect, word: res));
  }
}
