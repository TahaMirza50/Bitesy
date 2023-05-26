import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Constants{
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final IDGenerator = Uuid();
}
