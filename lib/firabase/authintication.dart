import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instaapp/Pages/Modles/snack.dart';
import 'package:instaapp/Pages/responsive/responsive.dart';

import '../Pages/athonticationPages/loginpage.dart';
import '../Pages/athonticationPages/singuppage.dart';
import '../Pages/screens/home.dart';
import 'models/users.dart';


class AuthMethods{
  SingUp({required imgName, required imgPath,required BuildContext context,required String imagePath}) async {
    String? url;
    final storageRef = FirebaseStorage.instance.ref('$imagePath/$imgName');
    await storageRef.putFile(imgPath);
    /*UploadTask uploadTask = storageRef.putData(imgPath);
    TaskSnapshot snap = await uploadTask;
     url = await snap.ref.getDownloadURL();*///اكواد عرض الصورة على المتصفح
    url = await storageRef.getDownloadURL();
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailaddress.text,
        password: pass.text,
      );
      CollectionReference users = FirebaseFirestore.instance.collection('users');


      UserData usersss = UserData(
          Username: username.text,
          Password: pass.text,
          Name: name.text,
          EmailAddress: emailaddress.text,
          ProfileImage: url,
          Uid: credential.user!.uid,
          Followers:[],
          Following:[],
      );/*الداتا المرسلة الى الداتابيز*/



      showSnackBar(context: context, text: 'تم انشاء الحساب بنجاح');
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => LogInPage()));
      emailaddress.text = '';
      pass.text = '';
      name.text = '';
      username.text = '';
      users
            .doc(credential.user!.uid)
            .set(usersss.Convert2Map())

            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));


         /*==================================================================*/
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
  getUserDetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    return UserData.convertSnap2Model(snap);
  }

}

class Loginclass{
  LogIn(BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress.text,
          password: password.text
      );
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Responsive()));
      emailAddress.text='';
      password.text='';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context: context, text: 'الحساب غير موجود');
      } else if (e.code == 'wrong-password') {
        showSnackBar(context: context, text: 'الرجاء التحقق من كلمة المرور');
      }
    }
  }
}

/*----------*/
