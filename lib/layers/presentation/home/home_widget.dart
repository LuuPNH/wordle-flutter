import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_exam/layers/presentation/base/base_bloc/base_widget.dart';
import 'package:wordle_exam/layers/presentation/home/home_bloc.dart';
import 'package:wordle_exam/layers/presentation/home/play_game/bloc/play_game_widget.dart';
import 'package:wordle_exam/layers/presentation/resources/strings.dart';

import '../utils/dialog_utils.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends BaseWidget<HomeBloc, HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => bloc,
      child: BlocListener<HomeBloc, HomeState>(
        listenWhen: (p, c) => c.error != null,
        listener: (context, state) =>
            DialogUtils.showErrorDialog(context, state.error.toString()),
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: _onTapNewGame,
                    child: const Text(AppStrings.newGame)),
                const SizedBox(height: 8.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapNewGame() async {
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PlayGameWidget()),
      );
    }
  }
}
