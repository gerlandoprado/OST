import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _authentication = FirebaseAuth.instance;

  FirebaseFirestore get db => _firestore;
  FirebaseAuth get auth => _authentication;
}
