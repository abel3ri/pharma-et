import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:rxdart/rxdart.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FirestoreSearchService _searchService = FirestoreSearchService();
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: const FaIcon(FontAwesomeIcons.xmark),
        ),
        title: TextField(
          controller: _searchController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            hintText: "Search...",
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(100),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          onChanged: (value) {
            setState(() {
              _query = value.capitalize;
            });
          },
        ),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _searchService.search(_query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No results found.'));
          }

          List<Map<String, dynamic>> results = snapshot.data!;
          bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            itemCount: results.length,
            itemBuilder: (context, index) {
              return Card(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: isDarkMode
                        ? Theme.of(context).scaffoldBackgroundColor.lighten(10)
                        : Theme.of(context).scaffoldBackgroundColor.lighten(10),
                  ),
                  child: ListTile(
                    title: Text(
                      results[index]['name'],
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    subtitle: Text(results[index]['description']),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 12),
          );
        },
      ),
    );
  }
}

class FirestoreSearchService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> search(String query) {
    List<String> collections = [
      'babyAndMotherCare',
      'multiVitamins',
      "beautyProds",
      "nutritionAndSupplements",
    ];

    List<Stream<List<Map<String, dynamic>>>> streams =
        collections.map((collection) {
      Query queryRef = _firestore.collection(collection);

      if (query.isNotEmpty) {
        queryRef = queryRef
            .where('name', isGreaterThanOrEqualTo: query)
            .where('name', isLessThanOrEqualTo: '$query\uf8ff');
      }

      return queryRef.snapshots().map((snapshot) => snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList());
    }).toList();

    return Rx.combineLatestList(streams).map(
        (listOfResults) => listOfResults.expand((result) => result).toList());
  }
}
