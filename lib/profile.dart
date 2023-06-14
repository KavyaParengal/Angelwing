import 'dart:convert';
import 'dart:io';
import 'package:demo1/buttonnavigation.dart';
import 'package:http/http.dart' as http;
import 'package:demo1/api.dart';
import 'package:demo1/homepage.dart';
import 'package:demo1/notification.dart';
import 'package:demo1/welcome.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  bool isObscurePassword=true;
  late int user_id;
  String name='';
  String place='';
  String contact='';
  String image='';
  late SharedPreferences prefs;
  TextEditingController unameController=TextEditingController();
  TextEditingController plcController=TextEditingController();
  TextEditingController contactController=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  _viewPro();
  }

    int currentTab = 2;
    final List<Widget> screen =[
    HomePage(),
    ClassNotify(),
    Profile(),

  ];

  Future<void> _viewPro() async {
    prefs = await SharedPreferences.getInstance();
    user_id = (prefs.getInt('user_id') ?? 0 );
    print('login_idupdate ${user_id}');
    var res = await Api()
        .getData('/api/singleuserprofile/' + user_id.toString());
    var body = json.decode(res.body);
    print(body);
    setState(() {
      name = body['data']['unameController'];
      place = body['data']['addressController'];
      contact = body['data']['contactController'];
      image=body['data']['userimage'];

      print(image);

      unameController.text = name;
      plcController.text= place;
      contactController.text= contact;

    });
  }

  // _update() async {
  //   prefs = await SharedPreferences.getInstance();
  //   user_id = (prefs.getInt('user_id') ?? 0 );
  //   String id=user_id.toString();
  //   setState(() {
  //     var _isLoading = true;
  //   });
  //
  //   var data = {
  //     "unameController": unameController.text,
  //     "addressController": plcController.text,
  //     "contactController":contactController.text
  //   };
  //   print(data);
  //   var res = await Api().putData(data, '/api/${id}/singleuserprofileUpdate');
  //   var body = json.decode(res.body);
  //   print(body);
  //   if (body['success'] == true) {
  //     print(body);
  //
  //     Fluttertoast.showToast(
  //       msg: body['message'].toString(),
  //       backgroundColor: Colors.grey,
  //     );
  //
  //     Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context) => HomePage()));
  //   } else {
  //     Fluttertoast.showToast(
  //       msg: body['message'].toString(),
  //       backgroundColor: Colors.grey,
  //     );
  //   }
  // }


  File? imageFile;
  late  final _filename;
  late  final bytes;

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:const Text("Choose from"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: const Text("Gallery"),
                    onTap: () {

                      _getFromGallery();
                      Navigator.pop(context);
                      //  _openGallery(context);
                    },
                  ),
                  SizedBox(height:10),
                  const Padding(padding: EdgeInsets.all(0.0)),
                  GestureDetector(
                    child: const Text("Camera"),
                    onTap: () {
                      _getFromCamera();

                      Navigator.pop(context);
                      //   _openCamera(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _update(int user_id,String name,String place,String contact,String image) async {

    prefs = await SharedPreferences.getInstance();
    user_id = (prefs.getInt('user_id') ?? 0 );
    String id=user_id.toString();

    var uri = Uri.parse(Api().url+'/api/${id}/singleuserprofileUpdate'); // Replace with your API endpoint

    var request = http.MultipartRequest('PUT', uri);

    request.fields['user_id'] = user_id.toString();
    request.fields['unameController'] = name;
    request.fields['addressController'] = place;
    request.fields['contactController'] = contact;
    request.fields['userimage'] = image;

    print(request.fields);

    final imageStream = http.ByteStream(imageFile!.openRead());
    final imageLength = await imageFile!.length();

    final multipartFile = await http.MultipartFile(
      'userimage',imageStream,imageLength,
      filename: _filename ,
      // contentType: MediaType('image', 'jpeg'), // Replace with your desired image type
    );
    request.files.add(multipartFile);

    final response = await request.send();
    print(response);

    if (response.statusCode == 200) {
      print('Profile Updated successfully');
      Navigator.push(
          this.context, MaterialPageRoute(builder: (context) => navigation()));
    } else {
      print('Error Updating profile. Status code: ${response.statusCode}');
    }
  }


  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(()  {

        imageFile = File(pickedFile.path);
        _filename = basename(imageFile!.path);
        final _nameWithoutExtension = basenameWithoutExtension(imageFile!.path);
        final _extenion = extension(imageFile!.path);
        print("imageFile:${imageFile}");
        print(_filename);
        print(_nameWithoutExtension);
        print(_extenion);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        //  _filename = basename(imageFile!.path).toString();
        final _nameWithoutExtension = basenameWithoutExtension(imageFile!.path);
        final _extenion = extension(imageFile!.path);
      });
    }
  }

