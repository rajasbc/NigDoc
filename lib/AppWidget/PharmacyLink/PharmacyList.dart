import 'package:flutter/material.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';

class PharmacyList extends StatefulWidget {
  const PharmacyList({super.key});

  @override
  State<PharmacyList> createState() => _PharmacyListState();
}

class _PharmacyListState extends State<PharmacyList> {
  var list;
  @override
  Widget build(BuildContext context) {
     double screenHeight = MediaQuery.of(context).size.height - 50;
    double screenWidth = MediaQuery.of(context).size.width;
     return new WillPopScope(
       onWillPop: () async {
         Navigator.push(
          context, MaterialPageRoute(builder: (context)=> Dash(),)
         );
         return true;
        },
        child:Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(title: Text('Pharmacy List',
          style: TextStyle(color: Colors.white),),
          // backgroundColor: ,
          leading: IconButton(onPressed: (){
            Navigator.push(
          context, MaterialPageRoute(builder: (context)=> Dash(),)
         );
          }, icon: Icon(Icons.arrow_back,
          color: Colors.white,),),
         
          ),
          body:Container(
            height: screenHeight,
            width: screenWidth,
            child:  Container(
                          height:screenHeight * 0.75,
                          
          
                         width: screenWidth,
                          padding:EdgeInsets.all(5),
                          child: 
                          ListView.builder(
                            // shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int index){
                              list=index+1;
                              // var data=test_List[index];
                              return Container(
                                child: Column(
                                  children: [
                                    Card(
                                      color: index % 2 == 0
                                                    ? Color.fromARGB(
                                                        255, 218, 235, 238)
                                                    : Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Pharmacy Name:',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          Text("Saveetha"),
                                                        ],
                                                      ),
                                                       Row(
                                                        children: [
                                                          Text(
                                                            'Mobile : ',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          Text("9876543210"),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5,),
                                                   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Email :',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          Text("Saveetha@gmail.com"),
                                                        ],
                                                      ),
                                                       Row(
                                                        children: [
                                                          Text(
                                                            'Address : ',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          Text("sdfgbhjmklfgh"),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                            ],
                                          ),
                                        ),
                                      )
                                    )
                                  ],
                                ),
                              );
                          })
                           ),
           
          ),
          )
          );
  }
}