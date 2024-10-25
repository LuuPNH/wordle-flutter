import '../../domain/entity/word.dart';

class WordDto {
  WordDto({
    this.slot,
    this.guess,
    this.result,
  });

  int? slot;
  String? guess;
  String? result;

  factory WordDto.fromMap(Map<String, dynamic> json) => WordDto(
        slot: json['slot'],
        guess: json['guess'],
        result: json['result'],
      );

  Word get toDomain {
    try {
      return Word(slot: slot!, guess: guess!, result: toEnum);
    } catch (e) {
      rethrow;
    }
  }

  WordResult get toEnum {
    switch (result) {
      case 'present':
        return WordResult.present;
      case 'absent':
        return WordResult.absent;
      case 'correct':
        return WordResult.correct;
      default:
        return WordResult.none;
    }
  }
}
