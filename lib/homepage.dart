import 'package:demo1/adoption_notification.dart';
import 'package:demo1/blogs.dart';
import 'package:demo1/event.dart';
import 'package:demo1/feedback.dart';
import 'package:demo1/orphan_list.dart';
import 'package:demo1/rules.dart';
import 'package:demo1/welcome.dart';
import 'package:flutter/material.dart';
import 'package:demo1/notification.dart';
import 'package:demo1/profile.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController searchController=TextEditingController();
  int currentTab = 0;
  final List<Widget> screen =[
    HomePage(),
    ClassNotify(),
    Profile(),

  ];

  Widget currentScreen = HomePage();
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;

    return Scaffold(

      // bottomNavigationBar: Container(
      //   padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
      //   height: 80,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //
      //       GestureDetector(
      //         onTap: () {
      //           setState(() {
      //             currentScreen = HomePage();
      //             currentTab = 0;
      //           });
      //           Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
      //         },
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //
      //             Icon(Icons.home_outlined,size: 30,color: currentTab==0 ? Colors.blue : Colors.black,),
      //
      //             Text('Home',style: TextStyle(fontWeight: FontWeight.bold,color: currentTab==0 ? Colors.blue : Colors.black),)
      //           ],
      //         ),
      //       ),
      //
      //       GestureDetector(
      //         onTap: () {
      //           setState(() {
      //             currentScreen=ClassNotify();
      //             currentTab = 1;
      //           });
      //           Navigator.push(context, MaterialPageRoute(builder: (context)=>ClassNotify()));
      //
      //         },
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //
      //             Icon(Icons.notifications_outlined,size: 30,color: currentTab==1 ? Colors.blue : Colors.black),
      //             Text('Notification',style: TextStyle(fontWeight: FontWeight.bold,color: currentTab==1 ? Colors.blue : Colors.black),)
      //           ],
      //         ),
      //       ),
      //
      //       GestureDetector(
      //         onTap: () {
      //           setState(() {
      //             currentScreen=Profile();
      //             currentTab = 2;
      //           });
      //           Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
      //         },
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //
      //             Icon(Icons.person_outline_outlined,size: 30,color: currentTab==2 ? Colors.blue : Colors.black),
      //             Text('Profile',style: TextStyle(fontWeight: FontWeight.bold,color: currentTab==2 ? Colors.blue : Colors.black),)
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),

      body: Stack(
        children: [
          Container(
            height: size.height * .45,
            decoration: BoxDecoration(
              color: Color(0xFF4FC3F7),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Align(
                     alignment: Alignment.topRight,
                      child: Container(
                        alignment: Alignment.center,
                        height: 53,
                        width: 53,
                        decoration: BoxDecoration(
                          color: Color(0xFF4FC3F7),
                          shape: BoxShape.circle,

                        ),
                      ),
                    ),


                  Text("Welcome to \nAngelWing",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 34),),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    padding: EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                    decoration:BoxDecoration(

                      color: Colors.white,
                      borderRadius: BorderRadius.circular(29.5)
                    ),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search",
                        border: InputBorder.none
                      ),
                    ),
                  ),

                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: [

                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0,17),
                                blurRadius: 17,
                                spreadRadius: -23
                              )
                            ]
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>OrphanList()));
                              },
                              child: Column(
                                children: [

                                  Container(
                                    child: new Image.asset('image/orphanages.webp',
                                      height: 110,
                                      width: 200,
                                      alignment: Alignment.topCenter,
                                    ),
                                  ),
                                  SizedBox(height: 6,),
                                  Text('Orphanages',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)

                                ],
                              ),
                            ),
                          ),
                        ),


                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0,17),
                                    blurRadius: 17,
                                    spreadRadius: -23
                                )
                              ]
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Events()));
                              },
                              child: Column(
                                children: [

                                  Container(
                                    child: new Image.asset('image/event.jpg',
                                      height: 110,
                                      width: 200,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                  SizedBox(height: 6,),
                                  Text('Events',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)

                                ],
                              ),
                            ),
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0,17),
                                  blurRadius: 17,
                                  spreadRadius: -23
                                )
                              ]
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedBack()));
                              },
                              child: Column(
                                children: [

                                  Container(
                                    child: new Image.asset('image/feedback.jpg',
                                      height: 110,
                                      width: 200,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                  SizedBox(height: 6,),
                                  Text('FeedBack',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)

                                ],
                              ),
                            ),
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0,17),
                                    blurRadius: 17,
                                    spreadRadius: -23
                                )
                              ]
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Blogs()));
                              },
                              child: Column(
                                children: [

                                  Container(
                                    child: new Image.asset('image/blog.jpg',
                                      height: 110,
                                      width: 200,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                  SizedBox(height: 6,),
                                  Text('Blogs',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)

                                ],
                              ),
                            ),
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0,17),
                                    blurRadius: 17,
                                    spreadRadius: -23
                                )
                              ]
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Rules()));
                              },
                              child: Column(
                                children: [

                                  Container(
                                    child: new Image.asset('image/rules.jpg',
                                      height: 110,
                                      width: 210,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                  //SizedBox(height: 3,),
                                  Text('Rules and Regulations',textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)

                                ],
                              ),
                            ),
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0,17),
                                    blurRadius: 17,
                                    spreadRadius: -23
                                )
                              ]
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Adoption_notification()));
                              },
                              child: Column(
                                children: [

                                  Container(
                                    child: new Image.asset('image/notify.jpg',
                                      height: 110,
                                      width: 200,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                  Text('Adoption Notification',textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)

                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),



    );
  }
}
