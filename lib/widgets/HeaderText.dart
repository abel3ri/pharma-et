import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({
    required this.headerText,
    super.key,
  });

  final String headerText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 5.0,
          height: 24.0,
          color: Theme.of(context).colorScheme.primary,
          margin: EdgeInsets.only(right: 8.0),
        ),
        Text(
          headerText,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
