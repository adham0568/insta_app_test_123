 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instaapp/Pages/Modles/CommentsDesgine.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../Provider/GetDataFromeDataBase.dart';
import '../../firabase/firestore.dart';

class Comments extends StatefulWidget {
  Map data;


  Comments({required this.data});

  @override
   State<Comments> createState() => _CommentsState();
 }
final CommentText=TextEditingController();

class _CommentsState extends State<Comments> {
   @override
   Widget build(BuildContext context) {
     final allDataFromeDataBase =Provider.of<GetDataBase>(context).getUser;
     return Scaffold(
       appBar: AppBar(
         title: Text('Comments'),
       ),
       body: Container(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
           StreamBuilder<QuerySnapshot>(
           stream: FirebaseFirestore.instance.collection('Postes').doc(widget.data['Postid']).collection('coments').orderBy('Data',descending: true).snapshots(),
           builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
             if (snapshot.hasError) {
               return Text('Something went wrong');
             }

             if (snapshot.connectionState == ConnectionState.waiting) {
               return Text("Loading");
             }

             return Expanded(
               child: ListView(
                 children: snapshot.data!.docs.map((DocumentSnapshot document) {
                   Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                   return CommentDesgine(context: context,data: data);
                 }).toList(),
               ),
             );
           },
         ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Container(
                   padding: EdgeInsets.all(2),
                   height: 50,
                   width: 50,
                   decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(70)),
                   child: CircleAvatar(backgroundImage: NetworkImage(allDataFromeDataBase!.ProfileImage),),
                 ),
                 Container(
                   padding: EdgeInsets.all(5),
                   width:MediaQuery.of(context).size.width/1.2 ,
                   child: TextField(
                     controller: CommentText,
                     decoration:InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                       suffixIcon: IconButton(onPressed: () async {
                         String CommentsId= Uuid().v1();
                         CommentText.text.isEmpty?print('Fuck') :firestoremetod().addComments(
                             PostId: widget.data['Postid'],
                             ProfileImage: allDataFromeDataBase.ProfileImage,
                             CommentText: CommentText.text,
                             Username: allDataFromeDataBase.Username,
                             Uid: allDataFromeDataBase.Uid,
                             CommintId: CommentsId
                         );
                            setState(() {
                           CommentText.text='';
                         });
                       },icon: Icon(Icons.send),)),
                   ),
                 )
               ],
             )
           ],
         ),
       ),
     );
   }
 }


