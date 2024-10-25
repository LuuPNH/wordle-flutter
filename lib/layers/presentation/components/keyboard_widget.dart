import 'package:flutter/material.dart';
import 'package:wordle_exam/layers/domain/entity/word.dart';

const _lv1 = 'qwertyuiop';
const _lv2 = 'asdfghjkl';
const _lv3 = 'zxcvbnm';
const _remove = '⌫';

class KeyboardWidget extends StatelessWidget {
  final List<Word> exists;
  final Function(String)? onSelect;
  final Function? onRemove;
  const KeyboardWidget({
    super.key,
    this.exists = const [],
    this.onSelect,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _keyboard(_lv1),
        const SizedBox(height: 8.0),
        _keyboard(_lv2),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _keyboard(_lv3),
            Container(
              height: 50.0,
              margin: const EdgeInsets.only(left: 8.0),
              child: _buildBtn(_remove, () => onRemove?.call())),
          ],
        ),
      ],
    );
  }

  Widget _keyboard(String list) {
    return SizedBox(
      height: 50.0,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          separatorBuilder: (_, i) => const SizedBox(
                width: 8.0,
              ),
          itemBuilder: (_, i) => _buildBtn(list[i], () => onSelect?.call(list[i]))),
    );
  }

  Widget _buildBtn(String s, Function()? callback) {
    return InkWell(
      onTap: callback,
      child: Container(
        height: 15.0,
        width: 33.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          border: Border.all(color: Colors.black87),
        ),
        alignment: Alignment.center,
        child: Text(
          s.toUpperCase(),
          style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
