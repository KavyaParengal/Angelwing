
import 'dart:convert';

import 'package:demo1/api.dart';
import 'package:demo1/buttonnavigation.dart';
import 'package:demo1/chat.dart';
import 'package:demo1/cloth_donation.dart';
import 'package:demo1/food_donation.dart';
import 'package:demo1/homepage.dart';
import 'package:demo1/members.dart';
import 'package:demo1/money_donation.dart';
import 'package:demo1/notification.dart';
import 'package:demo1/profile.dart';
import 'package:demo1/rules_regulations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Single_Orphanage extends StatefulWidget {
  final int id;

  Single_Orphanage({ required this.id});

  @override
  State<Single_Orphanage> createState() => _Single_OrphanageState();
}

class _Single_OrphanageState extends State<Single_Orphanage> {

  late SharedPreferences prefs;
  late int oid;
  String email='';
  String name='';
  String address='';
  String contact='';
  String description='';
  String image='';
  final List<Widget> screen = [
    HomePage(),
    ClassNotify(),
    Profile(),

  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewPro();
  }

  Future<void> _viewPro() async {
    prefs = await SharedPreferences.getInstance();
    oid =widget.id;
    prefs.setInt('orphanage_id', oid);

    var res = await Api()
        .getData('/api/singleorphanage/' + oid.toString());
    var body = json.decode(res.body);


    setState(() {
      name = body['data']['orphanage_name'];
      address = body['data']['orphanage_address'];
      email=body['data']['orphanage_email'];
      contact = body['data']['orphanage_contact'];
      description = body['data']['orphanage_description'];
      image=body['data']['orphanage_image'];
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Scaffold(

      // bottomNavigationBar: Container(
      //   padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      //   height: 80,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //
      //       GestureDetector(
      //         onTap: () {
      //           setState(() {
      //
      //           });
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => navigation()));
      //         },
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //
      //             Icon(Icons.home_outlined,),
      //             /*  new Image.asset('icon/home.png',
      //               height: 35,
      //               width: 55,
      //             ),
      //            */
      //             Text('Home',)
      //           ],
      //         ),
      //       ),
      //
      //       GestureDetector(
      //         onTap: () {
      //           setState(() {
      //
      //           });
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => ClassNotify()));
      //         },
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //             // new Image.asset('icon/notification.png',
      //             //   height: 40,
      //             //   width: 60,
      //             // ),
      //             Icon(Icons.notifications_outlined,),
      //             Text('Notification',)
      //           ],
      //         ),
      //       ),
      //
      //       GestureDetector(
      //         onTap: () {
      //           setState(() {
      //
      //           });
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => Profile()));
      //         },
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //             // new Image.asset('icon/user.png',
      //             //   height: 35,
      //             //   width: 55,
      //             // ),
      //             Icon(Icons.person_outline_outlined,),
      //             Text('Profile',)
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),


      appBar: AppBar(
        title: Text(name),
      ),
      endDrawer: NavDrawer(),


      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.message_outlined,),
      //   onPressed: () {
      //     Navigator.push(context, MaterialPageRoute(builder: (context)=>Chat()));
      //   },
      //   tooltip: "Chat with us",
      //   highlightElevation: 50,
      // ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: size.height * .30,
                width: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          Api().url+ image,
                        )
                    )
                ),
              ),
            ),
            SizedBox(height: 20,),

            Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Row(
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: CupertinoColors.systemGrey3,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Image.asset('icon/location.png',width: 35,height: 35,),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Address',style: TextStyle(color: Colors.grey[600]),),
                      SizedBox(height: 6,),
                      Text(address,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),)
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Row(
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius:24,
                        backgroundColor:Colors.grey[300],
                        child: CircleAvatar(
                          backgroundColor:Colors.white,
                          child: Image.asset('icon/email.png',width: 35,height: 35,),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email',style: TextStyle(color: Colors.grey[600]),),
                      SizedBox(height: 6,),
                      Text(email,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17))
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Row(
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius:24,
                        backgroundColor:Colors.grey[300],
                        child: CircleAvatar(
                          backgroundColor:Colors.white,
                          child: Image.asset('icon/phone-call.png',width: 35,height: 35,),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Phone Number',style: TextStyle(color: Colors.grey[600]),),
                      SizedBox(height: 6,),
                      Text(contact,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17))
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius:24,
                        backgroundColor:Colors.grey[300],
                        child: CircleAvatar(
                          backgroundColor:Colors.white,
                          child: Image.asset('icon/information.png',width: 35,height: 35,),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Description',style: TextStyle(color: Colors.grey[600]),),
                        SizedBox(height: 6,),
                        Text(description,
                         //   overflow: TextOverflow.ellipsis,
                         //   textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,

                            )
                            )

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('image/orphanages.webp'))), child: null,
          ),
          ListTile(
            title: Text('Members',),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Members()));
            },
          ),
          ListTile(
            title: Text('Food Donation'),
              trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Food_Donation()));
            }
          ),
          ListTile(
            title: Text('Money Donation'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Money_Donation()));
            },
          ),
          ListTile(
            title: Text('Cloth Donation'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Cloth_donation()));
              },
          ),
          ListTile(
            title: Text('Rule and Regulations',),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Rules_and_Regulations()));
            },
          ),



        ],
      ),

    );
  }
}

