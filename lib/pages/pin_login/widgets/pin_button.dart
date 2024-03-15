import 'package:flutter/material.dart';

class PinButton extends StatelessWidget {
  const PinButton({super.key, required this.num, required this.onClick});

  final int num;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    String? label;
    // num = 0-9
    List<String> labelList = [
      'ZERO',
      'ONE',
      'TWO',
      'THREE',
      'FOUR',
      'FIVE',
      'SIX',
      'SEVEN',
      'EIGHT',
      'NINE',
    ];

    if (num >= 0 && num <= 9) {
      label = labelList[num];
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onClick,
        child: Container(
          width: 60.0, // 160 = 1 inch
          height: 60.0,
          //margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: num >= 0 && num <= 9
                ? Border.all(color: theme.colorScheme.primary)
                : null,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (num >= 0 && num <= 9)
                  Text(
                    num.toString(),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (num >= 0 && num <= 9)
                  Text(label ?? '', style: TextStyle(fontSize: 10.0)),
                if (num == -2) Icon(Icons.close),
                if (num == -1) Icon(Icons.backspace),
              ],
            ),
          ),
        ),
      ),
    );
  }
}