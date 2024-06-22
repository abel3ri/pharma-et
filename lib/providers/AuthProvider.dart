import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_et/models/Error.dart';
import 'package:pharma_et/models/Success.dart';
import 'package:pharma_et/utils/Constants.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _verificationId;
  int? _resendToken;
  Timer? _resendTimer;
  int _resendCountdown = 60;
  bool _resendEnabled = false;

  late String _phoneNumber;
  String? _firstName;
  String? _lastName;
  late String _password;
  String? _email;

  void setUserFields({
    required String phoneNumber,
    String? firstName,
    String? lastName,
    required String password,
    String? email,
  }) {
    _phoneNumber = phoneNumber;
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _password = password;
    _password = password;
  }

  Future<Either<ErrorMessage, SuccessMessage>> sendOTP({
    required BuildContext context,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      _resendEnabled = false;
      _resendCountdown = 60;
      await auth.verifyPhoneNumber(
        phoneNumber: _phoneNumber,
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (error) {
          throw FirebaseAuthException(code: "404");
        },
        codeSent: (verificationId, forceResendingToken) {
          _verificationId = verificationId;
          _resendToken = forceResendingToken!;

          startResendTimer();
          _isLoading = false;
          GoRouter.of(context).pushReplacementNamed("otp");
        },
        codeAutoRetrievalTimeout: (verificationId) {
          _verificationId = verificationId;
          throw FirebaseAuthException(code: "404");
        },
        forceResendingToken: _resendToken,
        timeout: const Duration(seconds: 60),
      );
      return right(SuccessMessage(body: "Success"));
    } on FirebaseAuthException catch (e) {
      return left(ErrorMessage(body: e.message!));
    } on FirebaseException catch (e) {
      return left(ErrorMessage(body: e.message!));
    } catch (e) {
      return left(ErrorMessage(body: e.toString()));
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Either<ErrorMessage, SuccessMessage>> verifyOTP({
    required String otp,
  }) async {
    try {
      notifyListeners();
      final cred = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );
      User user = (await auth.signInWithCredential(cred)).user!;

      if (_email != null && emailRegex.hasMatch(_email!)) {
        AuthCredential cred = EmailAuthProvider.credential(
          email: email,
          password: password,
        );
        user.linkWithCredential(cred);
      }

      final res = await db.collection("users").doc(user.uid).get();
      if (res.exists) {
        return right(SuccessMessage(
            body: "User already registered. Redirecting to home page"));
      } else {
        await db.collection("users").doc(user.uid).set({
          "phoneNumber": _phoneNumber,
          "firstName": _firstName,
          "lastName": _lastName,
          "email": _email,
          "createdAt": DateTime.now(),
        });
      }
      return right(SuccessMessage(body: "User registered successfully."));
    } on FirebaseAuthException catch (e) {
      return left(ErrorMessage(body: e.message!));
    } catch (e) {
      return left(ErrorMessage(body: e.toString()));
    }
  }

  Future<Either<ErrorMessage, void>> signInUser({
    required String emailPhone,
    required String password,
    required BuildContext context,
  }) async {
    try {
      if (emailRegex.hasMatch(emailPhone)) {
        await auth.signInWithEmailAndPassword(
          email: emailPhone,
          password: password,
        );
      } else if (phoneRegex.hasMatch(emailPhone)) {
        final res = await db
            .collection("users")
            .where("phoneNumber", isEqualTo: emailPhone)
            .get();
        if (res.docs.isEmpty) {
          return left(ErrorMessage(body: "Incorrect phone number or password"));
        }
        if (res.docs.first.data()['email'] == null) {
          _phoneNumber = emailPhone;
          // ignore: use_build_context_synchronously
          await sendOTP(context: context);
          return left(ErrorMessage(body: "Redirecting to OTP Screen"));
        } else {
          final userEmail = res.docs.first.data()['email'];
          await auth.signInWithEmailAndPassword(
            email: userEmail,
            password: password,
          );
          return right(null);
        }
      }
      return right(null);
    } on FirebaseAuthException catch (e) {
      if (e.message! ==
          "The supplied auth credential is incorrect, malformed or has expired.") {
        return left(ErrorMessage(body: "Incorrect email or password"));
      }
      return left(ErrorMessage(body: e.message!));
    } on FirebaseException catch (e) {
      return left(ErrorMessage(body: e.message!));
    } catch (e) {
      return left(ErrorMessage(body: e.toString()));
    } finally {
      _password = password;
      notifyListeners();
    }
  }

  void startResendTimer() {
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        _resendCountdown--;
        notifyListeners();
      } else {
        _resendEnabled = true;
        _resendTimer?.cancel();
        notifyListeners();
      }
    });
    notifyListeners();
  }

  void toggleIsLoading() {
    _isLoading = !isLoading;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  String get verificationId => _verificationId!;

  String get email => _email!;
  String get phoneNumber => _phoneNumber;
  String get firstName => _firstName!;
  String get lastName => _lastName!;
  String get password => _password;

  int get resendCountDown => _resendCountdown;
  bool get resendEnabled => _resendEnabled;
}
