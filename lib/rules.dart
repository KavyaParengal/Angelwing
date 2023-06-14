import 'package:flutter/material.dart';

class Rules extends StatefulWidget {
  const Rules({Key? key}) : super(key: key);

  @override
  State<Rules> createState() => _RulesState();
}

class _RulesState extends State<Rules> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rules and Regulations'),
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
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 10),
              child: Text('Key Points to Remember for Prospective Adoptive Parents (PAPs)',textAlign: TextAlign.center,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Table(
                  border:TableBorder.all(width: 1.0,),
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: Colors.blue),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Do's",textScaleFactor: 1.5,textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Don'ts",textScaleFactor: 1.5,textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)),
                        ),
                      ]
                    ),
                    TableRow(
                        decoration: BoxDecoration(color: Colors.blue[100]),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Only adopt from Specialised Adoption Agencies (SAAs) recognised by State Governments.",textScaleFactor: 1.5,textAlign: TextAlign.left,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Do not approach any nursing home, hospital, maternity home, unauthorised institution or individual for adoption.",textScaleFactor: 1.5,textAlign: TextAlign.left,),
                          ),
                        ]
                    ),
                    TableRow(
                        decoration: BoxDecoration(color: Colors.white),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Read the Guidelines carefully on the website and follow the due procedure.",textScaleFactor: 1.5,textAlign: TextAlign.left,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Do not upload any incorrect document, else your registration will be cancelled.",textScaleFactor: 1.5,textAlign: TextAlign.left,),
                          ),
                        ]
                    ),
                    TableRow(
                        decoration: BoxDecoration(color: Colors.blue[100]),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Follow the steps for completing your registration.",textScaleFactor: 1.5,textAlign: TextAlign.left,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Do not pay any additional adoption charges other than what is prescribed in the Guidelines.",textScaleFactor: 1.5,textAlign: TextAlign.left,),
                          ),
                        ]
                    ),
                    TableRow(
                        decoration: BoxDecoration(color: Colors.white),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("For adoption related charges, please refer Schedule-13 of the Guidelines Governing Adoption of Children (2015). Always make payment by cheque or draft and collect your receipt.",textScaleFactor: 1.5,textAlign: TextAlign.left,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Through illegal adoption, you may unintentionally become part of child trafficking network. Save yourself from legal ramifications.",textScaleFactor: 1.5,textAlign: TextAlign.left,),
                          ),
                        ]
                    ),

                  ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
