import 'dart:convert';

import 'package:demo1/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Single_Blog extends StatefulWidget {

  final int id;

  Single_Blog({ required this.id});


  @override
  State<Single_Blog> createState() => _Single_BlogState();
}

class _Single_BlogState extends State<Single_Blog> {

  late SharedPreferences prefs;
  late int oid;
  String title='';
  String content='';
  String image='';
  String orphanage_name='';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewPro();
  }

  Future<void> _viewPro() async {
    prefs = await SharedPreferences.getInstance();

    oid =widget.id;
    print('login_idupdate ${oid}');
    var res = await Api()
        .getData('/api/singleblog/' + oid.toString());
    var body = json.decode(res.body);
    print(body);
    setState(() {
      title = body['data']['blog_title'];
      content = body['data']['blog_content'];
      image=body['data']['blog_image'];
      orphanage_name=body['data']['orphanage_name'];
print(orphanage_name);

    });
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Container(
              height: size.height*.40,
              child: Image.network(
                      Api().url+ image,
                    )

            ),
            SizedBox(height: 24,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Hosted By : ',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.grey),),
                SizedBox(width: 10),
                Text(orphanage_name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.grey),),
              ],
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(content,textAlign: TextAlign.justify,style: TextStyle(fontSize: 17),),
            ),
          ],
        ),
      ),

    );
  }
}
