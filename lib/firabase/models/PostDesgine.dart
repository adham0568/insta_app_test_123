import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instaapp/Pages/screens/CommentPage.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../Pages/Modles/LikesData.dart';

class Postes extends StatefulWidget {
  BuildContext context;
  Map data;


  Postes({required this.context,required this.data});

  @override
  State<Postes> createState() => _PostesState();
}

class _PostesState extends State<Postes> {
  bool showhart=false;
  int CommentsNumber=0;
  CommentsCounts() async {
    var snapshotCommentsCounts= await FirebaseFirestore.instance.collection('Postes').doc(widget.data['Postid']).collection('coments').get();
    setState(() {
      CommentsNumber=snapshotCommentsCounts.docs.length;
    });}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
     CommentsCounts();
   });
  }

  @override
  Widget build(BuildContext context) {


    bool like= widget.data['Like'].contains(FirebaseAuth.instance.currentUser!.uid);
    addLike()  {
      FirebaseFirestore.instance.collection('Postes').doc(widget.data['Postid']).update({'Like':FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])});
      like=true;
    }
    removeLike() async {
      await   FirebaseFirestore.instance.collection('Postes').doc(widget.data['Postid']).update({'Like':FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])});
      like=false;
    }
    final double MobOrWeb = MediaQuery.of(context).size.width;
    return Container(
      margin: MobOrWeb < 600
          ? null
          : EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 4, vertical: 20),
      decoration: BoxDecoration(
          color: MobOrWeb < 600 ? null : Colors.black,
          borderRadius: MobOrWeb < 600 ? null : BorderRadius.circular(15)),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      child: Container(
                          padding: EdgeInsets.all(2),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey, shape: BoxShape.circle),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(widget.data['ProfileImage']),
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.data['Username'],
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                widget.data['Uid']==FirebaseAuth.instance.currentUser!.uid? IconButton(onPressed: () {
                  showDialog(context: context, builder: (context) =>
                    AlertDialog(
                      content: Container(
                        height: 120,
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            TextButton(onPressed: (){
                             // FirebaseFirestore.instance.collection('Postes').doc(widget.data['Postid']).delete();
                              Navigator.pop(context);
                              showDialog(context: context, builder: (context) =>
                                AlertDialog(
                                  content: Container(
                                    height: 120,
                                    child: Column(
                                      children: [
                                        ElevatedButton(onPressed: (){
                                          Navigator.pop(context);
                                        }, child: Text('No'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),),
                                        ElevatedButton(onPressed: (){
                                          FirebaseFirestore.instance.collection('Postes').doc(widget.data['Postid']).delete();
                                          Navigator.pop(context);
                                        }, child: Text('yes'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),),
                                      ],
                                    )
                                  ),
                                )
                                ,);
                            },child: Text('Remove Poste')),
                            TextButton(onPressed: (){},child: Text('SharePoste')),
                          ],
                        ),
                      ),
                    ),);
                }, icon: Icon(Icons.more_vert)):
               ElevatedButton(onPressed: (){

               }, child: Text('Follow')),
              ],
            ),
          ),
          InkWell(
            onDoubleTap: (){
              setState(() {
                addLike();
                showhart=true;});
              Timer(Duration(seconds: 2), () {
                setState(() {
                  showhart=false;
                });
              });
            },
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            widget.data['PostImage'],
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height / 1.5,
                            width: double.infinity,
                          ))),
                ),
                showhart?Positioned(
                  top: 20,
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Container(
                    width: double.infinity,
                    child: Center(
                        child: Icon(Icons.favorite,size: 300,color: Color.fromRGBO(255, 255, 255, 150),)),
                  ),
                ):Container(),
              ],
            ),
          ), //البوست
          Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        //
                        //

                        children: [
                          IconButton(onPressed: (){like?removeLike():addLike();}, icon: widget.data['Like'].contains(FirebaseAuth.instance.currentUser!.uid)?Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_border,color: Colors.white,)),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Comments(data:widget.data ,)));
                          },icon:Icon(Icons.comment_outlined, color: Colors.white,)),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Icon(CupertinoIcons.bookmark)
                    ],
                  ),
                ), //الايقونات
                Container(
                  margin: EdgeInsets.only(left: 10),
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Likes(data:widget.data,)));
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(3),
                      child: Text(
                        widget.data['Like'].length.toString()
                        + '   Likes',
                       style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ), //عدد الايكات
                Container(
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Text(
                        widget.data['Name'],
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        widget.data['PostText'],
                        style: TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                ), //الاسم والوصف
                Container(
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Comments(data: widget.data)));
                          },
                          child: Text("Show Comments"'($CommentsNumber)')),
                    ],
                  ),
                ), //الكومنتات
                Container(
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  child: Text(DateFormat('d' '/' 'MMMM')
                      .add_jm()
                      .format(widget.data['DatePublished'].toDate())),
                ) //التاريخ
              ],
            ),
          ),
        ],
      ),
    );
  }
}

