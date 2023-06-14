
import 'dart:convert';

import 'package:demo1/api.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Adoption_notification extends StatefulWidget {
  const Adoption_notification({Key? key}) : super(key: key);

  @override
  State<Adoption_notification> createState() => _Adoption_notificationState();
}

class _Adoption_notificationState extends State<Adoption_notification> {

  List _loaddata=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  late SharedPreferences prefs;
  late int user_id;
  bool _isLoading=false;
  _fetchData() async {

    prefs = await SharedPreferences.getInstance();
    user_id = (prefs.getInt('user_id') ?? 0 );
    print('======== ${user_id}');
    setState(() {
      _isLoading = true;
    });


    var res = await Api()
        .getData('/api/view_AdoptionNotify/'+ user_id.toString());
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
          title: Text('Adoption Notifications',),
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),

        ),


        body: ListView.builder(
          shrinkWrap: true,
          itemCount: _loaddata.length,
          itemBuilder: (context,index){
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
                            Text(_loaddata[index]['ad_notify_title'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                            SizedBox(height: 5,),
                            Text(_loaddata[index]['ad_notify_content'],style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,),
                          ],
                        ),
                      ),
                      SizedBox(width: 14,),

                      Text(_loaddata[index]['ad_notiy_date'],style: TextStyle(fontSize: 15))
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
