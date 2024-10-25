import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../di.dart';
import 'base_bloc.dart';
import 'base_event.dart';

abstract class BaseWidget<T extends BaseBloc, W extends StatefulWidget>
    extends State<W> {
  @nonVirtual
  late T bloc;

  T get getBloc => getIt();

  @override
  void initState() {
    bloc = getBloc;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.add(InitialEvent());
    });
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
}
