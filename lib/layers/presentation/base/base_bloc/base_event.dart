import 'package:flutter/foundation.dart';

@immutable
abstract class BaseEvent {}

@immutable
class InitialEvent extends BaseEvent {}

@immutable
class RefreshEvent extends BaseEvent {}

@immutable
class ErrorEvent extends BaseEvent {
  final dynamic error;

  ErrorEvent(this.error);
}