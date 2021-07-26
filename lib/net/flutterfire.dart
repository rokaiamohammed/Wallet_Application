import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    print("6");
    return true;
  } catch (e) {
    print(e);
    print("5");
    return false;
  }
}

Future<bool> register(String mail, String passWord) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: mail, password: passWord);
    print("4");
    return true;
  } on FirebaseAuthException catch (e) {
    print("e code " + e.code);
    print(mail);
    if (e.code == 'weak-password') {
      print("email 1" + mail);
      print("the password provided is too weak");
    } else if (e.code == 'email-already-in-use') {
      print("email 2" + mail);
      print("the account already exists for that email");
    } else if (e.code == "invalid-email") {
      print("email 7 " + mail);
    }
    return false;
  } catch (e) {
    print("email 3" + mail);
    print("e/n");
    print(e);
    return false;
  }
}


Future<bool> addCoin(String id,String amount) async {
  try {
    String uid = FirebaseAuth.instance.currentUser.uid;
    var value = double.parse(amount);
    DocumentReference docRef = FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .collection("Coins")
        .doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async{
      DocumentSnapshot snapshot=await transaction.get(docRef);
      if(!snapshot.exists){
        docRef.set({"Amount":value});
        return true;
      }
      double newAmount=snapshot.data()['Amount']+value;
      transaction.update(docRef,{'Amount':newAmount});
      return true;
    });
  } catch (e) {
    return false;
  }
  return false;
}
Future<bool> remove(String id)async{
  String uid = FirebaseAuth.instance.currentUser.uid;
  FirebaseFirestore.instance.collection('Users').doc(uid).collection('Coins').doc(id).delete();
  return true;
}
