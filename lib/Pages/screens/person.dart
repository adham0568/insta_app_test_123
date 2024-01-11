import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instaapp/Pages/Modles/snack.dart';
import 'package:instaapp/firabase/models/PostDesgine.dart';
import 'package:instaapp/firabase/models/postInProfila.dart';
import 'package:provider/provider.dart';
import '../../Provider/GetDataFromeDataBase.dart';
import '../Modles/colors.dart';

class ProfilePage extends StatefulWidget {
  final UIDd;

  ProfilePage({required this.UIDd});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
 late int Followers;
 late int Following;
 late int postCount;
  Map UserData1={};
  bool Isloading=true;

  bool Follow=false;
  GetData() async {
    //get data from DB
  try{DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('users').doc(widget.UIDd).get();
  UserData1=snapshot.data()!;
  Followers=UserData1['Followers'].length;
  Following=UserData1['Following'].length;
  Follow = UserData1['Followers'].contains(FirebaseAuth.instance.currentUser!.uid)?true:false;

  var snapshotpostCounts= await FirebaseFirestore.instance.collection('Postes').where('Uid',isEqualTo:widget.UIDd).get();

  postCount =snapshotpostCounts.docs.length;
  setState(() {
    Isloading=false;
  });

  }
  catch(e){showSnackBar(context: context, text: e.toString());}
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetData();
  }
  @override
  Widget build(BuildContext context) {

    addfollow(){
      Followers++;
      Follow==true;
      //add follow
      FirebaseFirestore.instance.collection('users').doc(widget.UIDd).
      update({'Followers':FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])});
      //add following to curint user
      FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).
      update({'Following':FieldValue.arrayUnion([widget.UIDd])});
    }
    removefollowe(){
      Followers--;
      Follow==false;
      //remove follower
      FirebaseFirestore.instance.collection('users').doc(widget.UIDd).
      update({'Followers':FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])});
      //remove following
      FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).
      update({'Following':FieldValue.arrayRemove([widget.UIDd])});
    }


    final allDataFromDB = Provider.of<GetDataBase>(context).getUser;
    final GetDataFireBase=FirebaseAuth.instance.currentUser;
    final double MobOrWeb=MediaQuery.of(context).size.width;

    return Isloading?Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.red,Colors.blue],begin: Alignment.topCenter,end: Alignment.bottomCenter)),
        child: Center(child: CircularProgressIndicator(backgroundColor: Colors.red,color: Colors.blue,))):Scaffold(
      appBar:MobOrWeb>600?null: AppBar(
        title: SvgPicture.asset('assets/svg_image/instagram.svg',color: Colors.white,height: 35,),
        actions: [
          Center(child: Text(UserData1['Name'],style: TextStyle(fontSize: 15,color: Colors.white))),
        ],
      ),
      body:Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Text(Following.toString()),
                                SizedBox(height: 8,),
                                Text('Following'),
                              ],
                            ),),//يتابع
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Text(Followers.toString()),
                                SizedBox(height: 8,),
                                Text('Followers'),
                              ],
                            ),),//المتابعين
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Text(postCount.toString()),
                                SizedBox(height: 8,),
                                Text('Posts'),
                              ],
                            ),),//المنشورات
                        ],
                      ),
                    ),//تفاصيل
                    SizedBox(width: 10,),
                    Container(
                      height: 110,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.grey),
                            padding: EdgeInsets.all(3),
                            height: 80,
                            width: 80,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(UserData1['ProfileImage']),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                              child: Text(UserData1['Name'],style: TextStyle(fontSize: 15,color: Colors.white),)),//اسم الحساب

                        ],
                      ),
                    ),//الصورة و الاسم

                  ],
                ),
              ),//المتابعين والبوستات ويتابع
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Text('لتعلم مصر ومن في العراق ومن بلعواصم اني الفتى  واني وفيت واني ابيت واني عتوت على من عتى',style: TextStyle(fontSize: 10),),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Container(
                child:
                widget.UIDd==FirebaseAuth.instance.currentUser!.uid?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: (){}, child: Text('Edit Profile'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey),
                        fixedSize: MaterialStatePropertyAll(Size.fromWidth(170))
                    ),),
                    SizedBox(width: 40,),
                    ElevatedButton(onPressed: (){}, child: Text('Share Profile'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey),
                        fixedSize: MaterialStatePropertyAll(Size.fromWidth(170))
                    ),),

                  ],
                )
                    :
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          List adham = UserData1['Followers'];
                          setState(() {
                            Follow=!Follow;
                          });
                          if(Follow==true){
                            addfollow();
                          }
                          else if(Follow==false){
                            removefollowe();
                          }
                        },
                        child: Text(Follow?'unFollow':'Follow'),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Follow?Colors.red:Colors.blue),
                            fixedSize: MaterialStatePropertyAll(Size.fromWidth(170))),
                      ),
                      SizedBox(
                        width: 40,
                      ),


                    ],
                  ),
                ),
              ),
              SizedBox(height: 25,),
          FutureBuilder(
            future: FirebaseFirestore.instance.collection('Postes').where('Uid',isEqualTo:widget.UIDd).get(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              if (snapshot.hasError) {
                return Text("Something went wrong");
              }
              if (snapshot.connectionState == ConnectionState.done) {

                return Container(
                  color: mobileBackgroundColor,
                  height: 600,
                  child:GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          showModalBottomSheet(context: context, builder: (context) {
                            return Postes1(
                                Image2: snapshot.data!.docs[index]['PostImage'],
                                context: context,
                                Image1: snapshot.data!.docs[index]['ProfileImage'],
                                Name: snapshot.data!.docs[index]['Name'],
                                userName: snapshot.data!.docs[index]['Username'],
                                Like: snapshot.data!.docs[index]['Like'],
                                PostText: snapshot.data!.docs[index]['PostText']);},
                            isScrollControlled: true,
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 5),
                          height: 10,
                          width: 10,
                          child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.network(snapshot.data!.docs[index]['PostImage'])),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 4/3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                  ),
                );//المنشورات

              }

              return Center(child: CircularProgressIndicator(color: Colors.white,backgroundColor: Colors.red,));
            },
          )

            ],
          ),
        ),
      ),
    );



  }
}

/**/

/**/

/**/

