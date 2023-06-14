import 'dart:convert';

import 'package:demo1/api.dart';
import 'package:demo1/forgetpassword.dart';
import 'package:demo1/homepage.dart';
import 'package:demo1/registration.dart';
import 'package:demo1/welcome.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'buttonnavigation.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordVisible=false;
  TextEditingController emailController=TextEditingController();
  TextEditingController pwdController=TextEditingController();
  late SharedPreferences localStorage;
  bool _isLoading = false;
  _pressLoginButton() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'emailController': emailController.text.trim(), //username for email
      'pwdController': pwdController.text.trim()
    };
    print("data${data}");
    var res = await Api().authData(data,'/api/login_users');
    var body = json.decode(res.body);
    print(body);
    if (body['success'] == true) {
      print(body);


      localStorage = await SharedPreferences.getInstance();
      localStorage.setInt('login_id', body['data']['login_id']);
      localStorage.setInt('user_id', body['data']['user_id']);
      localStorage.setString('role', body['data']['role']);

      print('login_id ${body['data']['login_id']}');
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => navigation(),
        ));
      }else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [



              Align(
                  alignment: Alignment.topLeft,
                  child:
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back),)

              ),

              new Image.asset(
                'image/login_new2.jpg',
                width: 360,
                height: 230,
                fit: BoxFit.cover,
              ),

              SizedBox(height: 30,),
              Text("Login",style: TextStyle(fontSize: 39,fontWeight: FontWeight.bold,),),
              SizedBox(height: 27,),

              Text("Welcome back! Login with your Credentials",style: TextStyle(fontSize: 18.5),),

              SizedBox(height: 30,),

              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Text("Email",style: TextStyle(fontSize: 20),),
              // ),

              // SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email address';
                    }
                    // Check if the entered email has the right format
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    // Return null if the entered email is valid
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email,color: Colors.blue,),
                      hintText: "Email ",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(29)
                      )

                  ),


                ),
              ),

              SizedBox(height: 20,),

              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Text("Password",style: TextStyle(fontSize: 20),),
              // ),

              // SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: pwdController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'This field is required';
                    }
                    if (value.trim().length < 6) {
                      return 'Password must be at least 6 characters in length';
                    }
                    // Return null if the entered password is valid
                    return null;
                  },
                  obscureText: passwordVisible,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(passwordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,color: Colors.blue,),
                      onPressed: () {
                        setState(
                              () {
                            passwordVisible = !passwordVisible;
                          },
                        );
                      },
                    ),
                    prefixIcon: Icon(Icons.lock,color: Colors.blue,),
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(29)
                      )
                  ),

                ),
              ),

              SizedBox(height: 6,),

              Align(
                alignment: Alignment.center,
                child: TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPassword()));
                }, child: Text("Forget Password ?",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 16),)),
              ),



              SizedBox(height: 15,),

              ElevatedButton(onPressed: (){
                if (_formKey.currentState!.validate()) {
                  _pressLoginButton();
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Enter a valid data'),
                      backgroundColor: Colors.grey,
                    ),
                  );
                }

                //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
              },
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0)),primary: Colors.blueAccent,fixedSize: Size(300, 57)),
                  child: Text("Login",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),

              SizedBox(height: 15,),

              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",style: TextStyle(fontSize: 16),),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Registration()));
                    }, child: Text("Sign Up",style: TextStyle(
                    fontSize: 16,color: Colors.blue,fontWeight: FontWeight.bold),)),
                    SizedBox(height: 30,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
