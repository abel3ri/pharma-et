import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_et/providers/CategoriesProvider.dart';
import 'package:provider/provider.dart';

class CategoryContainer extends StatelessWidget {
  const CategoryContainer({
    required this.title,
    required this.name,
    required this.imagePath,
    super.key,
  });

  final String imagePath;
  final String title;
  final String name;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
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
      child: Container(
        height: 200,
        width: double.infinity,
        child: Stack(
          children: [
            Hero(
              tag: name,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 12,
                right: 56,
                bottom: 12,
              ),
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Theme.of(context)
                          .scaffoldBackgroundColor
                          .lighten(20)
                          .withOpacity(0.5)
                      : Theme.of(context)
                          .scaffoldBackgroundColor
                          .darken(30)
                          .withOpacity(0.5),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
