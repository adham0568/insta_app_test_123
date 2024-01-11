import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../Pages/screens/CommentPage.dart';

Widget Postes1(
    {required BuildContext context,
    required String Image1,
    required String Name,
    required String userName,
//    required String Date,
    required List Like,
    required String PostText,required String Image2}) {
  final double MobOrWeb = MediaQuery.of(context).size.width;

  return InkWell(
    onTap: (){

      Navigator.pop(context);
    },
    child: SingleChildScrollView(
      child: Container(
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
                              backgroundImage: NetworkImage('$Image1'),
                            )),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                       userName,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
                ],
              ),
            ),
            Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(Image2,
                      fit: BoxFit.cover,
                    ))), //البوست
            Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            /*IconButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Comments()));
                            },icon:Icon(Icons.comment_outlined, color: Colors.white,)),*/
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
                    child: Text(
                      Like.length.toString(),
                      style: TextStyle(fontSize: 15),
                    ),
                  ), //عدد الايكات
                  Container(
                    margin: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Text(
                         Name,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          PostText,
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
                            onTap: () {},
                            child: Text(
                              'show all 100 comments',
                            )),
                      ],
                    ),
                  ), //الكومنتات
                 /* Container(
                    margin: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Text(DateFormat('d' '/' 'MMMM')
                        .add_jm()
                        .format(Dateposting)),
                  ) //التاريخ*/
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
