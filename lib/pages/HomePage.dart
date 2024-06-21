import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_et/utils/ContextExtension.dart';
import 'package:pharma_et/widgets/AppDrawer.dart';
import 'package:pharma_et/widgets/CategoryContainer.dart';
import 'package:pharma_et/widgets/CustomAppBar.dart';
import 'package:pharma_et/widgets/HeaderText.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _categories = [
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
    return Scaffold(
      drawer: AppDrawer(),
      appBar: CustomAppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: FaIcon(FontAwesomeIcons.bars),
          ),
        ),
        title: "PHARMA ET",
        actions: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).pushNamed("profile");
            },
            icon: FaIcon(FontAwesomeIcons.solidUser),
          )
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Column(
            children: [
              HeaderText(
                headerText: context.localizations.categories,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              ListView.separated(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CategoryContainer(
                      name: _categories[index]['name'],
                      title: _categories[index]['title'],
                      imagePath: _categories[index]['imagePath']);
                },
                itemCount: _categories.length,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 20);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
