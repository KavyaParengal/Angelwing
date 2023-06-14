import 'package:demo1/login.dart';
import 'package:demo1/registration.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text("Hello There!",style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold),),
          // SizedBox(height: 30,),
          //
          // Align(
          //   alignment: Alignment.center,
          //   child: Text("Automatic identity verification which enable you to verify your identity",style: TextStyle(fontSize: 16,),textAlign: TextAlign.center,),
          // ),
          //
          // SizedBox(height: 40,),

          new Image.asset(
            'image/welcome.jpg',
            width: 540.0,
            height: 350.0,
            fit: BoxFit.cover,
          ),

          SizedBox(height: 40,),

          Text("Welcome to AngelWing",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
          SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("God called us to care for orphans as if they were our own children",textAlign: TextAlign.center,style: TextStyle(fontSize: 16),),
            ),

          SizedBox(height: 35,),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
          },
            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0)),primary: Colors.blue,fixedSize: Size(280, 57)),
            child: Text("Login",style: TextStyle(
            fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold
          ),),),

          SizedBox(height: 17,),

          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Registration()));
          },
            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0)),primary: Colors.blue,fixedSize: Size(280, 57)),
            child: Text("Sign UP",
             style: TextStyle(
               fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold,
             )),)
        ],
      ),
    );


  }
}

