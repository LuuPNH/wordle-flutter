part of 'home_bloc.dart';

class HomeState extends Equatable {
  final dynamic error;
  final bool isFirstLoad;
  final bool isLoading;

  const HomeState({
    this.error,
    this.isFirstLoad = true,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        error,
        isFirstLoad,
        isLoading,
      ];

  HomeState copyWith({
    bool? isLoading,
    bool? isFirstLoad,
    dynamic error,
  }) {
    return HomeState(
      error: error,
      isFirstLoad: isFirstLoad ?? false,
      isLoading: isLoading ?? false,
    );
  }
}
