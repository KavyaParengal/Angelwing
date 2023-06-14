import 'dart:convert';

import 'package:demo1/api.dart';
import 'package:demo1/rules.dart';
import 'package:demo1/single_blog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Blogs extends StatefulWidget {
  const Blogs({Key? key}) : super(key: key);

  @override
  State<Blogs> createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  int _maxLines = 1;
  List _loaddata=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }
  _fetchData() async {
    var res = await Api()
        .getData('/api/bloglist');
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
          title: Text('Blogs'),
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),

        ),

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1,vertical: 15),
          child: ListView.separated(
            itemBuilder: (context,index){
              int id=_loaddata[index]['id'];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _maxLines = 1;
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Single_Blog(id: id)));
                  });
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 30,
                    backgroundImage: NetworkImage(
                      Api().url+ _loaddata[index]['blog_image'],
                    ),
                  ),

                  title: Text(_loaddata[index]['blog_title'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  subtitle: Text(_loaddata[index]['blog_content']+".....",style: TextStyle(fontSize: 16)
                  ,maxLines: _maxLines,

                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text(_loaddata[index]['blog_date'],style: TextStyle(fontSize: 15),)
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
