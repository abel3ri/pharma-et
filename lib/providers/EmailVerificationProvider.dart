import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pharma_et/models/Error.dart';
import 'package:pharma_et/models/Success.dart';
import 'package:pharma_et/utils/Constants.dart';

class EmailVerificationProvider with ChangeNotifier {
  bool _isLoading = false;

  Future<Either<ErrorMessage, SuccessMessage>> addEmailAddress({
    required String email,
    required String password,
  }) async {
    try {
      final cred =
          EmailAuthProvider.credential(email: email, password: password);
      await auth.currentUser!.linkWithCredential(cred);
      await db.collection("users").doc(auth.currentUser!.uid).update({
        "email": email,
      });
      return right(SuccessMessage(body: "Successfully added email"));
    } on FirebaseAuthException catch (e) {
      return left(ErrorMessage(body: e.message!));
    } on FirebaseException catch (e) {
      return left(ErrorMessage(body: e.message!));
    } catch (e) {
      return left(ErrorMessage(body: e.toString()));
    }
  }

  Future<Either<ErrorMessage, SuccessMessage>> verifyEmailAddress({
    required String email,
  }) async {
    try {
      await auth.currentUser!.sendEmailVerification();
      return right(SuccessMessage(body: "Verification email sent to $email"));
    } on FirebaseAuthException catch (e) {
      return left(ErrorMessage(body: e.message!));
    } catch (e) {
      return left(ErrorMessage(body: e.toString()));
    }
  }

  Future<Either<ErrorMessage, SuccessMessage>> sendPasswordResetLink({
    required String email,
  }) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return right(SuccessMessage(body: "Password reset link sent to $email"));
    } on FirebaseAuthException catch (e) {
      return left(ErrorMessage(body: e.message!));
    } catch (e) {
      return left(ErrorMessage(body: e.toString()));
    }
  }

  void toggleIsLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
}
