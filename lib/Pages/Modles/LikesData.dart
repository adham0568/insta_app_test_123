import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instaapp/Pages/screens/person.dart';
import 'package:provider/provider.dart';

import '../../Provider/GetDataFromeDataBase.dart';

class Likes extends StatefulWidget {
Map data;

Likes({required this.data});

  @override
  State<Likes> createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  
  @override
  Widget build(BuildContext context) {

    return widget.data['Like'].isEmpty? Scaffold(
      appBar: AppBar(title: Text('0 Likes'),),
    ): Scaffold(
      appBar: AppBar(
        title: Text('${widget.data['Like'].length}     ' +'Likes',style: TextStyle(fontSize: 20),),
      ),
      body:FutureBuilder(
        future: FirebaseFirestore.instance.collection('users').where('Uid',whereIn: widget.data['Like']).get(),
        builder:
            (BuildContext context, AsyncSnapshot snapshot) {

          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.grey.shade600),
                margin: EdgeInsets.all(10),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage(UIDd:  snapshot.data!.docs[index]['Uid'])));
                  },
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          decoration:
                          BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                snapshot.data!.docs[index]['ProfileImage']),
                          )),
                      Container(
                        margin: EdgeInsets.only(left: 30),
                        child:Text(snapshot.data!.docs[index]['Username'],style: TextStyle(fontSize: 20),),
                      )
                    ],
                  ),
                ),
              ),
            );
          }

          return Text("loading");
        },
      )
    );
  }
}
