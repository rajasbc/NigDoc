import 'package:flutter/material.dart';
import 'package:nigdoc/AppWidget/Setting/Setting.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;

class Prescription_List extends StatefulWidget {
  const Prescription_List({super.key});

  @override
  State<Prescription_List> createState() => _Prescription_ListState();
}

class _Prescription_ListState extends State<Prescription_List> {
  TextEditingController Predetailscontoller=TextEditingController();

  //  int? _PrintSelected;
  // String _print = "";
   String? _printSelected="";
   String _printVal = "";

   int? _headerSelected;
  String _headerval = "";
  @override
  Widget build(BuildContext context) {

    double screenHeight=MediaQuery.of(context).size.height;
    double screenWidth=MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Setting()));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Prescription List',style: TextStyle(color: Colors.white),),
          leading: IconButton(onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>Setting()));
          }, icon: Icon(Icons.arrow_back,color: Colors.white,)
          ),
          backgroundColor:custom_color.appcolor ,
        ),
    body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Container(
                 
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              color: index % 2 == 0
                                  ? custom_color.lightcolor
                                  : Colors.white,
                              width: screenWidth,
                              height: screenHeight * 0.09,
                             // width: screenWidth * 0.90,
                              // decoration:
                              //     BoxDecoration(border: Border.all(color: Colors.grey)),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: screenWidth*0.75,
                                      // color: Colors.red,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  // color: Colors.amber,
                                                  width: screenWidth * 0.45,
                                                  height: screenWidth*0.07,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Pre Id :',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  //  width: screenWidth * 0.35,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Date :',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: screenWidth * 0.45,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Dr Name :',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  //  width: screenWidth * 0.35,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Pat Name :',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: screenWidth * 0.45,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Pat Mobile :',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                               
                                              ],
                                            ),
                                          ),
                                         
                                         

                                        ],
                                      ),
                                    ),

                                    Column(
                                      children: [
                                        PopupMenuButton(itemBuilder: (context)=>[
                                          PopupMenuItem(child: Row(
                                                  children: [
                                                    Icon(Icons.view_agenda,color: custom_color.appcolor,),
                                                    Padding(padding: EdgeInsets.only(left: 10),
                                                    child: Text('View Prescription',style: TextStyle(fontSize: 16),),)
                                                  ],
                                        
                                                  
                                                ),
                                                onTap: () {
                                                showDialog ( context: context,
                builder: (_) => AlertDialog(
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      insetPadding: EdgeInsets.all(5.0),
                      // contentPadding: EdgeInsets.zero,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      content: Builder(
                        builder: (context) {
                          // Get available height and width of the build area of this widget. Make a choice depending on the size.
                          var height = MediaQuery.of(context).size.height;
                          var width = MediaQuery.of(context).size.width;
                          return Container(
                            color: Colors.white,
                            // height: height - 200,
                            width: width,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Container(
                                child: Column(
                                  children: [
                                    // Text('Add New Customer'),
                                     Text('Prescription Details ',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),

                                    SizedBox(
                                      height: 5,
                                    ),
                                     ListView.builder(
                                                            shrinkWrap: true,
                                                            physics: NeverScrollableScrollPhysics(),
                                                            itemCount: 1,
                                                            itemBuilder: (BuildContext context, int index){

                                                              return Center(
                                                                child:Container(
                                                                  height: 122,
                                                                  width: 500,
                                                                  color: index % 2 == 0
                                                                  ? custom_color.lightcolor
                                                                  : Colors.white,
                                     child: Row(
                                     children: [
                                     Container(
                                      width: screenWidth*0.75,
                                      // color: Colors.red,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  // color: Colors.amber,
                                                  width: screenWidth * 0.45,
                                                  height: screenWidth*0.07,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Pre Date :',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  //  width: screenWidth * 0.35,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Dr Name :',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: screenWidth * 0.45,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Ref Name :',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  //  width: screenWidth * 0.35,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Med Name:',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: screenWidth * 0.45,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'No.Of.Date :',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: screenWidth * 0.30,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Method :',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: screenWidth * 0.45,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        ' Before/After Food :',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                               
                                              ],
                                            ),
                                          ),

                                         
                                         

                                        ],
                                      ),
                                    ),
                                         ],
                                   ),

                                            
                                                            
                                                                
                                                              ),
                                                              
                                                              );
                                                              
                                                              }
                                                              )
                                
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      ));
                                 
                                                },
                                                
                                                ),
                                                 PopupMenuItem(child: Row(
                                                  children: [
                                                    Icon(Icons.print,color: custom_color.appcolor,),
                                                    Padding(padding: EdgeInsets.only(left: 10),
                                                    child: Text('Print Prescription',style: TextStyle(fontSize: 16),),)
                                                  ],
                                        
                                                  
                                                ),
                                                onTap: () {
                                                  showDialog(context: context, builder: ((context) => AlertDialog(
                                                    actions: [
                                                        Padding(padding: EdgeInsets.all(10)),
                                                        Container(
                                                          height: screenHeight*0.04,
                                                          width: screenWidth*0.14,
                                                        ),

                                                        Center(
                                                          child: Container(
                                                          child: Text('Choose Size & Formet',
                                                          style: TextStyle(fontSize: 20,
                                                          fontWeight: FontWeight.bold),),
                                                          ),
                                                        ),

                                              SizedBox(height: screenHeight*0.02,),

                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                       // width: screenWidth * 0.50,
                        width: screenWidth*0.20,
                        child: Text(
                          'Print',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                               width:screenWidth*0.25,
                              child: Row(
                                children: [
                                  // Radio(
                                  //   value: 1,
                                  //   groupValue: _printSelected,
                                  //   activeColor: Colors.blue,
                                  //   onChanged: (value) {
                                  
                                  //     setState(() {
                                  //        _printSelected = value as int;
                                  //        _printVal = 'Yes';
                                  //       print(_printVal);
                                  //     });
                                  //   },
                                  // ),
                                  // const Text("A4"),
                                   Radio(
                                  value: 'a4',
                                  groupValue: _printSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      _printSelected=value.toString();
                                    });
                                    // setState(() {
                                    //    _printSelected =value ;
                                    //   //  _printVal = 'Yes';
                                    //   // print(_printVal);
                                    // });
                                  },
                                ),
                                const Text("A4"),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    width: screenWidth*0.18,
                                    child: Radio(
                                      value: 'a5',
                                      groupValue: _printSelected,
                                      activeColor: Colors.blue,
                                      onChanged: (value) {
                                        setState(() {
                                          _printSelected=value.toString();
                                        });
                                       // value = _PrintSelected;
                                        // setState(() {
                                        //    _printSelected = value ;
                                        //   //  _printVal = 'No';
                                        //   // print(_printVal);
                                        // });
                                      },
                                    ),
                                     
                                  ),
                                  const Text("A5"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),


                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                       // width: screenWidth * 0.50,
                        width: screenWidth*0.20,
                        child: Text(
                          'Header',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                               width:screenWidth*0.25,
                              child: Row(
                                children: [
                                  Radio(
                                    value: 1,
                                    groupValue: _headerSelected,
                                    activeColor: Colors.blue,
                                    onChanged: (value) {
                                      setState(() {
                                         _headerSelected = value as int;
                                         _headerval = 'Yes';
                                        print(_headerval);
                                      });
                                    },
                                  ),
                                  const Text("Yes"),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    width: screenWidth*0.18,
                                    child: Radio(
                                      value: 2,
                                      groupValue: _headerSelected,
                                      activeColor: Colors.blue,
                                      onChanged: (value) {
                                        setState(() {
                                           _headerSelected = value as int;
                                          _headerval= 'No';
                                          print(_headerval);
                                        });
                                      },
                                    ),
                                  ),
                                  const Text("No"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                   SizedBox(height: screenHeight*0.04,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                       child: ElevatedButton( 
                       style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
    
                            RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
       
      
                             ),
    
                             )
  
                             ),
                         child:Text('Confirm',
                         style: TextStyle(fontSize: 20,color: Colors.white),),
                         onPressed: (() {
                        
                          
                         }),),
                     ),

                       Padding(
                         padding: const EdgeInsets.only(top: 0,left: 20,right:10),
                         child: ElevatedButton( 
                          
                         style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
    
                            RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
       
      
                             ),
    
                             )
  
                             ),
                         child:Text('Cancel',
                         style: TextStyle(fontSize: 20,color: Colors.white),),
                         onPressed: (() {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Prescription_List()));
                         }),),
                       ),
                       SizedBox(height: screenHeight*0.04,),
                   ],
                 ),
                  


         
                                                                                  
                                                    ],
                                                  )));
                                                },
                                                
                                                ),
                                                 PopupMenuItem(child: Row(
                                                  children: [
                                                    Icon(Icons.cancel,color: custom_color.appcolor,),
                                                    Padding(padding: EdgeInsets.only(left: 10),
                                                    child: Text('Cancel',style: TextStyle(fontSize: 16),),)
                                                  ],
                                        
                                                  
                                                ),
                                                onTap: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Prescription_List()));
                                                },
                                                
                                                )
                                        ]),

                                  
                                      ],

                                    ),

                                   
                                  ],
                                ),
                              ),
                            ),
                       
                          ),
                          
                        );
                       
                      },

                      
                    ),

                  ),
                  
                ),
              ),
            ),
          ),
        ),

     ) );
  }
}