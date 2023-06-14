import 'dart:convert';

import 'package:demo1/single_orphanage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';

class Food_Donation extends StatefulWidget {
  const Food_Donation({Key? key}) : super(key: key);

  @override
  State<Food_Donation> createState() => _Food_DonationState();
}

class _Food_DonationState extends State<Food_Donation> {

  late SharedPreferences prefs;
  late int user_id,or_id;
  TextEditingController dateInput=TextEditingController();
  TextEditingController quantityController=TextEditingController();

  bool isChecked=true;
  String? food;

  bool _isLoading=false;
  void food_donation()async {
    prefs = await SharedPreferences.getInstance();
    user_id = (prefs.getInt('user_id') ?? 0 );
    or_id = (prefs.getInt('orphanage_id') ?? 0 );
    setState(() {
      _isLoading = true;
    });

    var data = {
      "fd_type": food,
      "fd_dateInput": dateInput.text,
      "quantityController": quantityController.text,
      "user":user_id.toString(),
      "orphlist":or_id.toString()

    };
    print("data${data}");
    var res = await Api().authData(data,'/api/food_donation');
    var body = json.decode(res.body);
    print(body);
    if(body['success'] == true)
    {
      print('body${body}');

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

    return Scaffold(

        bottomNavigationBar: Row(
          children: [

            Expanded(
              child: Material(
                color: Colors.blue,
                child: InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      food_donation();
                    }
                    // else{
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //       content: Text('PLease check all fields'),
                    //       backgroundColor: Colors.grey,
                    //     ),
                    //   );
                    // }

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

        title: Text('Donate Food'),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),

      ),

    body: SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            Container(
            width: 400,
            height: size.height*.35,
            decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('image/food_donation.jpg')),
              )
            ),

            SizedBox(height: 10,),

            Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Since you get more joy out of giving joy to others, you should put a good deal of thought into the happiness that you are able to give.',textAlign: TextAlign.center,),
            ),



            SizedBox(height: 30,),

            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Type of Food',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                ),



                Row(
                  children: <Widget>[
                    Expanded(
                      child: RadioListTile(
                        title: Text("Veg"),
                        value: "Veg",
                        groupValue: food,
                        onChanged: (value){
                          setState(() {
                            food = value.toString();
                            isRadioButtonSelected = true;
                          });
                        },
                      ),
                    ),

                    Expanded(
                      child: RadioListTile(
                        title: Text("Non-Veg"),
                        value: "Non-Veg",
                        groupValue: food,
                        onChanged: (value){
                          setState(() {
                            food = value.toString();
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
                )
              ],
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

            SizedBox(height: 30,),

            // Align(
            //   alignment: Alignment.center,
            //   child: ElevatedButton(
            //     onPressed: (){ },
            //     child: Text('Food Donation',style: TextStyle(fontSize: 18),),
            //     style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0)),fixedSize: Size(180, 53)),
            //   ),
            // ),
            // SizedBox(height: 20,)
         ],
     ),
      ),
    )
    );
  }
}
