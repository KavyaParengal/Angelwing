import 'dart:convert';

import 'package:demo1/single_orphanage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';

class Cloth_donation extends StatefulWidget {
  const Cloth_donation({Key? key}) : super(key: key);

  @override
  State<Cloth_donation> createState() => _Cloth_donationState();
}

class _Cloth_donationState extends State<Cloth_donation> {
  late SharedPreferences prefs;
  late int user_id,or_id;
  TextEditingController quantityController=TextEditingController();
  TextEditingController dateInput=TextEditingController();
  bool isChecked=true;
  String? gender;
  String? dropdownvalue ;
  var items = ['S', 'M', 'L', 'XL', 'XXL',];

  bool _isLoading=false;
  void cloth_donation()async {
    prefs = await SharedPreferences.getInstance();
    user_id = (prefs.getInt('user_id') ?? 0 );
    or_id = (prefs.getInt('orphanage_id') ?? 0 );
    setState(() {
      _isLoading = true;
    });

    var data = {
      "sizeController": dropdownvalue,
      "quantityController": quantityController.text,
      "cloth_dateInput": dateInput.text,
      "gender":gender,
      "user":user_id.toString(),
      "orphlist":or_id.toString()

    };
    print("data${data}");
    var res = await Api().authData(data,'/api/cloth_donation');
    var body = json.decode(res.body);
    print(body);
    if(body['success'] == true)
    { print('body${body}');
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      Navigator.push(context, MaterialPageRoute(builder: (context)=>Single_Orphanage(id: or_id)));

    }
    else
    {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

    }
  }

  bool isRadioButtonSelected = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    String? selectsize;

    return Scaffold(

      bottomNavigationBar: Row(
        children: [

          Expanded(
            child: Material(
              color: Colors.blue,
              child: InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    cloth_donation();
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

        title: Text('Donate Cloth'),
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
            Container(
              width: 400,
              height: size.height*.35,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('image/cloth_donatn.jpg')),
                  )
            ),

            SizedBox(height: 10,),
            
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: Text('Since you get more joy out of giving joy to others, you should put a good deal of thought into the happiness that you are able to give.',textAlign: TextAlign.center,),
            ),

            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Gender',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    ),
                  ),

                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RadioListTile(
                          title: Text("Male"),
                          value: "Male",
                          groupValue: gender,
                          onChanged: (value){
                            setState(() {
                              gender = value.toString();
                              isRadioButtonSelected = true;
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
                              gender = value.toString();
                              isRadioButtonSelected = true;
                            });
                          },
                        ),
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

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Size',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: double.maxFinite,
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22)) ,
                          ),
                          hint: Text('Select Size'),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'This field is required';
                            }
                            // Return null if the entered username is valid
                            return null;
                          },
                          value: dropdownvalue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        ),
                  ),
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Quantity',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
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

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Date',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: dateInput,
                      decoration: InputDecoration(
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
                          firstDate: DateTime(2000),
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
                            dateInput.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {}
                      },
                    ),
                  ),
                ],
              ),
            ),



            SizedBox(height: 30,),

            // Align(
            //   alignment: Alignment.center,
            //   child: ElevatedButton(
            //     onPressed: (){ },
            //     child: Text('Cloth Donation',style: TextStyle(fontSize: 18),),
            //     style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0)),fixedSize: Size(180, 53)),
            //   ),
            // ),
            // SizedBox(height: 20,)
          ],
        ),
      ),


    );
  }
}
