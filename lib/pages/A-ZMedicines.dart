import 'package:azlistview/azlistview.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:go_router/go_router.dart';
import 'package:pharma_et/models/Error.dart';
import 'package:pharma_et/models/Success.dart';
import 'package:pharma_et/providers/MedicineListProvider.dart';
import 'package:pharma_et/widgets/CategoriesShimmerLoader.dart';
import 'package:pharma_et/widgets/CustomAppBar.dart';
import 'package:provider/provider.dart';

class Medicine extends ISuspensionBean {
  String name;
  String tag;
  Medicine({
    required this.name,
    required this.tag,
  });
  @override
  String getSuspensionTag() {
    return this.tag;
  }
}

class AZMedicines extends StatefulWidget {
  const AZMedicines({super.key});

  @override
  State<AZMedicines> createState() => _AZMedicinesState();
}

class _AZMedicinesState extends State<AZMedicines> {
  late Future<Either<ErrorMessage, SuccessMessage>> fetchMedicines;

  @override
  void initState() {
    fetchMedicines = Provider.of<MedicineListProvider>(context, listen: false)
        .fetchMedicines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final medicinesProvider = Provider.of<MedicineListProvider>(context);
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Medicines",
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: const FaIcon(FontAwesomeIcons.xmark),
        ),
      ),
      body: FutureBuilder(
          future: fetchMedicines,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CategoriesShimmerLoader());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData ||
                snapshot.data!.runtimeType == ErrorMessage) {
              return const Center(child: Text('No data found'));
            }

            final medicineList = medicinesProvider.medicines
                .map(
                  (medicine) => Medicine(
                    name: medicine['name'],
                    tag: medicine['name'][0],
                  ),
                )
                .toList();
            return AzListView(
              physics: const BouncingScrollPhysics(),
              data: medicineList,
              padding: const EdgeInsets.only(right: 32, left: 12),
              indexBarOptions: const IndexBarOptions(
                  indexHintAlignment: Alignment.centerRight),
              itemCount: medicineList.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {},
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  elevation: 0,
                  color: isDarkMode
                      ? Theme.of(context).scaffoldBackgroundColor.lighten(10)
                      : Theme.of(context).scaffoldBackgroundColor.darken(10),
                  surfaceTintColor: Colors.transparent,
                  // color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 24),
                    child: Text(
                      medicinesProvider.medicines[index]['name'],
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ),
            );
            //  return AzListView(data: data, itemCount: itemCount, itemBuilder: itemBuilder)
          }),
    );
  }
}
