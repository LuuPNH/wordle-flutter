import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../base/base_bloc/base_bloc.dart';
import '../base/base_bloc/base_event.dart';

part 'home_event.dart';

part 'home_state.dart';

@singleton
class HomeBloc extends BaseBloc<HomeState> {
  HomeBloc() : super(const HomeState());

  @override
  void onAddErrorEvent(ErrorEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(error: event.error));
  }

  @override
  void onAddInitialEvent(InitialEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith());
  }
}
