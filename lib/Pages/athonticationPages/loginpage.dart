import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instaapp/Pages/athonticationPages/singuppage.dart';
import 'package:instaapp/Pages/screens/home.dart';

import '../../firabase/authintication.dart';
import '../Modles/snack.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}
bool waiting1=false;



final emailAddress=TextEditingController();
final password=TextEditingController();
bool Showpass=false;
bool login=false;

Loginclass fire=Loginclass();


class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 50,right: 50),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                TextFormField(
                  validator: (email) {return email!.contains(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))?  null: "أدخل بريد الكتروني صالح";},
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: emailAddress,
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
                SizedBox(height: 5,),
                TextFormField(
                  controller: password,
                  validator: (value) {return  value!.length<8 ? "ادخل كلمة المرور" : null;},
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.bold),
                  obscureText: Showpass,
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
                          Showpass = !Showpass;
                        });
                      },
                      icon: Showpass
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
                SizedBox(height: 15,),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.grey)),
                    onPressed: ()  async {
                        setState(() {
                          waiting1=true;
                        });
                        await fire.LogIn(context);
                        setState(() {
                          waiting1=false;
                        });
                    },
                    child:waiting1? CircularProgressIndicator(color: Colors.red,backgroundColor: Colors.white,valueColor: AlwaysStoppedAnimation(Color.fromRGBO(0, 175, 162, 10)),)
                        :Text(
                      'LogIn',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25),
                    )),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dont Have Account?!',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context)=>SingUpPage()));
                        },
                        child: Text(
                          'SingUp Now',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue,
                          ),
                        ))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
