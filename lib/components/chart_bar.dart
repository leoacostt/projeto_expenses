import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  ChartBar({
    required this.label,
    required this.value,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constrains) {
        return Column(
          children: <Widget>[
            Container(
              height: constrains.maxHeight * 0.15,
              child: FittedBox(
                child: Text('${value.toStringAsFixed(2)}'))),
            SizedBox(height: constrains.maxHeight * 0.05),
            Container(
              height: constrains.maxHeight * 0.6,
              width: 10,
              child: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: Colors.green, width: 1.0),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green[200],
                        borderRadius: BorderRadius.circular(3)),
                  ),
                )
              ]),
            ),
            SizedBox(height: constrains.maxHeight * 0.05),
            Container(
              height: constrains.maxHeight * 0.15,
              child: FittedBox(child: Text(label))),
          ],
        );
      },
    );
  }
}
