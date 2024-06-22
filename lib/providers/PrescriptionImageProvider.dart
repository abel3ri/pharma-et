import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as p;
import "package:path_provider/path_provider.dart";

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pharma_et/models/Error.dart';
import 'package:pharma_et/models/Success.dart';
import 'package:pharma_et/utils/Constants.dart';

class PrescriptionImageProvider with ChangeNotifier {
  String? _prescriptionImagePath;
  String? _prescriptionImageName;
  bool _isLoading = false;

  void setPrescriptionImagePathAndName(String? path, String? name) {
    _prescriptionImagePath = path;
    _prescriptionImageName = name;
    notifyListeners();
  }

  Future<Either<ErrorMessage, SuccessMessage>> uploadPresciptionImage() async {
    try {
      final path = p.join((await getTemporaryDirectory()).path,
          "${DateTime.now()}.${p.extension(prescriptionImagePath!)}.jpg");
      print(path);
      final ref = storage
          .ref()
          .child("prescriptions/${DateTime.now().millisecondsSinceEpoch}");
      print(prescriptionImagePath);
      final res = await FlutterImageCompress.compressAndGetFile(
        File(prescriptionImagePath!).absolute.path,
        path,
        quality: 50,
        minHeight: 720,
        minWidth: 720,
      );
      UploadTask uploadTask = ref.putFile(File(res!.path));
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      await db.collection("users").doc(auth.currentUser!.uid).update({
        "uploadedPrescriptions": FieldValue.arrayUnion(
          [
            {
              "url": downloadUrl,
              "date": DateTime.now(),
            }
          ],
        ),
      });
      return right(
        SuccessMessage(body: "Successfully uploaded prescription image"),
      );
    } on FirebaseException catch (_) {
      return left(ErrorMessage(body: "Error uploading image"));
    } catch (e) {
      return left(ErrorMessage(body: e.toString()));
    }
  }

  void toggleIsLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  String? get prescriptionImagePath => _prescriptionImagePath;
  String? get prescriptionImageName => _prescriptionImageName;
}
