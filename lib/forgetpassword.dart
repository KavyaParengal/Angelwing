import 'package:demo1/login.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController=TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Align(
            //     alignment: Alignment.topLeft,
            //     child:
            //     IconButton(onPressed: (){
            //       Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
            //     }, icon: Icon(Icons.arrow_back),)
            //
            // ),

            new Image.asset(
              'image/3293465.jpg',
              width: 520,
              height: 370,
              fit: BoxFit.cover,
            ),

            SizedBox(height: 20,),
            Text("Forget Password ?",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,),),

            SizedBox(height: 22,),

            Text("Enter the email address associated with your account",style: TextStyle(fontSize: 15),),

            SizedBox(height: 34,),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email,color: Colors.blue,),
                    hintText: "Email Address",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(29)
                    )

                ),

              ),
            ),

            SizedBox(height: 42,),

            ElevatedButton(onPressed: (){
              openAlert();
            },
                style: ElevatedButton.styleFrom(primary: Colors.blue,fixedSize: Size(300, 54),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.0)),),
                child: Text("Submit",style: TextStyle(fontSize: 16),)),

            SizedBox(height: 15,),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Back to",style: TextStyle(fontSize: 16),),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                  }, child: Text("Login",style: TextStyle(
                      fontSize: 17,color: Colors.blue,fontWeight: FontWeight.bold,),)),
                  SizedBox(height: 26,)
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }

  Future openAlert() =>
    showDialog(
        context: context,
        builder: (context)=> AlertDialog(
          title: Image.asset('image/check.png',width: 150,height: 100,),
          content: Text('Please check your email for create a new password',textAlign: TextAlign.center,style: TextStyle(fontSize: 17),),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                },
                child: Text('OK',style: TextStyle(fontSize: 17),)
            )
          ],
        ),
    );

}
