import 'dart:convert';

import 'package:demo1/adoption.dart';
import 'package:demo1/api.dart';
import 'package:demo1/members.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Single_Member extends StatefulWidget {
  final int id;

  Single_Member({ required this.id});


  @override
  State<Single_Member> createState() => _Single_MemberState();
}

class _Single_MemberState extends State<Single_Member> {
  DateTime datetime = DateTime.now();
  late SharedPreferences prefs;
  late int oid;
  late int id;
  late int outid;
  late int orphanageid;
  String name='';
  String age='';
  String gender='';
  String dob='';
  String address='';
  String image='';
  String blood='';
  String hobbies='';
  String datetime1='';
  String message="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewPro();
  }


  Future<void> _viewPro() async {
    prefs = await SharedPreferences.getInstance();
    oid =widget.id;
    print('login_id update ${oid}');
    var res = await Api()
        .getData('/api/singleorphan/' + oid.toString());
    var body = json.decode(res.body);
    print(body);
    setState(() {
      id= body['data']['id'];
      name = body['data']['orphan_name'];
      age = body['data']['orphan_age'];
      gender=body['data']['orphan_gender'];
      dob = body['data']['orphan_dob'];
      address = body['data']['orphan_address'];
      image=body['data']['orphan_image'];
      blood = body['data']['orphan_blood'];
      hobbies=body['data']['orphan_hobbies'];
    });
  }


  bool _isLoading=false;
  void adoptorphan()async {

    datetime1 = DateFormat("yyyy-MM-dd").format(datetime);
    prefs = await SharedPreferences.getInstance();
    outid = (prefs.getInt('login_id') ?? 0 ) ;
    orphanageid = (prefs.getInt('orphanage_id') ?? 0 );
    setState(() {
      _isLoading = true;
    });

    var data = {
      "member": id.toString(),
      "orphlist": orphanageid.toString(),
      "date": datetime1,
      "outsider": outid.toString(),

    };
    print("data${data}");
    var res = await Api().authData(data,'/api/adoption');
    var body = json.decode(res.body);
    print('res${res}');
    if(body['success']==true)
    {
      message=body['message'];
      Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      Navigator.push(context, MaterialPageRoute(builder: (context)=>Members()));

    }
    else
    {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      //Navigator.push(context, MaterialPageRoute(builder: (context)=>Members()));

    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: Row(
        children: [

          Expanded(
            child: Material(
              color: Colors.blue,
              child: InkWell(
                onTap: () {
                  adoptorphan();
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>Adoption()));
                },
                child: const SizedBox(
                  height: kToolbarHeight,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Adopt',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      appBar: AppBar(

      ),

      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1)
                          )
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            Api().url+ image,
                          )
                        )
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 25,),
            
            Text(name,textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

            SizedBox(height: 17,),

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
                            child: Image.asset('icon/age.png',width: 35,height: 35,),
                        ),
                      ),
                      
                    ],
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Age',style: TextStyle(color: Colors.grey[600]),),
                      SizedBox(height: 6,),
                      Text(age,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),)
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
                          child: Image.asset('icon/gender.png',width: 35,height: 35,),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Gender',style: TextStyle(color: Colors.grey[600]),),
                      SizedBox(height: 6,),
                      Text(gender,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17))
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
                          child: Image.asset('icon/date-of-birth.png',width: 35,height: 35,),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date of Birth',style: TextStyle(color: Colors.grey[600]),),
                      SizedBox(height: 6,),
                      Text(dob,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17))
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
                      Text(address,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17))
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
                          child: Image.asset('icon/blood.png',width: 35,height: 35,),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Blood',style: TextStyle(color: Colors.grey[600]),),
                      SizedBox(height: 6,),
                      Text(blood,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17))
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
                          child: Image.asset('icon/hobbies.png',width: 35,height: 35,),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hobbies',style: TextStyle(color: Colors.grey[600]),),
                      SizedBox(height: 6,),
                      Text(hobbies,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17))
                    ],
                  ),
                ],

              ),
            ),


            // Align(
            //   alignment: Alignment.center,
            //   child: ElevatedButton(
            //       onPressed: (){},
            //       child: Text('Adopt',style: TextStyle(fontSize: 18),),
            //     style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0)),fixedSize: Size(180, 53)),
            //   ),
            // ),

            SizedBox(height: 20,)
          ],
        ),
      ),

    );
  }
}
