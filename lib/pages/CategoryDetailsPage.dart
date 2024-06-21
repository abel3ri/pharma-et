import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:go_router/go_router.dart';
import 'package:pharma_et/models/Error.dart';
import 'package:pharma_et/models/Success.dart';
import 'package:pharma_et/providers/CategoriesProvider.dart';
import 'package:pharma_et/utils/ContextExtension.dart';
import 'package:pharma_et/widgets/CategoriesShimmerLoader.dart';
import 'package:pharma_et/widgets/CustomAppBar.dart';
import 'package:pharma_et/widgets/HeaderText.dart';
import 'package:provider/provider.dart';

class CategoryDetailsPage extends StatefulWidget {
  const CategoryDetailsPage({super.key});

  @override
  State<CategoryDetailsPage> createState() => _CategoryDetailsPageState();
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage> {
  late Future<Either<ErrorMessage, SuccessMessage>> fetchItems;

  @override
  void initState() {
    fetchItems =
        Provider.of<CategoriesProvider>(context, listen: false).fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoriesProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: categoryProvider.title,
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: FaIcon(FontAwesomeIcons.xmark),
        ),
      ),
      body: FutureBuilder(
        future: fetchItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CategoriesShimmerLoader());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              snapshot.data!.runtimeType == ErrorMessage) {
            return Center(
                child: Text(
              context.localizations.noDataFound,
              style: Theme.of(context).textTheme.titleLarge,
            ));
          }

          // print(categoryProvider.items);
          bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Hero(
                        tag: categoryProvider.categoryName,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/images/grid_images/${categoryProvider.categoryName}.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ).animate().fadeIn(),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ),
                if (categoryProvider.items.isNotEmpty) ...[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  HeaderText(headerText: context.localizations.products),
                  ListView.separated(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 24),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: isDarkMode
                                ? Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .lighten(5)
                                : Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .darken(5)),
                        child: Column(
                          children: [
                            DetailsRow(
                              label: context.localizations.name,
                              value: categoryProvider.items[index]['name'],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            DetailsRow(
                              label: context.localizations.category,
                              value: categoryProvider.items[index]['category'],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Column(
                              children: [
                                Text(
                                  context.localizations.usage,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01),
                                Text(categoryProvider.items[index]['usage']),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Text(
                              context.localizations.benefits,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) => SizedBox(
                                height: 8,
                              ),
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 12,
                                      child: Container(
                                        child: Text('${index + 1}'),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(categoryProvider.items[index]
                                        ['benefits'][index])
                                  ],
                                );
                              },
                              itemCount: categoryProvider
                                  .items[index]['benefits'].length,
                              shrinkWrap: true,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Divider(),
                            if (categoryProvider.items[index]['ingredients'] !=
                                null)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(context.localizations.ingredients),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                  ),
                                  Expanded(
                                    child: Wrap(
                                        children: (categoryProvider.items[index]
                                                ['ingredients'] as List)
                                            .map((el) {
                                      return Chip(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        label: Text(el),
                                      );
                                    }).toList()),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 24,
                      );
                    },
                    itemCount: categoryProvider.items.length,
                  ),
                ],
                if (categoryProvider.items.isEmpty) ...[
                  SizedBox(
                    height: 32,
                  ),
                  Center(
                    child: Text(
                      context.localizations.noDataFound,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class DetailsRow extends StatelessWidget {
  DetailsRow({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(
          value.length < 24 ? value : value.substring(0, 24),
        ),
      ],
    );
  }
}
