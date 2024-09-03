import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/veiw/EditPatient.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/veiw/Patients.dart';
//import 'package:nigdoc/AppWidget/PatientsWidget/veiw/Registration.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;

class PatientList extends StatefulWidget {
  const PatientList({super.key});

  @override
  State<PatientList> createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  final LocalStorage storage = new LocalStorage('doctor_store');
   TextEditingController searchText = TextEditingController();
   String medicineDropdownvalue="empty";


  var accesstoken=null;
  var ProductList;
  var userResponse;
  bool isLoading=false;
  var list=0;
  var SelectedPharmacy;
  var patientList;
  var patient_List;
  
  var searchList;
  var treatmentList;
  var Treatment_List;
 var MediNameList;
 var medicineList;
 var medicine_List;
 bool valid=false;
 bool MedicineLoader=false;

   @override
  void initState() {
    userResponse = storage.getItem('userResponse');
    accesstoken=userResponse['access_token'];
    // getMediAndLabNameList();
    getPatientList();

    // gettreatmentlist();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // patient_List=Helper().isvalidElement(searchList)&&searchText.text.isNotEmpty?searchList: patientList;
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
          appBar: AppBar(title: Text('Patient List',
          style: TextStyle(color: Colors.white),),
          backgroundColor:custom_color.appcolor,
          leading: IconButton(onPressed: (){
            Navigator.push(
          context, MaterialPageRoute(builder: (context)=> Dash(),)
         );
          }, icon: Icon(Icons.arrow_back,
          color: Colors.white,),),
          // actions: [TextButton(onPressed: (){
          //   Navigator.push(context, MaterialPageRoute(builder: (context) => const Add()),);
          // }, child: 
          // Row(
          //   children: [
          //     Icon(Icons.add, color: Colors.black,),
          //     Text('Add',style: TextStyle(fontSize: 18, color:Colors.black),),
          //   ],
          // )),
          // ],
          ),
          body:isLoading? Container(
            height: screenHeight,
            child: Column(
              children: [
                
                 SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Center(child: 
                    Container(
                      height: screenHeight * 0.06,
                      width: screenWidth*0.95,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: custom_color.appcolor,),
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Row(
                        children: [
                          // Container(
                          //     width: screenWidth * 0.1,
                          //     height: screenHeight,
                          //     child: Icon(Icons.search,
                          //         color: custom_color.appcolor,)),
                          Container(
                            width: screenWidth * 0.65,
                            child: TextField(
                              controller: searchText,
                              onChanged: (text) {
                                print(text);
                                filterItems(text);
          
                                // this.setState(() {});
                                // // var list = ProductListItem;
                                //   searchList = patientList.where((element) {
                                //     var treatList = element['customer_name'].toString().toLowerCase();
                                //     return treatList.contains(text.toLowerCase());
                                //     // return true;
                                //   }).toList();
                                  this.setState(() {});
                              },
                              decoration: new InputDecoration(
                                filled: true,
                                border: InputBorder.none,
                                fillColor: Colors.white,
                                hintText: 'Search Patient List Here...',
                              ),
                            ),
                          ),
                          searchText.text.isNotEmpty
                              ? Container(
                                  width: screenWidth * 0.06,
                                  height: screenHeight,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        searchText.clear();
                                        filterItems(searchText.text);
                                        searchList='';
                                      });
                                    },
                                  ))
                              : Container(),
                              Container(
                              width: screenWidth * 0.18,
                              height: screenHeight,
                              child: Icon(Icons.search,
                                  color: custom_color.appcolor,)),
                        ],
                      ),
                    ),),
          
          
                        // SizedBox(height: screenHeight*0.01),
                       
          
                        Helper().isvalidElement(patient_List) && patient_List.length > 0 ?
                         Container(
                          height:screenHeight * 0.85,
                          
          
                         width: screenWidth,
                          padding:EdgeInsets.all(5),
                          child: 
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: patient_List.length,
                            itemBuilder: (BuildContext context, int index){
                              list=index+1;
                              var data=patient_List[index];
                              return Container(
                                child: Column(
                                  children: [
                                    Card(
                                      color: index % 2 == 0
                                                    ?custom_color.lightcolor
                                                    : Colors.white,
                                      child: ListTile(
                                        // title: SizedBox(child: Text('${data['customer_name'].toString() }(${data['customer_id']})')),
                                        title: SizedBox(child: Text('${data['customer_name'].toString() }')),
                                        subtitle: Text('${data['phone']}'),
                                        leading: Padding(
                                          padding: const EdgeInsets.only(top:3.0),
                                          child: Text('$list'),
                                        ),



                         trailing: PopupMenuButton(itemBuilder:(context)=>[
                          PopupMenuItem(child: Row(
                            children: [
                              Icon(Icons.edit,color: custom_color.appcolor,),
                              Padding(padding: EdgeInsets.only(left:10),
                              child: Text('Edit',style: TextStyle(fontSize: 16),),

                              
                              ),
                              
                            ],
                          ),
                          onTap: (() {
                            var selectdata= data;
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Edit_Patients(selecteddata: selectdata,)));
                          }),
                          ),
                          
                         ],
                        
                          ),

                                      ),
                                    )
                                  ],
                                ),
                              );
                          }
                          )
                           ):Container(child:
            Text('No Data Found')
            )
                            
                  ],
                ),
                     ],
            ),
          ):Center(
            child: Container(child:SpinLoader()
          )),
           floatingActionButton: FloatingActionButton(
          backgroundColor: custom_color.appcolor,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Patients()));
          },
          child: Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        ));
  }
  


  getPatientList() async {
   
    var List = await PatientApi().getpatientlist(accesstoken);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        patientList = List['Customer_list'];
        isLoading=true;
        filterItems(searchText.text);
        // var values = MediAndLabNameList;
      });
      // TreatmentList = List['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
    }
  }
  void filterItems(String text) {
    // setState(() {
    if (text.isEmpty) {
      setState(() {
        patient_List = patientList;
      });
    } 
    else if (text.length >= 3) {
      setState(() {
        patient_List = patientList.where((item) =>
            item['customer_name']
                .toString()
                .toLowerCase()
                .contains(text.toLowerCase())||
            item['phone']
                .toString()
                .toLowerCase()
                .contains(text.toLowerCase())
                ).toList();
      });
    }
  }
}