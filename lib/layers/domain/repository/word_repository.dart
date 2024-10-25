import '../../domain/entity/word.dart';

abstract class WordRepository {
  Future<List<Word>> guessWord({required String word, required String guess});

  Future<String> getWord(int length);
}
