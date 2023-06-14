import 'package:demo1/homepage.dart';
import 'package:flutter/material.dart';


class Payment_success extends StatefulWidget {
  const Payment_success({Key? key}) : super(key: key);

  @override
  State<Payment_success> createState() => _Payment_successState();
}

class _Payment_successState extends State<Payment_success> {
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(),));
                },
                child: const SizedBox(
                  height: kToolbarHeight,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'OK',
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

        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("image/check.png",height: 100,width: 200,alignment: Alignment.topCenter,),
              SizedBox(height: 20,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Text("Your payment was done successfully",textAlign: TextAlign.center,selectionColor: Colors.blueAccent,style: TextStyle(fontSize: 16),),

              ),


              // Container(
              //   child: ElevatedButton(onPressed: (){
              //     Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(),));
              //   },
              //     style:ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),primary: Colors.blue,fixedSize: Size(200, 50)),
              //     child: Text("OK",style: TextStyle(color: Colors.white,fontSize: 17),),
              //   ),
              // ),

            ],
          ),
    ),
    );
  }
}
