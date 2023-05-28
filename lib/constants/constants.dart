import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class Constants{
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final IDGenerator = Uuid();
  static final FirebaseStorage storage = FirebaseStorage.instance;
}
