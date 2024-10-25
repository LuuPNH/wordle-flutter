import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'base_event.dart';

abstract class BaseBloc<S> extends Bloc<BaseEvent, S> {
  bool isClose = false;
  final StreamController<BaseEvent> _eventController = StreamController.broadcast();

  BaseBloc(super.initialState) {
    on<InitialEvent>(onAddInitialEvent);
    on<ErrorEvent>(onAddErrorEvent);
    on<RefreshEvent>(onAddRefreshEvent);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    if (!isClose) {
      add(ErrorEvent(error));
    }
    super.onError(error, stackTrace);
  }

  @override
  void onEvent(BaseEvent event) {
    super.onEvent(event);
    _eventController.add(event);
  }

  @override
  Future<void> close() {
    _eventController.close();
    isClose = true;
    return super.close();
  }

  Stream<BaseEvent> streamEvent() => _eventController.stream;

  void onAddInitialEvent(InitialEvent event, Emitter<S> emit) {}

  void onAddErrorEvent(ErrorEvent event, Emitter<S> emit) {}

  void onAddRefreshEvent(RefreshEvent event, Emitter<S> emit) {}
}