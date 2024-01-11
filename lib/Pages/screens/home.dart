import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instaapp/Pages/athonticationPages/loginpage.dart';
import 'package:instaapp/firabase/models/PostDesgine.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    final double MobOrWeb=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:MobOrWeb>600?null: AppBar(
        title: SvgPicture.asset('assets/svg_image/instagram.svg',color: Colors.white,height: 35,),
        actions: [

           IconButton(onPressed: () async {
             await FirebaseAuth.instance.signOut();
             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LogInPage()),(route)=>false);
                     }, icon: Icon(Icons.logout)),
          Container(margin: EdgeInsets.only(left: 5,right: 5),child: Icon(Icons.message_sharp,color: Colors.white,)),
        ],
      ),

      body:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Postes').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),);
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return SizedBox(
                child: Postes(data:data ,context: context),
              );
            }).toList(),
          );
        },
      ),


    );
  }
}
