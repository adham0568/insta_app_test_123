import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instaapp/Pages/screens/person.dart';

class SearchSecreen extends StatefulWidget {
  const SearchSecreen({Key? key}) : super(key: key);

  @override
  State<SearchSecreen> createState() => _SearchSecreenState();
}
final Search =TextEditingController();
String NotFound='';
String vvvv='';


class _SearchSecreenState extends State<SearchSecreen> {
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child:TextFormField(
            onChanged: (value) => setState(() {
              vvvv=Search.text;
              value.length >= 1 ? NotFound='User Not Found':NotFound='';
            }),
            controller:Search,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20)),
              hintText:'Search' ,
              hintStyle: TextStyle(color: Colors.grey.shade900),
              prefixIcon:  Icon(Icons.search_rounded),
              prefixIconColor: Colors.grey.shade900,
              fillColor: Colors.grey,
              filled: true,
            ),
          ),
        ),
      ),
      body:FutureBuilder(
        future:FirebaseFirestore.instance.collection('users').where('Name', isGreaterThanOrEqualTo: Search.text).where('Name', isLessThanOrEqualTo: Search.text +'${vvvv}').get(),
        builder:
            (BuildContext context, AsyncSnapshot snapshot) {

          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      width: double.infinity,
                      child: Center(child: Text('Search results',
                        style: TextStyle(fontSize: 17),))),
                  SizedBox(
                    height: 700,
                    child: snapshot.data!.docs.length<=0?
                    Center(child: Text('$NotFound',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),))
                        :
                    ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      //snapshot.data!.docs[index]['PostImage']
                      itemBuilder: (context, index) =>
                      snapshot.data!.docs[index]['Uid']== FirebaseAuth.instance.currentUser!.uid.toString()?
                      Center(child: null)
                          :
                      InkWell(
                            radius: 50,
                            splashColor: Colors.green,
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage(UIDd: snapshot.data!.docs[index]['Uid'],)
                                /*UserSecreen(
                                Followers:snapshot.data!.docs[index]['Followers'] ,
                                Following: snapshot.data!.docs[index]['Following'],
                                ImageProfile:snapshot.data!.docs[index]['ProfileImage'] ,
                                NameProfile: snapshot.data!.docs[index]['Name'],
                                UserName:snapshot.data!.docs[index]['Username'] ,

                              )*/
                              ));
                            },
                            child: Column(
                              children: [
                                SizedBox(height: 20,),
                                Container(
                                    padding: EdgeInsets.all(15),
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle, color: Colors.grey),
                                            padding: EdgeInsets.all(5),
                                            child: CircleAvatar(
                                              radius: 40,
                                              backgroundImage: NetworkImage(
                                                  snapshot.data!.docs[index]['ProfileImage']),
                                            )), // الصورة
                                        Container(child: Text(
                                          snapshot.data!.docs[index]['Name'], style: TextStyle(fontSize: 25),),),
                                        SizedBox(width: 10,),
                                      ],
                                    )),

                              ],
                            ),
                          ),
                    ),
                  ),
                ],
              ),
            );
          }

          return Center(child:CircularProgressIndicator(backgroundColor: Colors.red,color: Colors.green,));
        },
      )

    );

  }


}
