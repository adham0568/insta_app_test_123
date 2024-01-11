import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:instaapp/Pages/responsive/responsive.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';
import '../Pages/Modles/snack.dart';
import '../Provider/GetDataFromeDataBase.dart';
import 'models/PostData.dart';

class firestoremetod {
  UpLoadPosts(
      {required String ImagePaths,
      required imgName,
      required imgPath,
      required BuildContext context,
      required String ProfileImage,
      required String Name,
      required String Uid,
      required String Username,
      required String PostText}) async {
    String? url;
    final storageRef =
    FirebaseStorage.instance.ref('PostsImages/$ImagePaths/$imgName');
    await storageRef.putFile(imgPath);
    url = await storageRef.getDownloadURL();
    try {
      String random = const Uuid().v1();
      CollectionReference users =
          FirebaseFirestore.instance.collection('Postes');
      final credential = await FirebaseAuth.instance.currentUser;

      PostData Post = PostData(
        Comments: [],
        PostImage: url,
        ProfileImage: ProfileImage,
        Name: Name,
        DatePublished: DateTime.now(),
        Like: [],
        Postid: random,
        Uid: Uid,
        Username: Username,
        PostText: PostText,
      ); /*الداتا المرسلة الى الداتابيز*/

      users
          .doc(random)
          .set(Post.Convert2Map())
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));

      showSnackBar(context: context, text: 'تم النشر بنجاح');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Responsive()));
      /* emailaddress.text = '';
      pass.text = '';
      name.text = '';
      username.text = '';*/
    } catch (e) {
      print(e);
    }
  }

  /*==================================================================*/
  getUserDetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('Postes')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return PostData.convertSnap2Model(snap);
  }

  addComments(
      {required PostId,
      required ProfileImage,
      required CommentText,
      required Username,
      required Uid,
      required CommintId}) {
    FirebaseFirestore.instance
        .collection('Postes')
        .doc(PostId)
        .collection('coments')
        .doc(CommintId)
        .set({
      'ProfilePicter': ProfileImage,
      'Data': DateTime.now(),
      'CommentText': CommentText,
      'UserName': Username,
      'Uid': Uid,
      'CommentId': CommintId,
    });
  }
}
