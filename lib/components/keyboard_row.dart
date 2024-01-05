import 'package:flutter/material.dart';

import '../data/key_maps.dart';

class KeyboardRow extends StatelessWidget {
  final int min;
  final int max;

  const KeyboardRow({
    super.key,
    required this.min,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Row(
      children: keysMap.entries.map(
        (e) {
          index++;
          if (index >= min && index <= max) {
            return Text(e.key);
          } else {
            return const SizedBox();
          }
        },
      ).toList(),
    );
  }
}
