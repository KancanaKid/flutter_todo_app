import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseManager {
  static FirebaseApp init(){
    return Firebase.app("Flutter Todo App");
  }

  static DatabaseReference databaseReference(String child){
    return FirebaseDatabase.instance.ref(child);
  }

  static FirebaseDatabase firebaseDatabase(){
    return FirebaseDatabase.instance;
  }
}