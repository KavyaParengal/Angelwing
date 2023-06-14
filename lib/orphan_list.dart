import 'dart:convert';

import 'package:demo1/api.dart';
import 'package:demo1/homepage.dart';
import 'package:demo1/notification.dart';
import 'package:demo1/profile.dart';
import 'package:demo1/single_orphanage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrphanList extends StatefulWidget {
  const OrphanList({Key? key}) : super(key: key);

  @override
  State<OrphanList> createState() => _OrphanListState();
}

class _OrphanListState extends State<OrphanList> {

  Icon customIcon = const Icon(Icons.search);
  //Widget customSearchBar = const Text('My Personal Journal');
 late int orp_id;
List _loaddata=[];
  final List<Widget> screen =[
    HomePage(),
    ClassNotify(),
    Profile(),

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }
  _fetchData() async {
    var res = await Api()
        .getData('/api/vieworphanages');
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

    var size= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Orphanages'),

      ),

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1,vertical: 15),
          child: ListView.separated(
            itemBuilder: (context,index){
              int id=_loaddata[index]['id'];
              print("orphanageid${id}");
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 27,
                  backgroundImage: NetworkImage(
                    Api().url+ _loaddata[index]['orphanage_image'],
                  ),

                ),

                title: Text(_loaddata[index]['orphanage_name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                subtitle: Text(_loaddata[index]['orphanage_address']),
                trailing: IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Single_Orphanage(id:id)));
                  },
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(height: 20, thickness: 1,);
            },
            itemCount: _loaddata.length,


          ),
        )

    );
  }
}
