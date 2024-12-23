import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final emailRegex = RegExp(r"^[A-Za-z0-9.+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
final nameRegex = RegExp(r"^[A-Za-z]{1,50}$");
final phoneRegex = RegExp(r"^(?:\+251[79]\d{8})$");


// firebase related
final auth = FirebaseAuth.instance;
final db = FirebaseFirestore.instance;
final storage = FirebaseStorage.instance;
