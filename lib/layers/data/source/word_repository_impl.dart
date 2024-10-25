import 'package:injectable/injectable.dart';
import 'package:wordle_exam/layers/domain/entity/word.dart';
import 'package:wordle_exam/layers/domain/repository/word_repository.dart';

import 'local/local_storage.dart';
import 'network/api.dart';

@Singleton(as: WordRepository)
class WordRepositoryImpl implements WordRepository {
  final Api _api;

  // ignore: unused_field
  final LocalStorage _localStorage;

  WordRepositoryImpl({
    required Api api,
    required LocalStorage localStorage,
  })  : _api = api,
        _localStorage = localStorage;

  @override
  Future<List<Word>> guessWord({required String word, required String guess}) async {
    final res = await _api.guessWord(word: word, guess: guess);
    return res.map((e) => e.toDomain).toList();
  }
  
  @override
  Future<String> getWord(int length) {
    final res = _api.getWord(length);
    return res;
  }
}
