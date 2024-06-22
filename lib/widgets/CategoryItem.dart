import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_et/providers/CategoriesProvider.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final String name;

  const CategoryItem(
      {super.key,
      required this.title,
      required this.imagePath,
      required this.name});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        if (name == 'medicines') {
          GoRouter.of(context).pushNamed("azmedicines");
          return;
        }
        Provider.of<CategoriesProvider>(context, listen: false)
            .setCategoryName(name);
        Provider.of<CategoriesProvider>(context, listen: false).setTitle(title);

        GoRouter.of(context).pushNamed("categoryDetails");
      },
      child: Card(
        elevation: 0,
        color: Theme.of(context).scaffoldBackgroundColor.lighten(5),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Hero(
                tag: name,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: isDarkMode
                          ? Theme.of(context)
                              .scaffoldBackgroundColor
                              .lighten(60)
                          : Theme.of(context)
                              .scaffoldBackgroundColor
                              .darken(60),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
