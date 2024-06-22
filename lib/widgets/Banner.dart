import 'package:flutter/material.dart';

class Banner extends StatelessWidget {
  const Banner({
    super.key,
    required this.imagePath,
    required this.label,
  });

  final String label;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.55,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
