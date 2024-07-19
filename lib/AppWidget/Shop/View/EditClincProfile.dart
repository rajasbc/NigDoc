import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localstorage/localstorage.dart';

import 'package:nigdoc/AppWidget/DoctorWidget/veiw/DoctorList.dart';
import 'package:nigdoc/AppWidget/Shop/View/ClinicProfile.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:nigdoc/main.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;




class Edit_ClinicProfile extends StatefulWidget {
  const Edit_ClinicProfile({super.key});

  @override
  State<Edit_ClinicProfile> createState() => _Edit_ClinicProfileState();
}


class _Edit_ClinicProfileState extends State<Edit_ClinicProfile> {
  final LocalStorage storage= new LocalStorage('doctor_store');
TextEditingController  clinicnamecontroller=TextEditingController();
TextEditingController  clinicshortnamecontroller=TextEditingController();
TextEditingController  clinicregistrationnumbercontroller=TextEditingController();
TextEditingController  dlnocontroller=TextEditingController();
TextEditingController  gstcontroller=TextEditingController();
TextEditingController  emailidcontroller=TextEditingController();
TextEditingController  addressline1controller=TextEditingController();
TextEditingController  addressline2controller=TextEditingController();
TextEditingController  areacontroller=TextEditingController();
TextEditingController  citycontroller=TextEditingController();
TextEditingController  statecontroller=TextEditingController();
TextEditingController  statecodecontroller=TextEditingController();
TextEditingController  countrycontroller=TextEditingController();
TextEditingController  pincodecontroller=TextEditingController();
TextEditingController  mobileno=TextEditingController();
TextEditingController  alternativemobilecontroller=TextEditingController();
TextEditingController  landlinecontroller=TextEditingController();
TextEditingController  clinictypecontroller=TextEditingController();
TextEditingController barcodecontroller= TextEditingController();

