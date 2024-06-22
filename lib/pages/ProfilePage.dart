import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pharma_et/models/Error.dart';
import 'package:pharma_et/models/Success.dart';
import 'package:pharma_et/providers/EmailVerificationProvider.dart';
import 'package:pharma_et/providers/UserProvider.dart';
import 'package:pharma_et/utils/Constants.dart';
import 'package:pharma_et/utils/ContextExtension.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Either<ErrorMessage, SuccessMessage>> fetchUserData;
  @override
  void initState() {
    fetchUserData =
        Provider.of<UserProvider>(context, listen: false).fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchUserData,
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

          final userProvider = Provider.of<UserProvider>(context);
          String fullName =
              "${userProvider.user['firstName']} ${userProvider.user['lastName']}";
          String phoneNumber = userProvider.user['phoneNumber'];
          String email = userProvider.user['email'] ?? "No email";
          DateTime createdAt =
              (userProvider.user['createdAt'] as Timestamp).toDate();

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            radius: 30,
                            child: const Icon(
                              FontAwesomeIcons.user,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                fullName,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                email,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            phoneNumber,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Joined ${DateFormat.yMMMd("en-US").format(createdAt)}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      if (email != "No email" &&
                          !auth.currentUser!.emailVerified) ...[
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Verify your email address"),
                            TextButton(
                              onPressed: () async {
                                final res = await Provider.of<
                                            EmailVerificationProvider>(context,
                                        listen: false)
                                    .verifyEmailAddress(
                                  email: email,
                                );
                                res.fold((l) {
                                  l.showError(context);
                                }, (r) {
                                  r.showSuccess(context);
                                });
                              },
                              child: const Text("Verify"),
                            ),
                          ],
                        ),
                      ],
                      if (email == "No email") ...[
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Add email address"),
                            TextButton(
                              onPressed: () {
                                GoRouter.of(context).pushNamed("addemail");
                              },
                              child: const Text("Add"),
                            ),
                          ],
                        ),
                      ],
                      if (auth.currentUser!.emailVerified) ...[
                        const SizedBox(height: 16),
                        Text(
                          "Email verified",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        )
                      ],
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}
