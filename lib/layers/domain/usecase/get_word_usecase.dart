
import 'package:injectable/injectable.dart';

import '../repository/word_repository.dart';

@lazySingleton
class GetWordUsecase {
    GetWordUsecase({
    required WordRepository repository,
  }) : _repository = repository;

  final WordRepository _repository;

  Future<String> call(int length) async {
    return await _repository.getWord(length);
  }
}