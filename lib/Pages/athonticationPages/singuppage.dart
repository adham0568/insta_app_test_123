import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instaapp/Pages/Modles/snack.dart';
import 'package:path/path.dart' show basename, url;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math';
import '../../firabase/authintication.dart';
import 'loginpage.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({Key? key}) : super(key: key);

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}
bool waiting=false;

final name=TextEditingController();
final username=TextEditingController();
final emailaddress=TextEditingController();
final pass=TextEditingController();
File? imgPath;
String? imgName;
final _formKey = GlobalKey<FormState>();
bool Showpass1=true;

class _SingUpPageState extends State<SingUpPage> {
  Opencamera() async {
    final pickedImg = await ImagePicker().pickImage(source: ImageSource.camera);
    try{if(pickedImg !=null){setState(() {imgPath=File(pickedImg.path);imgName = basename(pickedImg.path);int random = Random().nextInt(9999999);
    imgName = "$random$imgName";});

    }
    else{print('NoImege');}
    }
    catch(e){print(e);}
  }

  OpenStdyo() async {

    final pickedImg = await ImagePicker().pickImage(source: ImageSource.gallery);
    try{if(pickedImg !=null){setState(() {imgPath=File(pickedImg.path);imgName = basename(pickedImg.path);int random = Random().nextInt(9999999);int random1=Random().nextInt(9999999);
    imgName = "$random$random1$imgName";});
    }
    else{print('NoImege');}
    }
    catch(e){print(e);}
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Container(
            margin: EdgeInsets.only(left: 30,right: 30),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                        OpenStdyo();
                        print(imgName);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.grey),
                      child: imgPath==null? Center(child: Text('Add Image')) :CircleAvatar(
                        radius: 100,
                        backgroundImage: FileImage(imgPath!),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    validator: (userName) {return userName!.contains(RegExp(r"^@[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+"))?  null: "أدخل اسم المستحدم";},
                    controller: username,
                    autovalidateMode:
                    AutovalidateMode.onUserInteraction,
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                          color: Colors.grey.shade900,
                          fontWeight: FontWeight.bold),
                      hintText: 'User Name',
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20)),
                      prefixIcon: Icon(Icons.alternate_email),
                      prefixIconColor: Colors.grey.shade900,
                      fillColor: Colors.grey,
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    validator: (Name) {return Name!.contains(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+"))?  null: "أدخل الاسم";},

                    controller: name,
                    autovalidateMode:
                    AutovalidateMode.onUserInteraction,
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                          color: Colors.grey.shade900,
                          fontWeight: FontWeight.bold),
                      hintText: 'Name',
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20)),
                      prefixIcon: Icon(Icons.account_circle),
                      prefixIconColor: Colors.grey.shade900,
                      fillColor: Colors.grey,
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    validator: (email) {return email!.contains(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))?  null: "أدخل بريد الكتروني صالح";},
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailaddress,
                    style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                    //النص الذي سيتم ادخاله
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20)),
                      hintText:'Enter Email' ,
                      hintStyle: TextStyle(color: Colors.grey.shade900),
                      prefixIcon:  Icon(Icons.email),
                      prefixIconColor: Colors.grey.shade900,
                      fillColor: Colors.grey,
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    controller: pass,
                    validator: (value) {return  value!.length<8 ? "ادخل كلمة المرور" : null;},
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                    obscureText: Showpass1,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintStyle:
                      TextStyle(
                          color: Colors.grey.shade900, fontWeight: FontWeight.bold),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20)),
                      prefixIcon: Icon(Icons.password,color: Colors.grey.shade900,),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            Showpass1 = !Showpass1;
                          });
                        },
                        icon: Showpass1
                            ? Icon(
                          Icons.visibility_off,
                          color: Colors.grey.shade900,
                        )
                            : Icon(
                          Icons.remove_red_eye_outlined,
                          color: Colors.grey.shade900,
                        ),
                      ),
                      prefixIconColor: Color.fromRGBO(0, 175, 162, 10),
                      fillColor: Colors.grey,
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 25,),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Colors.grey)),
                      onPressed: ()  async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          waiting=true;
                        });
                        await  AuthMethods().SingUp(imagePath:'Profilesimages' ,imgName: imgName, imgPath: imgPath,context: context,);
                        setState(() {
                          waiting=false;
                        });

                      } else{showSnackBar(context: context,text: 'الرجاء التحقق من البيانات المدخلة');}
                      },
                      child:waiting? CircularProgressIndicator(color: Colors.red,backgroundColor: Colors.white,valueColor: AlwaysStoppedAnimation(Color.fromRGBO(0, 175, 162, 10)),)
                          :Text(
                        'SingUp',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 25),
                      )),
                  SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Do Have Account?',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LogInPage()), (route) => false);
                          },
                          child: Text(
                            'Singin Now',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue,
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}
