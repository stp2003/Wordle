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
    final size = MediaQuery.of(context).size;
    int index = 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: keysMap.entries.map(
        (e) {
          index++;
          if (index >= min && index <= max) {
            return Padding(
              padding: EdgeInsets.all(size.width * 0.006),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Container(
                  color: Colors.orangeAccent,
                  width: e.key == 'ENTER' || e.key == 'BACK'
                      ? size.width * 0.13
                      : size.width * 0.085,
                  height: size.height * 0.085,
                  child: Material(
                    color: Colors.white24,
                    child: InkWell(
                      onTap: () {},
                      child: Center(
                        child: Text(e.key),
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ).toList(),
    );
  }
}
