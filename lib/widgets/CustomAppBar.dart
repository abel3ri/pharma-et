// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final PreferredSizeWidget? bottom;
  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.bottom,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: Text(title ?? ""),
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        actions: actions,
        leading: leading,
        bottom: bottom,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
