import 'dart:convert';

import 'package:demo1/api.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Rules_and_Regulations extends StatefulWidget {
  const Rules_and_Regulations({Key? key}) : super(key: key);

  @override
  State<Rules_and_Regulations> createState() => _Rules_and_RegulationsState();
}

class _Rules_and_RegulationsState extends State<Rules_and_Regulations> {
  List _loaddata=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }
  _fetchData() async {
    var res = await Api()
        .getData('/api/rulesview');
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
      appBar: AppBar(
        title: Text('Rules and regulations'),
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
            padding: const EdgeInsets.only(top: 20,right: 10,left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_loaddata[index]['rule_title'],
                    style: TextStyle(
                    fontWeight: FontWeight.bold,
                        fontSize: 17
                    ),
                  ),
                  SizedBox(height: 9,),
                  Text(_loaddata[index]['rule_date'],
                    style: TextStyle(
                    color: Colors.grey[500],
                        fontSize: 16
                    ),
                  ),
                  SizedBox(height: 25,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_loaddata[index]['rule_content'],textAlign: TextAlign.justify,style: TextStyle(fontSize: 15),),
                    ),
                  SizedBox(height: 10,),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 2,
                  )
                ],
            ),
          );
        },


      ),

    );
  }
}
