import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' show basename, url;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../Provider/GetDataFromeDataBase.dart';
import '../../firabase/firestore.dart';
import '../Modles/snack.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}
File? imgPath;
String? imgName;
bool Imagedone=false;
final PostesText=TextEditingController();
class _AddPageState extends State<AddPage> {

  Map UserData1={};
  bool Isloading=false;
//
  bool Psting=false;




  Opencamera1() async {
    final pickedImg = await ImagePicker().pickImage(source: ImageSource.camera);
    try{if(pickedImg !=null){setState(() {imgPath=File(pickedImg.path);imgName = basename(pickedImg.path);int random = Random().nextInt(9999999);
    imgName = "$random$imgName";});
      setState(() {
        Imagedone=true;
      });
      Navigator.pop(context);
    }
    else{print('NoImege');}
    }
    catch(e){print(e);}
  }

  OpenStdyo1() async {

    final pickedImg = await ImagePicker().pickImage(source: ImageSource.gallery);
    try{if(pickedImg !=null){setState(() {imgPath=File(pickedImg.path);imgName = basename(pickedImg.path);int random = Random().nextInt(9999999);int random1=Random().nextInt(9999999);
    imgName = "$random$random1$imgName";
    setState(() {
      Imagedone=true;
    });
    Navigator.pop(context);
    });
    }
    else{print('NoImege');}
    }
    catch(e){print(e);}
  }

  @override
  Widget build(BuildContext context) {

    final allDataFromDB = Provider.of<GetDataBase>(context).getUser;

    return Imagedone? Scaffold(
      appBar: AppBar(
        title: IconButton(onPressed: (){
          imgPath=null;
          setState(() {
            Imagedone=false;
          });
        },icon: Icon(Icons.cancel_outlined,size: 30,color: Colors.red,)),
        actions: [
          TextButton(onPressed: () async {
            setState(() {
              Psting=true;
            });
           await firestoremetod().UpLoadPosts(
                ImagePaths:FirebaseAuth.instance.currentUser!.uid.toString() ,
                PostText:PostesText.text,
                imgName: imgName,
                imgPath: imgPath,
                context: context,
                Username: allDataFromDB!.Username,
                Uid: allDataFromDB!.Uid,
                Name: allDataFromDB!.Name,
                ProfileImage: allDataFromDB.ProfileImage);
              setState(() {
                Psting=false;
                Imagedone=false;

              });
            setState(() {Psting=true;
          });
            }, child: Text('نشر',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.blue.shade200),))
        ],
      ),
      body:Isloading?CircularProgressIndicator(): Container(
        margin: EdgeInsets.only(top: 0),
        child: Column(
          children: [
            Psting?LinearProgressIndicator():Divider(thickness: 1,height:3,color: Colors.white),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                  height: 100,
                  width: 100,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(allDataFromDB!.ProfileImage),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.3,
                  child: TextField(
                    controller: PostesText,
                    maxLines: 8,
                    decoration: InputDecoration(
                      hintText: 'اكتب الوصف',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  height: 100,width: 100,
                  child: Image.file(imgPath!),
                )
              ],
            ),
          ],
        ),
      ),
    ):Scaffold(
      body:Container(
        child: Center(child:
        InkWell(
          borderRadius: BorderRadius.circular(50),
            onTap: (){
              showDialog(context: context, builder: (context) {
                return AlertDialog(content:Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            OpenStdyo1();
                          },
                          child: Container(decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(10)),child: Icon(Icons.camera,size: 70,))),
                      SizedBox(width: 20,),
                      InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Opencamera1();
                          },
                          child: Container(decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(10)),child: Icon(Icons.camera_alt,size: 70,))),
                    ],
                  ),
                ),);
              },);
            },
            child: Container(
              height: 200,
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.upload,size: 120,),
                  Text('AddPost',style: TextStyle(fontSize: 30,color: Colors.white),)
                ],
              ),
            )))
      )
    );
  }
}
