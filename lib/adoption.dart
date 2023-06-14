import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:demo1/api.dart';
import 'package:demo1/members.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Adoption extends StatefulWidget {
  final int id;

  Adoption({ required this.id});

  @override
  State<Adoption> createState() => _AdoptionState();
}

class _AdoptionState extends State<Adoption> {

  DateTime datetime = DateTime.now();

  late SharedPreferences prefs;
  late int user_id,or_id,id;

  String datetime1='';

  TextEditingController fullName=TextEditingController();
  TextEditingController dobInput= TextEditingController();
  TextEditingController address=TextEditingController();
  TextEditingController phoneNumber=TextEditingController();
  TextEditingController idNumber= TextEditingController();
  TextEditingController healthInsurance= TextEditingController();
  TextEditingController companyName=TextEditingController();
  TextEditingController companyAddress= TextEditingController();
  TextEditingController reason= TextEditingController();

  var personal_status;
  var gender;

  bool _isLoading=false;

  // void adoptionform()async {
  //
  //   datetime1 = DateFormat("yyyy-MM-dd").format(datetime);
  //
  //   late int id = widget.id;
  //
  //   prefs = await SharedPreferences.getInstance();
  //   user_id = (prefs.getInt('user_id') ?? 0 );
  //   or_id = (prefs.getInt('orphanage_id') ?? 0 );
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //   var data = {
  //     "fullName": fullName.text,
  //     "dob": dobInput.text,
  //     "address": address.text,
  //     "phoneNumber":phoneNumber.text,
  //     "idNumber":idNumber.text,
  //     "healthInsurance":healthInsurance.text,
  //     "personal_status":personal_status,
  //     "companyName":companyName.text,
  //     "companyAddress":companyAddress.text,
  //     "reason":reason.text,
  //     "signature":imageFile ,
  //     "date": datetime1,
  //     "outsider":user_id.toString(),
  //     "orphlist":or_id.toString(),
  //     "member": id.toString(),
  //
  //   };
  //   print("data${data}");
  //   var res = await Api().authData(data,'/api/adoptionform');
  //   var body = json.decode(res.body);
  //   print(body);
  //   if(body['success'] == true)
  //   {
  //     print('body${body}');
  //   Fluttertoast.showToast(
  //     msg: body['message'].toString(),
  //     backgroundColor: Colors.grey,
  //   );
  //
  //   Navigator.push(this.context, MaterialPageRoute(builder: (context)=>Members()));
  //
  //   }
  //   else
  //   {
  //     Fluttertoast.showToast(
  //       msg: body['message'].toString(),
  //       backgroundColor: Colors.grey,
  //     );
  //
  //   }
  // }

  Future<void> adoptionform(String fullName,String gender,String dobInput,String address,String phoneNumber,String idNumber,String healthInsurance,String personal_status,String companyName,String companyAddress,String reason,String datetime1,String image) async {

    datetime1 = DateFormat("yyyy-MM-dd").format(datetime);

    late int id = widget.id;

    prefs = await SharedPreferences.getInstance();
    user_id = (prefs.getInt('user_id') ?? 0 );
    print('User_id-----${user_id}');
    or_id = (prefs.getInt('orphanage_id') ?? 0 );
    print('Orphanage_ id--- ${or_id}');

    print('Member id ----${id}');

    var uri = Uri.parse(Api().url+'/api/adoptionform'); // Replace with your API endpoint

    var request = http.MultipartRequest('POST', uri);

    request.fields['outsider'] = user_id.toString();
    request.fields['orphlist'] = or_id.toString();
    request.fields['member'] = id.toString();
    request.fields['fullName'] = fullName;
    request.fields['gender'] = gender;
    request.fields['dob'] = dobInput;
    request.fields['address'] = address;
    request.fields['phoneNumber'] = phoneNumber;
    request.fields['idNumber'] = idNumber;
    request.fields['healthInsurance'] = healthInsurance;
    request.fields['personal_status'] = personal_status;
    request.fields['companyName'] = companyName;
    request.fields['companyAddress'] = companyAddress;
    request.fields['reason'] = reason;
    request.fields['date'] = datetime1;
    request.fields['signature'] = image;

    print(request.fields);

    final imageStream = http.ByteStream(imageFile!.openRead());
    final imageLength = await imageFile!.length();

    final multipartFile = await http.MultipartFile(
      'signature',imageStream,imageLength,
      filename: _filename ,
      // contentType: MediaType('image', 'jpeg'), // Replace with your desired image type
    );
    request.files.add(multipartFile);

    final response = await request.send();
    print(response);

    if (response.statusCode == 201) {
      print('Your Form Send Successfully');
      Navigator.push(
          this.context, MaterialPageRoute(builder: (context) => Members()));
    }
    else {
      print('Error Submiting Form. Status code: ${response.statusCode}');
    }
  }

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

