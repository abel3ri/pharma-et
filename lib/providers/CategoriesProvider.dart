import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pharma_et/models/Error.dart';
import 'package:pharma_et/models/Success.dart';
import 'package:pharma_et/utils/Constants.dart';

class CategoriesProvider with ChangeNotifier {
  List<Map<String, dynamic>> _items = [];
  bool _isLoading = false;
  String _categoryName = "";
  String _title = "";

  Future<Either<ErrorMessage, SuccessMessage>> fetchItems() async {
    try {
      _isLoading = true;
      final res = await db.collection(_categoryName).get();

      _items = res.docs.map((item) {
        return {
          "name": item.data()['name'],
          "usage": item.data()['usage'],
          "category": item.data()['category'],
          "price": item.data()['price'],
          "type": item.data()['type'],
          "ingredients": item.data()['ingredients'],
          "benefits": item.data()['benefits'],
          "description": item.data()['description'],
        };
      }).toList();
      return right(SuccessMessage(body: "Success"));
    } on FirebaseException catch (_) {
      return left(ErrorMessage(body: "Error fetching medicines"));
    } catch (e) {
      return left(ErrorMessage(body: e.toString()));
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setCategoryName(String name) {
    _categoryName = name;
    notifyListeners();
  }

  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  List<Map<String, dynamic>> get items => _items;
  bool get isLoading => _isLoading;
  String get categoryName => _categoryName;
  String get title => _title;
}
