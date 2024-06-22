import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:pharma_et/pages/PrescirptionImagePickerPage.dart';
import 'package:pharma_et/widgets/Banner.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_et/pages/ProfilePage.dart';
import 'package:pharma_et/providers/NavigationBarProvider.dart';
import 'package:pharma_et/utils/ContextExtension.dart';
import 'package:pharma_et/widgets/AppDrawer.dart';
import 'package:pharma_et/widgets/BannerSlider.dart';
import 'package:pharma_et/widgets/CategoryItem.dart';
import 'package:pharma_et/widgets/CustomAppBar.dart';
import 'package:pharma_et/widgets/HeaderText.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {
        "name": "nutritionAndSupplements",
        "title": context.localizations.nutritionAndSupplements,
        "imagePath": "assets/images/grid_images/nutritionAndSupplements.png",
      },
      {
        "name": "beautyProds",
        "title": context.localizations.personalCareAndBeautyProducts,
        "imagePath": "assets/images/grid_images/beautyProds.png",
      },
      {
        "name": "babyAndMotherCare",
        "title": context.localizations.babyAndMotherCare,
        "imagePath": "assets/images/grid_images/babyAndMotherCare.png",
      },
      {
        "name": "healthDevicesAndSupport",
        "title": context.localizations.healthDevicesAndSupport,
        "imagePath": "assets/images/grid_images/healthDevicesAndSupport.png",
      },
      {"name": "banner"},
      {
        "name": "sexualWellness",
        "title": context.localizations.sexualWellness,
        "imagePath": "assets/images/grid_images/sexualWellness.png",
      },
      {
        "name": "multiVitamins",
        "title": context.localizations.multiVitamins,
        "imagePath": "assets/images/grid_images/multiVitamins.png",
      },
      {
        "name": "medicines",
        "title": context.localizations.aZMedicines,
        "imagePath": "assets/images/grid_images/medicines.png",
      },
    ];

    List<Map<String, dynamic>> bannerData = [
      {
        "label": "Boost Your Power with Protein Powders and Supplements",
        "imagePath": "assets/images/banner_images/bannerImage1.png",
      },
      {
        "label": "All Your Medicines, Delivered to Your Doorstep",
        "imagePath": "assets/images/banner_images/bannerImage2.png",
      },
      {
        "label": "Your Pharmacist Assistant, Anytime, Anywhere",
        "imagePath": "assets/images/banner_images/bannerImage3.png",
      },
    ];
    final navigationBarProvider = Provider.of<NavigationBarProvider>(context);
    List<Widget> items = [
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Column(
          children: [
            HeaderText(
              headerText: context.localizations.categories,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: categories.asMap().entries.map((entry) {
                int index = entry.key;
                if (categories[index]['name'] == 'banner') {
                  return StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 1,
                    child: BannerSlider(
                      banners: List.generate(
                        3,
                        (index) => Banner(
                          imagePath: bannerData[index]['imagePath'],
                          label: bannerData[index]['label'],
                        ),
                      ),
                    ),
                  );
                }
                return StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: CategoryItem(
                      title: categories[index]['title'],
                      imagePath: categories[index]['imagePath'],
                      name: categories[index]['name']),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      const PrescirptionImagePickerPage(),
      const ProfilePage(),
    ];
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      drawer: const AppDrawer(),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        height: 65,
        index: navigationBarProvider.currentIndex,
        onTap: (index) {
          navigationBarProvider.setCurrentIndex(index);
        },
        color: isDarkMode
            ? Theme.of(context).scaffoldBackgroundColor.darken(5)
            : Theme.of(context).scaffoldBackgroundColor.lighten(5),
        buttonBackgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 150),
        animationCurve: Curves.easeInOut,
        items: const [
          FaIcon(FontAwesomeIcons.house),
          FaIcon(FontAwesomeIcons.plus),
          FaIcon(FontAwesomeIcons.user),
        ],
      ),
      appBar: CustomAppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const FaIcon(FontAwesomeIcons.bars),
          ),
        ),
        title: "PHARMA ET",
        actions: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).pushNamed("search");
            },
            icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
          )
        ],
      ),
      body: items[navigationBarProvider.currentIndex],
    );
  }
}
