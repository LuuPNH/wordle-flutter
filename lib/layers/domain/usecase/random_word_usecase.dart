import 'package:injectable/injectable.dart';
import 'package:wordle_exam/layers/domain/entity/word.dart';

import '../../domain/repository/word_repository.dart';

@singleton
class GuessWordUsecase {
  GuessWordUsecase({
    required WordRepository repository,
  }) : _repository = repository;

  final WordRepository _repository;

  Future<List<Word>> call({required String word, required String guess}) async {
    return await _repository.guessWord(word: word,guess: guess);
  }
}
