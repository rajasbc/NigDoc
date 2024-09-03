import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
//import 'package:nigdoc/AppWidget/DoctorWidget/Referral/Referral.dart';
import 'package:nigdoc/AppWidget/Medicine/AddMedicineList.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/StaffWidget/Referral/Referral.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;


class Edit_Referral extends StatefulWidget {
  final select_referral;
  const Edit_Referral({super.key,request, this.select_referral});

  @override
  State<Edit_Referral> createState() => _Edit_ReferralState();
}

 
class _Edit_ReferralState extends State<Edit_Referral> {
  @override
   TextEditingController select_Titlecontroller =TextEditingController();
  TextEditingController Referral_Namecontroller=TextEditingController();
  TextEditingController mobilecontroller =TextEditingController();
  TextEditingController Emailcontroller =TextEditingController();
  TextEditingController addresscontroller =TextEditingController();
  TextEditingController citycontroller =TextEditingController();
  TextEditingController pincodecontroller =TextEditingController();
  TextEditingController dobcontroller =TextEditingController();
  TextEditingController date_of_anniversarycontroller =TextEditingController();
  TextEditingController organizationcontroller =TextEditingController();
  
  
  
  var selected_item;
  var title={
       "Mr",
       "Mrs",
       "Miss",
       "Dr",

  };
var data;
@override
  void initState(){
    init();
    
   
    super.initState();
    //  initilzeMethod();
  }
   init() async {
    // await storage.ready;
      userResponse = await storage.getItem('userResponse');
      accesstoken = await userResponse['access_token'];
      data = widget.select_referral;

    setState(() {

      selected_item = data['title'].toString();
      Referral_Namecontroller.text = data['name'].toString();
      mobilecontroller.text = data['mobile_no'].toString();   
      Emailcontroller.text = data['email_id'].toString();
      addresscontroller.text = data['address'].toString();
      citycontroller.text = data['city'].toString();
      pincodecontroller.text = data['pincode'].toString();
      dobcontroller.text = data['dob'].toString();
      date_of_anniversarycontroller.text = data['doa'].toString();
      organizationcontroller.text = data['organization'].toString();

    });

   
  }
  Widget build(BuildContext context) {
     double screenHeight=MediaQuery.of(context).size.width;
      double screenWidth = MediaQuery.of(context).size.width;
    
    return PopScope(
       canPop: false,
      onPopInvoked: (bool didPop) {
           Navigator.push(context, MaterialPageRoute(builder: (context)=>Referral()));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Referral',style: TextStyle(color: Colors.white),),
          leading: IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Referral()));

          }, icon: Icon(Icons.arrow_back,),
          color: Colors.white,),
          backgroundColor:custom_color.appcolor,
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
                   SizedBox(height: screenHeight*0.04,),
                 Padding(
                   padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                      //padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: screenHeight * 0.15,
                        width: screenWidth * 0.96,
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0)
                            // border: OutlineInputBorder()
                            ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: DropdownButtonFormField(
                            
                              decoration: InputDecoration.collapsed(hintText: ''),
                              isExpanded: true,
                              hint: Padding(
                              padding: const EdgeInsets.only(top: 0, left: 2, right: 0,),
                                child: Text(
                                  // 'Select Title *',
                                  '${data['title']}'
                                 
                                ),
                              ),
                             
                              onChanged: (selectedDoctor) {
                                selected_item=selectedDoctor;
                                setState(() {
                                 
                                });
                              },
                              items: title.map<DropdownMenuItem<String>>((item) {
                                return new DropdownMenuItem(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 0, left: 8, right: 8),
                                    child: new Text(item,style: TextStyle(fontSize: 15),),
                                  ),
                                  value: item.toString(),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
               SizedBox(height: screenHeight*0.03,),
             
             Padding(padding: EdgeInsets.all(8.0),
             child: TextFormField(
              controller: Referral_Namecontroller,
          
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Referral Name *",
              ),
             ),
             ),
              SizedBox(height: screenHeight*0.01,),
             Padding(padding: EdgeInsets.all(8.0),
             
             child: TextFormField(
              maxLength: 10,
              controller: mobilecontroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Mobile Number",
              ),
             ),
             
             ),
              SizedBox(height: screenHeight*0.01,),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: TextFormField(
                controller: Emailcontroller,
                keyboardType: TextInputType.none,
                decoration: InputDecoration(
                  
                  border: OutlineInputBorder(),
                  labelText: "Email Id"
                ),
               ),
             ),
             SizedBox(height: screenHeight*0.01,),
          
              Padding(padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: addresscontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Address"
                ),
              ),
              
              ),
              SizedBox(height: screenHeight*0.02,),

              // Row(
              //   children: [
              //     Padding(padding: EdgeInsets.only(left: 10),
                  
              //     child: TextFormField(
              //       controller: citycontroller,
              //       decoration: InputDecoration(
              //         border: OutlineInputBorder(),
              //         labelText: "City",
              //       ),
              //     ),
                            
                  
              //     ),
              //      SizedBox(height: screenHeight*0.01,),
              //     Padding(padding: EdgeInsets.only(left: 20),
              //     child: TextFormField(
              //       keyboardType: TextInputType.number,
              //       controller: pincodecontroller,
              //       decoration: InputDecoration(
              //        border: OutlineInputBorder(),
              //        labelText: "Pincode",
              //       ),
              //     ),
              //     ),
              //   ],
              // ),

                  Row(
                    children: [
                      Container(
                        width: screenWidth * 0.49,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: citycontroller,
              
                            // keyboardType: TextInputType.none,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(), labelText: 'City'),
                          ),
                        ),
                      ),
                  
                    Container(
                      width: screenWidth*0.49,
                      child: TextField(

                         //maxLength: 6,
                        inputFormatters: [LengthLimitingTextInputFormatter(6)],
                        keyboardType: TextInputType.number,
                        controller: pincodecontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Pincode",
                        ),
                      ),
                    )]
                  ),
                
             
          //     SizedBox(height: screenHeight*0.01,),
          
          //     Padding(padding: EdgeInsets.all(8.0),
          //     child: TextFormField(
          // controller: dobcontroller,
          //       decoration: InputDecoration(
          //         border: OutlineInputBorder(),
          //          //fillColor: Colors.white,
          //         prefixIcon: Icon(Icons.calendar_today,color: custom_color.appcolor,),
          
          //         labelText: "Date of Birth"
          //       ),
          
          //       readOnly: true,
          //       onTap: (() {
          //         _selectDate();
          //       }),
          //     ),
          //     ),
          SizedBox(height: screenHeight*0.02,),

          Row(
            children: [
              Container(
                width: screenWidth*0.49,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                     controller: dobcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                    //filled: true,
                    prefixIcon: Icon(Icons.calendar_today,color: custom_color.appcolor,),
                            
                    labelText: "Date of Birth"
                  ),
                            
                  readOnly: true,
                  onTap: (() {
                    _selectDate();
                  }),
                  
                  ),
                ),
              ),
                   Container(
                width: screenWidth*0.49,
                child: TextField(
                   controller: date_of_anniversarycontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                   fillColor: Colors.white,
                   
                  prefixIcon: Icon(Icons.calendar_today,color: custom_color.appcolor,),
          
                  labelText: "Date of Anniversary"
                ),
          
                readOnly: true,
                onTap: (() {
                  selectDate();
                }),

                ),
              ),

            ],
          ),
               
               SizedBox(height: screenHeight*0.02,),
          
               Padding(padding: EdgeInsets.all(8.0),
               child: TextFormField(
                controller: organizationcontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Organization *"
                ),
               ),
               ),
          
               SizedBox(height: screenHeight*0.04,),
          
               Container(width: screenWidth,
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: ElevatedButton(
                     style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                       
                                RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                          
                         
                                 ),
                       
                                 )
                     
                                 ),
                    child: Text("Update",style: TextStyle(fontSize: 18,color: Colors.white),),
                             
                    onPressed: (() async {
                      if(selected_item==null){
                        NigDocToast().showErrorToast("Select Your Title");
                   
                      }else if(Referral_Namecontroller.text.isEmpty){
                        NigDocToast().showErrorToast("Enter Referral Name");
                   
                      // }else if(mobilecontroller.text.isEmpty){
                      //   NigDocToast().showErrorToast("Enter Mobile No");
                   
                      // } else if (!Emailcontroller.text
                      //              .contains('@') ||
                      //              !Emailcontroller.text.contains('.') ||
                      //              !Emailcontroller.text.contains('com')) {
                      //               NigDocToast().showErrorToast("Please Enter Your Email id");
                                  
                   
                      // }else if(addresscontroller.text.isEmpty){
                      //   NigDocToast().showErrorToast("Enter Your Address");
                   
                      // }else if(citycontroller.text.isEmpty){
                      //   NigDocToast().showErrorToast("Enter Your City");
                   
                   
                      // }else if(pincodecontroller.text.isEmpty){
                      //   NigDocToast().showErrorToast("Enter Your Pincode");
                   
                      // }else if(dobcontroller.text.isEmpty){
                      //   NigDocToast().showErrorToast("Enter Your DOB");
                   
                      // }else if(date_of_anniversarycontroller.text.isEmpty){
                      //   NigDocToast().showErrorToast("Enter Your Anniversary Date");
                   
                      }else if(organizationcontroller.text.isEmpty){
                        NigDocToast().showErrorToast("Enter Organizer");
                   
                      }else{
                           var item= {
                          'id':data['id'].toString(),
                          "title":selected_item.toString(),
                          "name":Referral_Namecontroller.text.toString(),
                          "mobile_no":mobilecontroller.text.toString(),
                          // "email_id":Emailcontroller.text.toString(),
                          "address":addresscontroller.text.toString(),
                          "city":citycontroller.text.toString(),
                          "pincode":pincodecontroller.text.toString(),
                          "dob":dobcontroller.text.toString(),
                          "doa":date_of_anniversarycontroller.text.toString(),
                          "organization":organizationcontroller.text.toString(),
                                    
                        
                           };
                            var list = await PatientApi()
                                    .Editreferral( accesstoken, item);
                                if (list['message'] ==
                                    "updated successfully") {
                                  NigDocToast().showSuccessToast(
                                      'updated successfully');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Referral()));
                               
                                }
                                 else {
                                  NigDocToast()
                                      .showErrorToast('Please TryAgain later');
                                }
                           
                      }
                     
                    }),
                    
                    
                    
                    ),
                 ),
               ),
          
          SizedBox(height: screenHeight*0.04,),
                 
            ],
          ),
        ),
      ),

      
    );
    
  }
 Future<void>_selectDate() async {
      DateTime? _picked =  await showDatePicker(
        context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980), 
      lastDate: DateTime.now(),
      );
      if(_picked != null){
       setState(() {
         dobcontroller.text=_picked.toString().split(" ")[0];
       });
      }
    }
    Future<void>selectDate() async {
      DateTime? picked =  await showDatePicker(
        context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980), 
      lastDate: DateTime.now(),
      );
      if(picked != null){
       setState(() {
         date_of_anniversarycontroller.text=picked.toString().split(" ")[0];
       });
      }
    }



  
}