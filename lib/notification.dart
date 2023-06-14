import 'dart:convert';

import 'package:demo1/api.dart';
import 'package:demo1/homepage.dart';
import 'package:demo1/profile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ClassNotify extends StatefulWidget {
  const ClassNotify({Key? key}) : super(key: key);

  @override
  State<ClassNotify> createState() => _ClassNotifyState();
}

class _ClassNotifyState extends State<ClassNotify> {

  int currentTab = 1;
  final List<Widget> screen =[
    HomePage(),
    ClassNotify(),
    Profile(),

  ];

  Widget currentScreen = ClassNotify();

  List _loaddata=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }
  _fetchData() async {
    var res = await Api()
        .getData('/api/notificationlist');
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print(items);
      setState(() {
        _loaddata = items;

      });
    } else {
      setState(() {
        _loaddata = [];
        Fluttertoast.showToast(
          msg:"Currently there is no data available",
          backgroundColor: Colors.grey,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
      //             /*  new Image.asset('icon/home.png',
      //               height: 35,
      //               width: 55,
      //             ),
      //            */
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
      //             // new Image.asset('icon/notification.png',
      //             //   height: 40,
      //             //   width: 60,
      //             // ),
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
      //             // new Image.asset('icon/user.png',
      //             //   height: 35,
      //             //   width: 55,
      //             // ),
      //             Icon(Icons.person_outline_outlined,size: 30,color: currentTab==2 ? Colors.blue : Colors.black),
      //             Text('Profile',style: TextStyle(fontWeight: FontWeight.bold,color: currentTab==2 ? Colors.blue : Colors.black),)
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),

      appBar: AppBar(
        title: Text('Notifications',),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),

      ),

      // body: Padding(
      //   padding: EdgeInsets.all(5),
      //   child: ListView.separated(
      //       itemBuilder: (context,index){
      //         return ListTile(
      //           leading: CircleAvatar(
      //               radius: 26,
      //             backgroundColor: Colors.blue,
      //               child: Icon(Icons.notifications, size: 30,color: Colors.white,)
      //           ) ,
      //           title: Text(_loaddata[index]['notification_title'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
      //           subtitle: Text(_loaddata[index]['notification_content'],style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,),
      //           trailing: Text(_loaddata[index]['notification_date'],style: TextStyle(fontSize: 15)),
      //         );
      //       },
      //       separatorBuilder: (context, index) {
      //         return Divider(height: 30, thickness: 1,);
      //       },
      //       itemCount: _loaddata.length,
      //
      //   ),
      // )


        body: ListView.builder(
          shrinkWrap: true,
          itemCount: _loaddata.length,
          itemBuilder: (context,index){
            //String orphanage_name=(_loaddata[index]['orphanage_name']).toString();
            return Padding(
              padding: const EdgeInsets.only(top: 16,right: 12,left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white60,
                        child: Icon(Icons.notifications_outlined,color: Colors.blue,size: 36,),
                      ),
                      SizedBox(width: 16,),
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_loaddata[index]['notification_title'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                            SizedBox(height: 5,),
                            //Text('Conducted By :   ${orphanage_name}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.grey),),
                            //SizedBox(height: 5,),
                            Text(_loaddata[index]['notification_content'],style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,),
                          ],
                        ),
                      ),
                      SizedBox(width: 14,),

                      Text(_loaddata[index]['notification_date'],style: TextStyle(fontSize: 15))
                    ],
                  ),
                  SizedBox(height: 12,),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 2,
                  )
                ],
              ),
            );
          },


        )



    );
  }
}
