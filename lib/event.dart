import 'dart:convert';

import 'package:demo1/api.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {

  List _loaddata=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }
  _fetchData() async {
    var res = await Api()
        .getData('/api/eventlist');
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
        title: Text('Events'),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),

        // body: Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 1,vertical: 15),
        //   child: ListView.separated(
        //     itemBuilder: (context,index){
        //       String date =_loaddata[index]['event_date'];
        //       String time =_loaddata[index]['event_time'];
        //       return ListTile(
        //         leading: CircleAvatar(
        //           radius: 26,
        //           backgroundColor: Colors.blue,
        //             child: Icon(Icons.event, size: 30,color: Colors.white,)
        //         ) ,
        //         title: Column(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           children: [
        //             Text(_loaddata[index]['event_name'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
        //             Text('data')
        //           ],
        //         ),
        //         subtitle: Text(_loaddata[index]['event_content'],style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,),
        //         trailing: Text('${date}\n${time}',style: TextStyle(fontSize: 15)),
        //       );
        //     },
        //     separatorBuilder: (context, index) {
        //       return Divider(height: 30, thickness: 1,);
        //     },
        //     itemCount: _loaddata.length,
        //
        //
        //   ),
        // )


       body: ListView.builder(
         shrinkWrap: true,
         itemCount: _loaddata.length,
         itemBuilder: (context,index){
           String date =_loaddata[index]['event_date'];
           String time =_loaddata[index]['event_time'];
           String place=_loaddata[index]['event_place'];
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
                       child: Icon(Icons.event,color: Colors.blue,size: 38,),
                     ),
                     SizedBox(width: 16,),
                     Expanded(
                       flex: 6,
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(_loaddata[index]['event_name'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                           SizedBox(height: 5,),
                           //Text('Conducted By :   ${orphanage_name}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.grey),),
                           //SizedBox(height: 5,),
                           Text(_loaddata[index]['event_content'],style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,),
                           SizedBox(height: 5,),
                           Text('Place :   ${place}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.grey)),
                         ],
                       ),
                     ),
                     SizedBox(width: 14,),

                     Text('${date}\n${time}',style: TextStyle(fontSize: 15))
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
