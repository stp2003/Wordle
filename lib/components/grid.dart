import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  const Grid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(36, 20, 36, 20),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 30,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(border: Border.all()),
          child: Center(child: Text(index.toString())),
        );
      },
    );
  }
}
