import 'package:equatable/equatable.dart';

enum WordResult {
  absent,
  present,
  correct,
  create,
  none,

}

class Word extends Equatable {
  const Word({
    required this.slot,
    required this.guess,
    required this.result,
  });

  const Word.create({
    required this.slot,
    required this.guess,
    this.result = WordResult.create,
  });

  final int slot;
  final String guess;
  final WordResult result;

  @override
  List<Object?> get props => [slot, result, guess];

  Word copyWith({String? guess, int? slot, WordResult? result}) {
    return Word(
      slot: slot ?? this.slot,
      result: result ?? this.result,
      guess: guess ?? this.guess,
    );
  }
}
