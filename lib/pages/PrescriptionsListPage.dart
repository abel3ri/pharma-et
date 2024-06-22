import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pharma_et/models/Error.dart';
import 'package:pharma_et/utils/Constants.dart';
import 'package:pharma_et/utils/ContextExtension.dart';
import 'package:pharma_et/widgets/CustomAppBar.dart';

class PrescriptionsListPage extends StatelessWidget {
  const PrescriptionsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Uploaded prescriptions",
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pushReplacementNamed("home");
          },
          icon: const FaIcon(FontAwesomeIcons.xmark),
        ),
      ),
      body: FutureBuilder(
        future: db.collection("users").doc(auth.currentUser!.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              snapshot.data!.runtimeType == ErrorMessage) {
            return Center(
              child: Text(
                context.localizations.noDataFound,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            );
          }
          final prescriptionData =
              snapshot.data!.data()!['uploadedPrescriptions'];

          return ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            itemBuilder: (context, index) {
              return Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Upload date"),
                          Text(
                            DateFormat.yMMMd("en-US").format(
                              (prescriptionData[index]['date'] as Timestamp)
                                  .toDate(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(prescriptionData[index]['url']),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 24);
            },
            itemCount: prescriptionData.length,
          );
        },
      ),
    );
  }
}
