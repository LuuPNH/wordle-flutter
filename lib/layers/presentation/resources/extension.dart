import 'package:flutter/material.dart';
import 'package:wordle_exam/layers/domain/entity/word.dart';

import 'app_color.dart';

extension WordExtension on Word {
  Color get background {
    switch (result) {
      case WordResult.present:
        return Colors.yellow;
      case WordResult.absent:
        return AppColor.squareGuessDefault;
      case WordResult.correct:
        return Colors.green;
      case WordResult.create:
        return AppColor.squareGuessEnable;
      default:
        return AppColor.squareGuessDefault;
    }
  }
}
