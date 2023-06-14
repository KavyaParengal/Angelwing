
import 'dart:convert';

import 'package:demo1/api.dart';
import 'package:demo1/login.dart';
import 'package:demo1/welcome.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool passwordVisible1=false;
  bool passwordVisible2=false;

  TextEditingController unameController=TextEditingController();
  TextEditingController addressController=TextEditingController();
  TextEditingController contactController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController pwdController=TextEditingController();
  TextEditingController cpwdController=TextEditingController();
  bool _isLoading=false;
  void registerUser()async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      "unameController": unameController.text.trim(),
      "addressController": addressController.text,
      "emailController": emailController.text.trim(),
      "pwdController": pwdController.text.trim(),
      "cpwdController": cpwdController.text.trim(),
      "contactController": contactController.text.trim(),
    };
    print("data${data}");
    var res = await Api().authData(data,'/api/user_register');
    var body = json.decode(res.body);
    print('res${res}');

    if(body['success']==true)
    {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));

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
                'image/signup.jpg',
                width: 360,
                height: 230,
                fit: BoxFit.cover,
              ),

              SizedBox(height: 27,),
              Text("Sign up",style: TextStyle(fontSize: 39,fontWeight: FontWeight.bold,),),
              SizedBox(height: 27,),
              Text("Create an Account, Its free",style: TextStyle(fontSize: 15),),

              SizedBox(height: 39,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: unameController,

                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person,color: Colors.blue,),
                      hintText: "Full Name",
                      label: Text('Full Name',),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(29)
                      )
                  ),

                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'This field is required';
                    }
                    // Return null if the entered username is valid
                    return null;
                  },

                ),
              ),

              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.place,color: Colors.blue,),
                      hintText: "Place",
                      label: Text('Place',),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(29)
                      )
                  ),

                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'This field is required';
                    }
                    // Return null if the entered username is valid
                    return null;
                  },

                ),
              ),

              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: contactController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone,color: Colors.blue,),
                      hintText: "Contact Number",
                      label: Text('Contact Number',),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(29)
                      )
                  ),

                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'This field is required';
                    }
                    if (value.length != 10) {
                      return 'Mobile Number must be of 10 digit';
                    }
                    // Return null if the entered password is valid
                    return null;
                  },

                ),
              ),

              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email,color: Colors.blue,),
                      hintText: "Email ID",
                      label: Text('Email ID',),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(29)
                      )

                  ),

                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'This field is required';
                    }
                    // Check if the entered email has the right format
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    // Return null if the entered email is valid
                    return null;
                  },

                ),
              ),

              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: pwdController,
                  obscureText: passwordVisible1,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(passwordVisible1
                      ? Icons.visibility_off
                          : Icons.visibility,color: Colors.blue,),
                      onPressed: () {
                        setState(
                              () {
                            passwordVisible1 = !passwordVisible1;
                          },
                        );
                      },
                    ),
                    prefixIcon: Icon(Icons.lock,color: Colors.blue,),
                      hintText: "Password",
                      label: Text('Password',),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(29)
                      )
                  ),

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

                ),
              ),

              SizedBox(height: 10,),

                //CONFIRM PASSWORD
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: cpwdController,
                  obscureText: passwordVisible2,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(passwordVisible2
                          ? Icons.visibility_off
                          : Icons.visibility,color: Colors.blue,),
                      onPressed: () {
                        setState(
                              () {
                            passwordVisible2 = !passwordVisible2;
                          },
                        );
                      },
                    ),
                    prefixIcon: Icon(Icons.lock,color: Colors.blue,),
                      hintText: "Confirm Password",
                      label: Text('Confirm Password',),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(29)
                      )
                  ),

                  validator: (value) {
                    if (value == null || value.trim().isEmpty)
                      return 'This field is required';
                    if (value != pwdController.text)
                      return 'Confimation password does not match the entered password';
                    return null;
                  }

                ),
              ),

              SizedBox(height: 36,),

              ElevatedButton(onPressed: (){
                if (_formKey.currentState!.validate()) {
                  registerUser();
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Enter a valid data'),
                      backgroundColor: Colors.grey,
                    ),
                  );
                }
               // Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
              },
                    style: ElevatedButton.styleFrom(primary: Colors.blueAccent,fixedSize: Size(300, 55),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.0)),),
                    child: Text("Sign Up",style: TextStyle(fontSize: 17),)),

              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",style: TextStyle(fontSize: 16),),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                    }, child: Text("Login",style: TextStyle(
                      fontSize: 16,color: Colors.blue,fontWeight: FontWeight.bold
                  ),)),
                  SizedBox(height: 50,)
                ],
              ),
            ],
          ),
        ),
      ),

    );

  }

}
