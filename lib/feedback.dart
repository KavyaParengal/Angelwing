import 'dart:convert';

import 'package:demo1/api.dart';
import 'package:demo1/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'members.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({Key? key}) : super(key: key);

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {

  TextEditingController feedbackController=TextEditingController();
  late SharedPreferences prefs;
  late int user_id;
  bool _isLoading=false;
  void feedback()async {
    prefs = await SharedPreferences.getInstance();
    user_id = (prefs.getInt('user_id') ?? 0 );
    setState(() {
      _isLoading = true;
    });

    var data = {
      "content": feedbackController.text,
      "user":user_id.toString(),


    };
    print("data${data}");
    var res = await Api().authData(data,'/api/feedback');
    var body = json.decode(res.body);
    print(body);
    if(body['success'] == true)
    {



      print('body${body}');
    Fluttertoast.showToast(
      msg: body['message'].toString(),
      backgroundColor: Colors.grey,
    );

      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
    }
    else
    {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(

      bottomNavigationBar: Row(
        children: [

          Expanded(
            child: Material(
              color: Colors.blue,
              child: InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    feedback();
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Enter some text'),
                        backgroundColor: Colors.grey,
                      ),
                    );
                  }

                },
                child: const SizedBox(
                  height: kToolbarHeight,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Submit',
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
        title: Text('FeedBack'),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),

      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height*.35,
                child:
                  Image.asset('image/feedback.jpg',
                    fit: BoxFit.cover,
                  ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12,right: 12,top: 20),
                child: Container(
                  height: 350.0,
                  child: Stack(
                    children: [
                      TextFormField(
                        controller: feedbackController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        maxLines: 10,
                        decoration: InputDecoration(
                          hintText: 'Please briefly describe the issue',
                          hintStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.grey
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),

                        ),
                      ),



                      // Align(
                      //   alignment: Alignment.bottomCenter,
                      //   child: Container(
                      //     child: ElevatedButton(
                      //       onPressed: (){
                      //
                      //       },
                      //       child: Text('Submit',style: TextStyle(fontSize: 19),),
                      //       style: ElevatedButton.styleFrom(fixedSize: Size(230, 55),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0))),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),

                ),


              ),
            ],
          ),
        ),
      ),

    );
  }
}
