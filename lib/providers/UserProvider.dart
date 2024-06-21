import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pharma_et/models/Error.dart';
import 'package:pharma_et/models/Success.dart';
import 'package:pharma_et/utils/Constants.dart';

class UserProvider with ChangeNotifier {
  Map<String, dynamic> _user = {};

  Future<Either<ErrorMessage, SuccessMessage>> fetchUserData() async {
    try {
      final String uid = auth.currentUser!.uid;
      final res = await db.collection("users").doc(uid).get();
      _user = res.data()!;
      return right(SuccessMessage(body: "User data fetched successfull!"));
    } on FirebaseException catch (e) {
      return left(ErrorMessage(body: e.message!));
    } catch (e) {
      return left(ErrorMessage(body: e.toString()));
    } finally {
      notifyListeners();
    }
  }

  Map<String, dynamic> get user => _user;
}
