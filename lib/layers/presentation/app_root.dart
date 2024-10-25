
import 'package:flutter/material.dart';
import 'package:wordle_exam/layers/presentation/home/home_widget.dart';
import 'package:wordle_exam/layers/presentation/resources/theme.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {

  final CustomTheme theme = const CustomTheme();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme.toThemeData(),
      darkTheme: theme.toThemeDataDark(),
      debugShowCheckedModeBanner: false,
      home: const HomeWidget(),
    );
  }
}
