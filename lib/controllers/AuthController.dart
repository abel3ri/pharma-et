// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fpdart/fpdart.dart';
// import 'package:go_router/go_router.dart';
// import 'package:pharma_et/models/Error.dart';
// import 'package:pharma_et/models/Success.dart';
// import 'package:pharma_et/utils/Constants.dart';

// class AuthController {
//   static Future<Either<ErrorMessage, SuccessMessage>> signupUser({
//     required String firstName,
//     required String lastName,
//     required String phoneNumber,
//     required String email,
//     required String password,
//   }) async {
//     try {
//       auth.verifyPhoneNumber(
//         verificationCompleted: (phoneAuthCredential) {},
//         verificationFailed: (error) {
//           throw Exception("Verification failed");
//         },
//         codeSent: (verificationId, forceResendingToken) {
//           GoRouter.of(context).pushReplacementNamed("otp");
//         },
//         codeAutoRetrievalTimeout: (verificationId) {
//           throw Exception("Verification code expired");
//         },
//       );
//     } on FirebaseAuthException catch (_) {
//       return left(ErrorMessage(body: "Email already in use."));
//     } on FirebaseException catch (e) {
//       await auth.currentUser!.delete();
//       return left(ErrorMessage(body: e.message!));
//     } catch (e) {
//       await auth.currentUser!.delete();
//       return left(ErrorMessage(body: e.toString()));
//     }
//   }

//   static Future<Either<ErrorMessage, SuccessMessage>> loginUser({
//     required String emailPhoneNumber,
//     required String password,
//   }) async {
//     try {
//       if (emailRegex.hasMatch(emailPhoneNumber)) {
//         await auth.signInWithEmailAndPassword(
//           email: emailPhoneNumber,
//           password: password,
//         );
//       } else {
//         // await auth.signInWithPhoneNumber(emailPhoneNumber);
//       }
//       return right(SuccessMessage(body: "Logged in successfully!"));
//     } on FirebaseAuthException catch (_) {
//       return left(ErrorMessage(body: "Incorrect email or password."));
//     } on FirebaseException catch (_) {
//       return left(ErrorMessage(body: "Unable to fetch user data"));
//     } catch (e) {
//       return left(ErrorMessage(body: e.toString()));
//     }
//   }
// }
