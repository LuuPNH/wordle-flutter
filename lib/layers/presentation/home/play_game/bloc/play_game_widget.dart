import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_exam/layers/domain/entity/word.dart';
import 'package:wordle_exam/layers/presentation/base/base_bloc/base_event.dart';
import 'package:wordle_exam/layers/presentation/base/base_bloc/base_widget_factory.dart';
import 'package:wordle_exam/layers/presentation/home/play_game/bloc/play_game_bloc.dart';
import 'package:wordle_exam/layers/presentation/resources/app_constant.dart';
import 'package:wordle_exam/layers/presentation/resources/extension.dart';

import '../../../components/keyboard_widget.dart';
import '../../../components/overlay_loading.dart';
import '../../../resources/app_color.dart';
import '../../../resources/strings.dart';
import '../../../utils/dialog_utils.dart';

const _squareSize = 60.0;
const _spacingSquare = 8.0;

class PlayGameWidget extends StatefulWidget {
  const PlayGameWidget({super.key});

  @override
  State<PlayGameWidget> createState() => _PlayGameWidgetState();
}

class _PlayGameWidgetState
    extends BaseWidgetFactory<PlayGameBloc, PlayGameWidget>
    with LoadingOverlay {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.playGame)),
      body: isLoadingBloc
          ? const Center(child: CupertinoActivityIndicator())
          : _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocProvider<PlayGameBloc>(
      create: (context) => bloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<PlayGameBloc, PlayGameState>(
            listenWhen: (p, c) => c.error != null,
            listener: (context, state) =>
                DialogUtils.showErrorDialog(context, state.error.toString()),
          ),
          BlocListener<PlayGameBloc, PlayGameState>(
            bloc: bloc,
            listenWhen: (p, c) => p.isLoading != c.isLoading,
            listener: (context, state) => showLoading(state.isLoading),
          ),
          BlocListener<PlayGameBloc, PlayGameState>(
            listenWhen: (p, c) =>
                c.error != null && p.isFirstLoad && !c.isFirstLoad,
            listener: (context, state) => Navigator.pop,
          ),
          BlocListener<PlayGameBloc, PlayGameState>(
            listenWhen: (p, c) => !p.isCorrect && c.isCorrect,
            listener: (context, state) => DialogUtils.showCongratulationDialog(
                context, AppStrings.congralatution),
          ),
        ],
        child: BlocBuilder<PlayGameBloc, PlayGameState>(
          buildWhen: (p, c) => p.isFirstLoad != c.isFirstLoad,
          builder: (context, state) {
            if (state.isFirstLoad) {
              return const Center(child: CupertinoActivityIndicator());
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<PlayGameBloc, PlayGameState>(
                  buildWhen: (p, c) => p.listDisplay != c.listDisplay,
                  builder: (context, state) {
                    return ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (_, __) => const SizedBox(height: 8.0),
                      itemCount: AppConstant.lengthWord,
                      itemBuilder: (_, i) {
                        return state.listDisplay.isNotEmpty &&
                                state.listDisplay.length > i
                            ? _rowSquare(
                                indexRow: i,
                                words: state.listDisplay[i],
                                enableRow: state.words.length == i)
                            : _rowSquare(
                                indexRow: i,
                                enableRow: state.words.length == i &&
                                    state.selectedWord.isEmpty);
                      },
                    );
                  },
                ),
                KeyboardWidget(
                  onSelect: (s) => addEvent(SelectWordEvent(s)),
                  onRemove: () => addEvent(RemoveWordEvent()),
                ),
                const SizedBox(height: 16.0),
                BlocBuilder<PlayGameBloc, PlayGameState>(
                  buildWhen: (p, c) =>
                      p.word != c.word || p.selectedWord != c.selectedWord,
                  builder: (context, state) {
                    if (state.word.isEmpty) {
                      return ElevatedButton(
                          onPressed: () => bloc.add(RefreshEvent()),
                          child: const Text(AppStrings.refresh));
                    }
                    return ElevatedButton(
                        onPressed:
                            state.selectedWord.length == AppConstant.lengthWord
                                ? () => bloc.add(GuessWordEvent())
                                : null,
                        child: const Text(AppStrings.submit));
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _rowSquare(
      {required int indexRow,
      List<Word> words = const [],
      bool enableRow = false}) {
    return Container(
      alignment: Alignment.center,
      height: _squareSize,
      width: _squareSize,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) {
          final w = words.length > i ? words[i] : null;
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: enableRow
                  ? AppColor.squareGuessEnable
                  : w?.background ?? AppColor.squareGuessDefault,
              border: Border.all(color: Colors.black87),
            ),
            alignment: Alignment.center,
            height: _squareSize,
            width: _squareSize,
            child: Text(w?.guess ?? '',
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                )),
          );
        },
        separatorBuilder: (_, i) => const SizedBox(width: _spacingSquare),
        itemCount: AppConstant.lengthWord,
      ),
    );
  }
}
