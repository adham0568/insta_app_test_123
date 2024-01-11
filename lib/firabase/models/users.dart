import 'package:cloud_firestore/cloud_firestore.dart';

class UserData{
  String Name;
  String Username;
  String EmailAddress;
  String Password;
  String ProfileImage;
  String Uid;
  List Followers;
  List Following;

  UserData(
      {
      required this.EmailAddress,
      required this.Name,
      required this.Password,
      required this.Username,
      required this.ProfileImage,
      required this.Uid,
      required this.Followers,
      required this.Following,

      });

  //convert data frome UserData to  Map<String,Object>


  Map<String, dynamic> Convert2Map(){
  return {
    'Name':Name,
    'Username':Username,
    'EmailAddress':EmailAddress,
    'Password':Password,
    'ProfileImage':ProfileImage,
    'Uid':Uid,
    'Followers':[],
    'Following':[],
  };
}

  static convertSnap2Model(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserData(
      EmailAddress: snapshot["EmailAddress"],
      Name: snapshot["Name"],
      Password: snapshot["Password"],
      ProfileImage: snapshot["ProfileImage"],
      Uid: snapshot["Uid"],
      Username: snapshot["Username"],
      Followers: snapshot["Followers"],
      Following: snapshot["Following"],
    );
  }



}