/*
  Widget displayImage() {
    if (imageFile == null) {
      // Show a dummy image
      return Image.asset('assets/dummy_image.png');
    } else {
      // Show the selected image
      return Image.file(imageFile!);
    }
  }
*/

  Widget currentScreen = Profile();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // bottomNavigationBar: Container(
      //   padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
      //   height: 80,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //
      //       GestureDetector(
      //         onTap: () {
      //           setState(() {
      //             currentScreen = HomePage();
      //             currentTab = 0;
      //           });
      //           Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
      //         },
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //
      //             Icon(Icons.home_outlined,size: 30,color: currentTab==0 ? Colors.blue : Colors.black,),
      //             /*  new Image.asset('icon/home.png',
      //               height: 35,
      //               width: 55,
      //             ),
      //            */
      //             Text('Home',style: TextStyle(fontWeight: FontWeight.bold,color: currentTab==0 ? Colors.blue : Colors.black),)
      //           ],
      //         ),
      //       ),
      //
      //       GestureDetector(
      //         onTap: () {
      //           setState(() {
      //             currentScreen=ClassNotify();
      //             currentTab = 1;
      //           });
      //           Navigator.push(context, MaterialPageRoute(builder: (context)=>ClassNotify()));
      //
      //         },
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //             // new Image.asset('icon/notification.png',
      //             //   height: 40,
      //             //   width: 60,
      //             // ),
      //             Icon(Icons.notifications_outlined,size: 30,),
      //             Text('Notification',style: TextStyle(fontWeight: FontWeight.bold,color: currentTab==1 ? Colors.blue : Colors.black),)
      //           ],
      //         ),
      //       ),
      //
      //       GestureDetector(
      //         onTap: () {
      //           setState(() {
      //             currentScreen=Profile();
      //             currentTab = 2;
      //           });
      //           Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
      //         },
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //             // new Image.asset('icon/user.png',
      //             //   height: 35,
      //             //   width: 55,
      //             // ),
      //             Icon(Icons.person_outline_outlined,size: 30,color: currentTab==2 ? Colors.blue : Colors.black),
      //             Text('Profile',style: TextStyle(fontWeight: FontWeight.bold,color: currentTab==2 ? Colors.blue : Colors.black),)
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),

      appBar: AppBar(
        title: Text("Profile"),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            tooltip: "Logout",
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Welcome()));
            },
            icon: Icon(
              Icons.logout,
              size: 28,
            ),
          )
        ],
      ),

      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    SizedBox(height: 10,),
                    imageFile == null?Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        color: Colors.blue,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1)
                          )
                        ],
                        shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                Api().url+ image,
                              )
                          )
                      ),

                    ):Container(
                      width: 140,
                      height: 140,
                        decoration: BoxDecoration(
                            border: Border.all(width: 4, color: Colors.white),
                            shape: BoxShape.circle,
                            image : DecorationImage(
                            image : FileImage(imageFile!),
                        fit: BoxFit.fill
                    ))

                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1,
                              color: Colors.white
                            ),
                            color: Colors.blue
                          ),
                          child: IconButton(
                              onPressed: (){
                                _showChoiceDialog(context);
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                              )
                          )
                        ),
                    ),


                  ],
                ),
              ),
              SizedBox(height: 60,),

              buildTextField("Full name",unameController),
             /* buildTextField("Email", "kavya@gmail.com", false),
              buildTextField("Password", "1234567", true),*/
              buildTextField("Place",plcController),
              buildTextField("Contact number", contactController),

              SizedBox(height: 70,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>navigation()));
                      },
                      child: Text("CANCEL",style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.black
                      )),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                  ),

                  ElevatedButton(
                      onPressed: (){
                        _update(user_id,unameController.text,plcController.text,contactController.text,_filename);
                      },
                      child: Text("EDIT",style: TextStyle(fontSize: 15, letterSpacing: 2, color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),

    );
  }

  Widget buildTextField(String labelText,TextEditingController controller){
    return Padding(
        padding: EdgeInsets.only(bottom: 30),
      child: TextFormField(
        controller: controller,
        //obscureText: isPasswordTextField ? isObscurePassword: false,
        decoration: InputDecoration(
          // suffixIcon: isPasswordTextField ?
          //     IconButton(
          //         onPressed: () {
          //           setState(() {
          //             isObscurePassword=!isObscurePassword;
          //           });
          //         },
          //         icon: Icon(Icons.remove_red_eye,color: Colors.grey,),
          //     ):null,
              contentPadding: EdgeInsets.only(bottom: 5),
        labelText: labelText,
        labelStyle: TextStyle(fontSize: 18,color: Colors.blue),
        floatingLabelBehavior: FloatingLabelBehavior.always,

        // hintText: controller,
        // hintStyle: TextStyle(
        //   fontSize: 16,
        //   fontWeight: FontWeight.bold,
        //   color: Colors.grey
        // )

        ),
      ),
    );
  }
}
