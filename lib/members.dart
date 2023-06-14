import 'dart:convert';

import 'package:demo1/adoption.dart';
import 'package:demo1/api.dart';
import 'package:demo1/single_member.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Members extends StatefulWidget {
  const Members({Key? key}) : super(key: key);

  @override
  State<Members> createState() => _MembersState();
}

class _MembersState extends State<Members> {

  List _loaddata=[];
  late SharedPreferences prefs;
  late int oid;
  late int logid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }
  _fetchData() async {
    prefs = await SharedPreferences.getInstance();
    oid = (prefs.getInt('orphanage_id') ?? 0);
    print("orphanage id${oid}");
    logid = (prefs.getInt('login_id') ?? 0);
    print("log id${logid}");

    var res = await Api().getData('/api/singleorphanagemembers/' + oid.toString());
    var body = json.decode(res.body);

    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print("Orphans${items}");

      // Filter the items based on orphan status
      var filteredItems = items.where((item) => int.parse(item['orphan_status']) == 0).toList();

      if (filteredItems.isNotEmpty) {
        setState(() {
          _loaddata = filteredItems;
        });
      } else {
        setState(() {
          _loaddata = [];
          Fluttertoast.showToast(
            msg: "Currently there is no data available",
            backgroundColor: Colors.grey,
          );
        });
      }
    } else {
      setState(() {
        _loaddata = [];
        Fluttertoast.showToast(
          msg: "Failed to fetch data",
          backgroundColor: Colors.red,
        );
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orphans'),
      ),

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1,vertical: 15),
          child: ListView.separated(
            itemBuilder: (context,index){
              int id=_loaddata[index]['id'];
              return ListTile(

              //   leading: CircleAvatar(
              //     backgroundColor: Colors.blue,
              //   radius: 26,
              //   backgroundImage: NetworkImage(
              //       Api().url+ _loaddata[index]['orphan_image'],
              // ),
              //
              // ),


                title: Text(_loaddata[index]['orphan_name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                subtitle: Text('Age : '+_loaddata[index]['orphan_age']),
                // trailing: IconButton(
                //   onPressed: (){
                //     Navigator.push(context, MaterialPageRoute(builder: (context)=>Single_Member(id:id)));
                //   },
                //   icon: Icon(Icons.arrow_forward_ios),
                // ),

                trailing: ElevatedButton(onPressed: (){
                  openAlert(id);
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                },
                    style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),primary: Colors.blue,),
                    child: Text("Adopt",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),

              );
            },
            itemCount: _loaddata.length,

            separatorBuilder: (context, index) {
              return Divider(height: 2, thickness: 1,);
            },

          ),
        )

    );
  }

  Future openAlert(int id) =>
      showDialog(
        context: context,
        builder: (context)=> AlertDialog(
          title: Image.asset('image/funeral.png',width: 150,height: 100,),
          content: Text('Only Admin approved users can adopt orphans and also view the deatails of orphan',textAlign: TextAlign.center,style: TextStyle(fontSize: 17),),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Adoption(id:id)));
                },
                child: Text('OK',style: TextStyle(fontSize: 17),)
            )
          ],
        ),
      );

}
