import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../di.dart';
import 'base_bloc.dart';
import 'base_event.dart';

abstract class BaseWidgetFactory<T extends BaseBloc, W extends StatefulWidget>
    extends State<W> {
  bool isLoadingBloc = true;

  @nonVirtual
  late T bloc;

  @override
  void initState() {
    //Init bloc
    initBloc();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    disposeBloc();
  }

  void disposeBloc() => bloc.close();

  void addEvent(dynamic event) {
    bloc.add(event);
  }

  Future<void> initBloc() async {
    final b = await getIt.getAsync<T>();
    bloc = b;
    setState(() {
      isLoadingBloc = false;
    });
    bloc.add(InitialEvent());
    return;
  }
}
