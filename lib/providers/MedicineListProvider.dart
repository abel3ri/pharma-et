import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pharma_et/models/Error.dart';
import 'package:pharma_et/models/Success.dart';
import 'package:pharma_et/utils/Constants.dart';

class MedicineListProvider with ChangeNotifier {
  List<Map<String, dynamic>> _medicines = [];
  bool _isLoading = false;

  Future<Either<ErrorMessage, SuccessMessage>> fetchMedicines() async {
    try {
      _isLoading = true;
      final res = await db
          .collection("medicines")
          .orderBy("name", descending: false)
          .get();

      _medicines = res.docs.map((med) {
        return {
          "name": med.data()['name'],
          "description": med.data()['description'],
          "instructions": med.data()['dosage']['instructions'],
          "form": med.data()['dosage']['form'],
          "strength": med.data()['dosage']['strength'],
          "sideEffects": med.data()['sideEffects'],
          "manufacturer": med.data()['dosage']['manufacturer'],
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

  List<Map<String, dynamic>> get medicines => _medicines;

  bool get isLoading => _isLoading;
}
