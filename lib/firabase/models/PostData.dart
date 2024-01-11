import 'package:cloud_firestore/cloud_firestore.dart';

class PostData {
  final String Name;
  final String Username;
  final String ProfileImage;
  final String Uid;
  final String Postid;
  final String PostText;
  final String PostImage;
  final List Like;
  final List Comments;
  final DateTime DatePublished;

  PostData({
    required this.Name,
    required this.Username,
    required this.ProfileImage,
    required this.Uid,
    required this.Postid,
    required this.PostImage,
    required this.Like,
    required this.DatePublished,
    required this.PostText,
    required this.Comments

  });

  Map<String, dynamic> Convert2Map(){
    return {
      'Name':Name,
      'Username':Username,
      'ProfileImage':ProfileImage,
      'PostImage':PostImage,
      'Uid':Uid,
      'Postid':Postid,
      'DatePublished':DatePublished,
      'Like':[],
      'PostText':PostText,
      'Comments':Comments,
    };
  }


  static convertSnap2Model(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return PostData(
      PostImage: snapshot['PostImage'],
      Name: snapshot["Name"],
      Postid: snapshot["Postid"],
      ProfileImage: snapshot["ProfileImage"],
      Uid: snapshot["Uid"],
      Username: snapshot["Username"],
      Like: snapshot["Like"],
      PostText: snapshot["PostText"],
      DatePublished: snapshot["DatePublished"],
      Comments:snapshot['Comments']
    );
  }

}