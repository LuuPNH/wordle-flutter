// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'play_game_bloc.dart';

class PlayGameState extends Equatable {
  const PlayGameState({
    this.error,
    this.isFirstLoad = true,
    this.isLoading = false,
    this.words = const [],
    this.selectedWord = const [],
    this.word = '',
    this.isCorrect = false,
  });

  final dynamic error;
  final bool isFirstLoad;
  final bool isLoading;
  final List<List<Word>> words;
  final List<Word> selectedWord;
  final String word;
  final bool isCorrect;

  List<List<Word>> get listDisplay {
    final newList = List<List<Word>>.from(words);
    if (selectedWord.isNotEmpty) {
      newList.add(selectedWord);
    }
    return newList;
  }

  @override
  List<Object?> get props => [
        error,
        isFirstLoad,
        isLoading,
        words,
        selectedWord,
        word,
        isCorrect,
      ];

  PlayGameState copyWith({
    dynamic error,
    bool? isFirstLoad,
    bool? isLoading,
    List<List<Word>>? words,
    List<Word>? selectedWord,
    String? word,
    bool? isCorrect,
  }) {
    return PlayGameState(
      error: error,
      isFirstLoad: isFirstLoad ?? false,
      isLoading: isLoading ?? false,
      words: words ?? this.words,
      selectedWord: selectedWord ?? this.selectedWord,
      word: word ?? this.word,
      isCorrect: isCorrect ?? false,
    );
  }
}
