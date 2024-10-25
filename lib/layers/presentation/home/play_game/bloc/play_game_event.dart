part of 'play_game_bloc.dart';

@immutable
class GuessWordEvent extends BaseEvent {}

@immutable
class SelectWordEvent extends BaseEvent {
  final String s;

  SelectWordEvent(this.s);
}

@immutable
class RemoveWordEvent extends BaseEvent {}