  bool isRadioButtonSelected = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: Row(
        children: [

          Expanded(
            child: Material(
              color: Colors.blue,
              child: InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    adoptionform(fullName.text,gender,dobInput.text,address.text,phoneNumber.text,idNumber.text,healthInsurance.text,personal_status,companyName.text,companyAddress.text,reason.text,datetime1,_filename);
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Adoption Form'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text("Please fill the following details",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
              ),
              SizedBox(height: 27,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                    child: Text("PERSONAL INFORMATION",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300,),)
                ),
              ),
              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: fullName,
                  decoration: InputDecoration(
                      hintText: "Full Name",
                      label: Text('Full Name',),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22)
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

              SizedBox(height: 2,),

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Select Gender',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.grey[600]),),
                ),
              ),

              Column(
                children: [
                  Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            title: Text("Male"),
                            value: "Male",
                            groupValue: gender,
                            onChanged: (value){
                              setState(() {
                                gender = value;
                                isRadioButtonSelected=true;
                              });
                            },
                          ),
                        ),

                        Expanded(
                          child: RadioListTile(
                            title: Text("Female"),
                            value: "Female",
                            groupValue: gender,
                            onChanged: (value){
                              setState(() {
                                gender = value;
                                isRadioButtonSelected=true;
                              });
                            },
                          ),
                        ),
                      ]),

                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: Text("Other"),
                          value: "Other",
                          groupValue: gender,
                          onChanged: (value){
                            setState(() {
                              gender = value;
                              isRadioButtonSelected=true;
                            });
                          },
                        ),
                      ),

                    ],
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: dobInput,
                  decoration: InputDecoration(
                    hintText: 'Date of Birth',
                      suffixIcon: Icon(Icons.date_range),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22)
                      )
                  ),

                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'This field is required';
                    }
                    // Return null if the entered username is valid
                    return null;
                  },

                  onTap: () async {
                    DateTime? pickedDate= await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      setState(() {
                        dobInput.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {}
                  },
                ),
              ),

              SizedBox(height: 2,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: address,
                  decoration: InputDecoration(
                      hintText: "Address",
                      label: Text('Address',),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22)
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

              SizedBox(height: 2,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: phoneNumber,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Phone Number",
                      label: Text('Phone Number',),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22)
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

              SizedBox(height: 2,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: idNumber,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "ID Number",
                      label: Text('ID Number',),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22)
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

              SizedBox(height: 2,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: healthInsurance,
                  decoration: InputDecoration(
                      hintText: "Type of health insurance",
                      label: Text('Type of health insurance',),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22)
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

              SizedBox(height: 9,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("STATUS",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300,),)
                ),
              ),

              SizedBox(height: 9,),

              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: Text("Single"),
                          value: "Single",
                          groupValue: personal_status,
                          onChanged: (value){
                            setState(() {
                              personal_status = value;
                            });
                          },
                        ),
                      ),

                      Expanded(
                        child: RadioListTile(
                          title: Text("Married"),
                          value: "Married",
                          groupValue: personal_status,
                          onChanged: (value){
                            setState(() {
                              personal_status = value;
                              isRadioButtonSelected=true;
                            });
                          },
                        ),
                      ),
                    ]),

                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                              title: Text("Divorced"),
                              value: "Divorced",
                              groupValue: personal_status,
                              onChanged: (value){
                                setState(() {
                                  personal_status = value;
                                  isRadioButtonSelected=true;
                                });
                              },
                            ),
                          ),



                      Expanded(
                        child: RadioListTile(
                          title: Text("Other"),
                          value: "other",
                          groupValue: personal_status,
                          onChanged: (value){
                            setState(() {
                              personal_status = value;
                              isRadioButtonSelected=true;
                            });
                          },
                        ),
                      ),
                        ],
                      ),
                ],
              ),

              if (!isRadioButtonSelected)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Please choose an option",
                      style: TextStyle(color: Colors.red[800],fontSize: 12),
                    ),
                  ),
                ),

              SizedBox(height: 9,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("CURRENT JOB",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300,),)
                ),
              ),

              SizedBox(height: 9,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: companyName,
                  decoration: InputDecoration(
                      hintText: "Company Name",
                      label: Text('Company Name',),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22)
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

              SizedBox(height: 2,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: companyAddress,
                  decoration: InputDecoration(
                      hintText: "Address",
                      label: Text('Address',),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22)
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

              SizedBox(height: 9,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("REASON FOR ADOPTING A CHILD",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300,),)
                ),
              ),

              SizedBox(height: 9,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100.0,
                  child: Stack(
                    children: [
                      TextFormField(
                        controller: reason,
                        maxLines: 10,
                        decoration: InputDecoration(
                          hintText: 'Please briefly describe the issue(Optional)',
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.grey
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(22)
                          ),
                        ),

                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("SIGNATURE",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300,),),
                    SizedBox(width: 18,),

                    OutlinedButton(
                        onPressed: (){
                          _showChoiceDialog(context);
                        },
                        child: Text("Upload",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),),
                      style: OutlinedButton.styleFrom(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      ),
                    )


                  ],
                ),

              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: 250,
                  decoration: BoxDecoration(
                    image: imageFile != null
                        ? DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(imageFile!),
                    )
                        : null,
                  ),
                ),
              ),

              SizedBox(height: 30,)
            ],
          ),
        ),
      ),




    );
  }
}
