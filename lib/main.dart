import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_exam/layers/presentation/app_root.dart';

import 'layers/presentation/base/bloc_observer.dart';
import 'layers/presentation/di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await di.configureInjection();
  
  runApp(const AppRoot());
}
