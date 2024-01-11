import 'package:flutter/material.dart';
import 'package:instaapp/Pages/screens/person.dart';
import 'package:intl/intl.dart';

Widget CommentDesgine({required BuildContext context,required Map data}){
  return  Container(
    padding: EdgeInsets.all(5),
    margin: EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(3),
              height: 70,
              width: 70,
              decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(70)),
              child: InkWell(onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage(UIDd: data['Uid'])));

              },child: CircleAvatar(backgroundImage: NetworkImage(data['ProfilePicter']),)),
            ),
            Container(
              margin: EdgeInsets.all(7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [Text(data['UserName'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),SizedBox(width: 15,),Text(data['CommentText'],style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15))],),
                  SizedBox(height: 8,),
                  Text(DateFormat('d' '/' 'MMMM')
                      .add_jm()
                      .format(data['Data'].toDate())),
                ],
              ),
            ),
          ],
        ),

        IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border)),
      ],
    ),
  );
}