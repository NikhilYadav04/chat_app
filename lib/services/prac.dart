// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class AuthService {
//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

//   Future regusterUser(String Nam,String Email, String Password) async {
//     try {
//       User user = (await firebaseAuth.createUserWithEmailAndPassword(
//               email: Email, password: Password))
//           .user!;

//       if(user!=null){

//       }
//     } on FirebaseAuthException catch (e) {
//       print(e);
//       return e.message;
//     }
//   }
// }

// class DatabaseServices{
//   String? uID;
//   DatabaseServices({required this.uID});

//   final CollectionReference collectionReference = FirebaseFirestore.instance.collection("users");

//   Future updateData(String Name,String Email) async{
//   await collectionReference.doc(uID)
//   }
// }