 int? _barcodeSelected;
  String _barcode = "";

//String barcode ='Yes';

var isloading=false;
 var userResponse;

@override
void initState(){
  userResponse=storage.getItem('userResponse');
  
  shopInfo();
    
    super.initState();
}

  
  @override
  Widget build(BuildContext context) {
    double screenHeight=MediaQuery.of(context).size.height;
    double screenWidth=MediaQuery.of(context).size.width;
    return PopScope(
    canPop: false,
    onPopInvoked: (bool didPop) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ClinicProfile()));
    },
    child: Scaffold(
      appBar: AppBar(
        title: Text("Edit Clinic Profile",
        style: TextStyle(color: Colors.white),),

        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ClinicProfile()));
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        backgroundColor: custom_color.appcolor,
      ),


      body:isloading ?  Container(
        height: screenHeight,
        width: screenWidth,
        child: Padding(
          padding: const EdgeInsets.only(left: 09,right: 09),
          child: SingleChildScrollView(
            
            child: Column(
              children: [
          
                Padding(padding: EdgeInsets.only(left: 00,right: 00),
                
                child: Column(
                 children: [
                  
                 SizedBox(height: screenHeight*0.01,),
                    Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                //  border:  Border.all(width: 2, color:custom_color.app_color1 ),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        height: screenHeight * 0.07,
                                        child: Image.asset('assets/profile.png'),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        // color: Colors.amberAccent,
                                        //  height: screenHeight * 0.06,
                                        width: screenWidth * 0.6,
                                        child: TextFormField(
                                          
                                decoration: const InputDecoration(
                                   border: InputBorder.none,

                                   labelText: "Clinic Name "
                                ),

                          
                                // autovalidateMode: AutovalidateMode.always,
                               
                                controller: clinicnamecontroller,
                                 
                                
                                // validator: (value) {
                                //   if(value == null || value.isEmpty) {
                                //     return "";
                                //   }
                                //   return null;
                                // },
                              ),
                                      
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                 ],
                ),
                
                ),
          
                SizedBox(height:screenHeight*0.02),
          
                TextFormField(
                  
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Clinic Short Name",
                  ),
                 
                  controller: clinicshortnamecontroller,
                 // readOnly: true,
                  
                
                ),
               

               SizedBox(height:screenHeight*0.02),
                 TextFormField(
                  keyboardType: TextInputType.number,
                   decoration: const InputDecoration(
                     border: OutlineInputBorder(),
                     labelText: "Clinic Registation Number",
                   ),
                   
                   controller: clinicregistrationnumbercontroller,
                  // readOnly: true,
                  
                 ),
                 SizedBox(height: screenHeight*0.02,),

                 TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'DL No',
                    
                  ),
                  controller: dlnocontroller,
                 ),

                  
                  SizedBox(height: screenHeight*0.02,),

                 TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Shop GST No',
                    
                  ),
                  controller: gstcontroller,
                 ),
                 SizedBox(height: screenHeight*0.02,),

                 TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email Id',
                    
                  ),
                  controller: emailidcontroller,
                 ),
                 SizedBox(height: screenHeight*0.02,),

                 Row(
                  
                   children: [
                    
                     Container(
                       width: screenWidth*0.46,
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: TextField(
                          
                           decoration: InputDecoration(
                             border: OutlineInputBorder(),
                             labelText: 'Adderss Line 1'
                           ),
                           controller: addressline1controller,
                         ),
                       ),
                     ),
                     
                       SizedBox(width: screenWidth*0.02,),

                       Container(
                         width: screenWidth*0.46,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Address Line2'
                          ),
                          controller: addressline2controller,
                        ),
                       )    
                     
                   ],
                 ),
                   

                   Row(
                  
                   children: [
                    
                     Container(
                       width: screenWidth*0.46,
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: TextField(
                          
                           decoration: InputDecoration(
                             border: OutlineInputBorder(),
                             labelText: 'Area'
                           ),
                           controller: areacontroller,
                         ),
                       ),
                     ),
                     
                       SizedBox(width: screenWidth*0.02,),

                       Container(
                         width: screenWidth*0.46,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'City'
                          ),
                          controller: citycontroller,
                        ),
                       )
                       
                     
                   ],
                 ),

                 Row(
                  
                   children: [
                    
                     Container(
                       width: screenWidth*0.46,
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: TextField(
                          
                           decoration: InputDecoration(
                             border: OutlineInputBorder(),
                             labelText: 'State'
                           ),
                           controller: statecontroller,
                         ),
                       ),
                     ),
                     
                       SizedBox(width: screenWidth*0.02,),

                       Container(
                         width: screenWidth*0.46,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'State Code'
                          ),
                          controller: statecodecontroller,
                        ),
                       )
                       
                     
                   ],
                 ),

                 Row(
                  
                   children: [
                    
                     Container(
                       width: screenWidth*0.47,
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: TextField(
                          
                           decoration: InputDecoration(
                             border: OutlineInputBorder(),
                             labelText: 'Country'
                           ),
                           controller: countrycontroller,
                         ),
                       ),
                     ),
                     
                       SizedBox(width: screenWidth*0.01,),

                       Container(
                         width: screenWidth*0.47,
                        child: TextField(
                          
                            inputFormatters: [LengthLimitingTextInputFormatter(6)],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Pincode'
                          ),
                          controller: pincodecontroller,
                        ),
                       )
                       
                     
                   ],
                 ),


          SizedBox(height: screenHeight*0.02,),

          TextFormField(
            maxLength: 10,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Mobile No',
            ),
            controller: mobileno,
            
          ),

          SizedBox(height: screenHeight*0.02,),

          TextFormField(
            maxLength: 10,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Alternative Mobile No',
            ),
            controller: alternativemobilecontroller,
            
          ),

          SizedBox(height: screenHeight*0.02,),

          TextFormField(
            //maxLength: 10,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Landline No',
            ),
            controller: landlinecontroller,
            
          ),

          SizedBox(height: screenHeight*0.02,),

          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Clinic Type',
            ),
            controller: clinictypecontroller,
            
          ),

          SizedBox(height: screenHeight*0.02,),


          Container(
            child: Row(
              children: [
              Container(
                width: screenWidth*0.3,
                child: Text('Barcode',
                
                style: TextStyle(fontSize: 18),
                ),
              ),
            
            
              Container(
                 width:screenWidth*0.33,
                child: RadioListTile(
                 
                   title: Text("Yes"),
                  value: 1, 
                  groupValue: _barcodeSelected,
                   onChanged: (value){
                   // value=_barcode;
                    setState(() {
                      _barcodeSelected = value as int;
                                       _barcode = 'Yes';
                                      print(_barcode);
                    });
                  }
                  ),
              ),
               Container(
                                    // color: Colors.amber,
                                    width: screenWidth * 0.3,
                                    child: RadioListTile(
                                      title: Text("No"),
                                      value: 2,
                                      groupValue: _barcodeSelected,
                                      onChanged: (value) {
                                        //value = _barcode;
                                        setState(() {
                                         //_barcode = value.toString();
                                          _barcodeSelected = value as int;
                                       _barcode = 'No';
                                      print(_barcode);
                                        });
                                      },
                                    ),
                                  ),
            ],
            
            
            ),
          ),

          SizedBox(height: screenHeight*0.02,),


          Container(width: screenWidth,
            child: ElevatedButton(
             style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                   
                  
                ),
                
              )
              
            ),
               child: Text('Update',style: TextStyle(
              fontSize: 20,color: Colors.white),
            
            ),
            
                     onPressed: () {
             if(clinicnamecontroller.text.isEmpty){
              NigDocToast().showErrorToast("Enter Clinic Name");
             }else if(clinicshortnamecontroller.text.isEmpty){
                NigDocToast().showErrorToast("Enter Shop Short Name");
             }else if(clinicregistrationnumbercontroller.text.isEmpty){
                NigDocToast().showErrorToast("Enter Your Registation Number");
             }else if(dlnocontroller.text.isEmpty){
                NigDocToast().showErrorToast("Enter Your DL No");
             }else if(gstcontroller.text.isEmpty){
                NigDocToast().showErrorToast("Enter Your GST No");
             }else if(!emailidcontroller.text.contains('@')||
                      !emailidcontroller.text.contains('.')||
                      !emailidcontroller.text.contains('com') ){
                NigDocToast().showErrorToast("Enter Your Email Id");
             }else if(addressline1controller.text.isEmpty){
                NigDocToast().showErrorToast("Enter Your Address Line1");
             }else if(addressline2controller.text.isEmpty){
                NigDocToast().showErrorToast("Enter Your Address Line2");
             }else if(areacontroller.text.isEmpty){
                NigDocToast().showErrorToast("Enter Your Area");
             }else if(citycontroller.text.isEmpty){
                NigDocToast().showErrorToast("Enter Your City");
             }else if(statecontroller.text.isEmpty){
                NigDocToast().showErrorToast("Enter Your State");
             }else if(statecodecontroller.text.isEmpty){
                NigDocToast().showErrorToast("Enter Your State Code");
             }else if(countrycontroller.text.isEmpty){
                NigDocToast().showErrorToast("Enter Your country");
             }else if(pincodecontroller.text.isEmpty){
                NigDocToast().showErrorToast("Enter Your Pincode");
             }else if(mobileno.text.isEmpty){
                NigDocToast().showErrorToast("Enter Your Mobile No");
             }else if(alternativemobilecontroller.text.isEmpty){
                NigDocToast().showErrorToast("Enter Your Alternative Mobile No");
             }else if(landlinecontroller.text.isEmpty){
                NigDocToast().showErrorToast("Enter Your Landline No");
             }else if(clinictypecontroller.text.isEmpty){
                NigDocToast().showErrorToast("Enter Clinic Type");
             
             
             }else{
               var data ={
                     
                     "clinic name":clinicnamecontroller.text.toString(),
                     "clinic short name":clinicshortnamecontroller.text.toString(),
                     "Registation":clinicregistrationnumbercontroller.text.toString(),
                     "Dl no":dlnocontroller.text.toString(),
                     "GST":gstcontroller.text.toString(),
                     "email id":emailidcontroller.text.toString(),
                     "address 1":addressline1controller.text.toString(),
                     "address 2":addressline2controller.text.toString(),
                     "area":areacontroller.text.toString(),
                     "city":citycontroller.text.toString(),
                     "state":statecontroller.text.toString(),
                     "state code":statecodecontroller.text.toString(),
                     "Country":countrycontroller.text.toString(),
                     "pincode":pincodecontroller.text.toString(),
                     "mobile":mobileno.text.toString(),
                     "alternative":alternativemobilecontroller.text.toString(),
                     "landline":landlinecontroller.text.toString(),
                     "clinic type":clinictypecontroller.text.toString(),
                     "barcode":barcodecontroller.text.toString(),
            
                      };
                      Helper().isvalidElement(data);
                      print(data);
             }  
             
                     },
            ),
          ),

          SizedBox(height: screenHeight*0.04,),
          
              ],
            ),
          ),
        ),
      ):Center(child: SpinLoader()),

      
    ) ,
    );
  }
  shopInfo() {
   // var list = userResponse['clinic_profile'];
    var list = userResponse['clinic_profile'];
    setState(() {
      
      clinicnamecontroller.text =Helper().isvalidElement(list['name'])? list['name'].toString():'';
      clinicshortnamecontroller.text=Helper().isvalidElement(list['shop'])?list['shop'].toString():'';
      clinicregistrationnumbercontroller.text =  Helper().isvalidElement(list['register_id'])? list['register_id'].toString():'';
      dlnocontroller.text = Helper().isvalidElement(list['dl_no'])? list['dl_no'].toString():'';
      gstcontroller.text = Helper().isvalidElement(list['shop_gst_no'])? list['shop_gst_no'].toString():'';
      emailidcontroller.text = Helper().isvalidElement(list['email'])? list['email'].toString():'';
      addressline1controller.text = Helper().isvalidElement(list['address1'])? list['address1'].toString():'';
      addressline2controller.text = Helper().isvalidElement(list['address2'])? list['address2'].toString():'';
      areacontroller.text =Helper().isvalidElement(list['area'])? list['area'].toString():''; 
      citycontroller.text = Helper().isvalidElement(list['city'])? list['city'].toString():'';
      statecontroller.text =  Helper().isvalidElement(list['state'])? list['state'].toString():'';
      statecodecontroller.text =  Helper().isvalidElement(list['state_code'])? list['state_code'].toString():'';
      countrycontroller.text =  Helper().isvalidElement(list['country'])? list['country'].toString():'';
      pincodecontroller.text = Helper().isvalidElement(list['pincode'])? list['pincode'].toString():'';
      mobileno.text =Helper().isvalidElement(list['mobile_no'])? list['mobile_no'].toString():''; 
      alternativemobilecontroller.text =Helper().isvalidElement(list['alt_mobile_no'])? list['alt_mobile_no'].toString():''; 
      landlinecontroller.text = Helper().isvalidElement(list['landline_no'])? list['landline_no'].toString():'';
      clinictypecontroller.text =  Helper().isvalidElement(list['clinic_type'])? list['clinic_type'].toString():'';
      _barcode = Helper().isvalidElement(list['barcode'])? list['barcode'].toString().toLowerCase():'';
      isloading=true;
     
    });
  }
}
 
