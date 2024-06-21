import "package:flex_color_scheme/flex_color_scheme.dart";
import "package:flutter/material.dart";
import "package:shimmer/shimmer.dart";

class CategoriesShimmerLoader extends StatelessWidget {
  const CategoriesShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
          child: Shimmer.fromColors(
            baseColor: isDarkMode
                ? Theme.of(context).scaffoldBackgroundColor.lighten(10)
                : Theme.of(context).scaffoldBackgroundColor.darken(10),
            highlightColor: isDarkMode
                ? Theme.of(context).scaffoldBackgroundColor.lighten(5)
                : Theme.of(context).scaffoldBackgroundColor.darken(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: double.infinity,
                  height: 100.0,
                ),
                SizedBox(height: 8.0),
                Container(
                  width: 200.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
