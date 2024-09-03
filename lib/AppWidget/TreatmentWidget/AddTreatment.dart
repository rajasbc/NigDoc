import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/Common/utils.dart';
import 'package:nigdoc/AppWidget/Medicine/AddMedicineList.dart';
import 'package:nigdoc/AppWidget/Medicine/MedicineList.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/TreatmentWidget/treatment.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:nigdoc/main.dart';

class AddTretment extends StatefulWidget {
  const AddTretment({super.key});

  @override
  State<AddTretment> createState() => _AddTretmentState();
}

class _AddTretmentState extends State<AddTretment> {
    TextEditingController Medicinecontroller = TextEditingController();
  final LocalStorage storage = new LocalStorage('doctor_store');
  String medicinedropdow = "Select Medicine List *";
  String departmentdropdown = "Select Department *";
  List Medicine_List =[];
 var selectedmedicine;
  var SelectedPharmacy;
  List medicineList=[];
  List departmentListList =[];
  var Depaartment;
  // String? selectedValue;
  var userResponse;
  var accesstoken;
  bool isloading=false;
  bool medicine =true;

  TextEditingController Treatmentcontroller = TextEditingController();
  TextEditingController medicinecontroller = TextEditingController();
  TextEditingController Departmentcontroller = TextEditingController();
  TextEditingController Feescontroller = TextEditingController();
  
@override
  void initState() {
     userResponse = storage.getItem('userResponse');
    accesstoken=userResponse['access_token'];
    getdepartmentList();
    getMedicineList();

    // TODO: implement initState
    super.initState();
  }
  getdepartmentList() async{
    var List = await PatientApi().getdepartmentList(accesstoken);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        departmentListList = List['list'];
      });
    }
  }
    getMedicineList() async {
    var data = {
      "shop_id": Helper().isvalidElement(SelectedPharmacy)?  SelectedPharmacy.toString():'',
    };

    var List = await PatientApi().getMedicineList(accesstoken, data);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        //  MediAndLabNameList = List['list'];
        medicineList = List['list'];
        // MedicineLoader=true;
        // valid=true;
        // isLoading=true;
      });
      // TreatmentList = List['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
    }
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
 return  PopScope(
       canPop:false,
       onPopInvoked:(bool didpop) {
         Navigator.push(
          context, MaterialPageRoute(builder: (context)=> TreatmentList(),)
         );
         
        },
    child: Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Treatment',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: custom_color.appcolor,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TreatmentList(),
                ));
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),

      body:SingleChildScrollView(
        child: SafeArea(
          child: Container(
            
            
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(height: screenHeight*0.02,),
                TextFormField(
                  
                  controller: Treatmentcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Treatment Name'
                  ),
                ),
               
                SizedBox(
                  height: screenHeight * 0.02,
                ),

                
                //  Padding(
                //    padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                //       //padding: const EdgeInsets.all(20.0),
                //       child: Container(
                //         height: screenHeight *0.07,
                //         width: screenWidth * 0.96,
                //         decoration: BoxDecoration(border: Border.all(color: Colors.grey),
                //         borderRadius: BorderRadius.circular(5.0)
                //             // border: OutlineInputBorder()
                //             ),
                //         child: Padding(
                //           padding: const EdgeInsets.all(10.0),
                //           child: Center(
                //             child: DropdownButtonFormField(
                            
                //               decoration: InputDecoration.collapsed(hintText: ''),
                //               isExpanded: true,
                //               hint: Padding(
                //               padding: const EdgeInsets.only(top: 0, left: 2, right: 0,),
                //                 child: Text(
                //                   ' Medicine List*',
                                 
                //                 ),
                //               ),
                             
                //               onChanged: (newvalue) {
                //               //  medicineList=newvalue.toString();
                //               medicinedropdow=newvalue.toString();
                //                 setState(() {
                                 
                //                 });
                             
                //               },
                //               items:title .map<DropdownMenuItem<String>>((item) {
                //                 return new DropdownMenuItem(
                //                   child: Padding(
                //                     padding: const EdgeInsets.only(top: 7, left: 8, right: 8),
                //                     child: new Text(item,style: TextStyle(fontSize: 15),),
                //                   ),
                //                   value: item.toString(),
                //                 );
                //               }).toList(),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),

               

                SizedBox(
            width: screenWidth * 0.95,
            child: DropdownButtonFormField(
              menuMaxHeight: 300,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                isExpanded: true,
                hint: const Text(
                  'Department*',
                ),
                // value:patternDropdownvalue,
                onChanged: (item) async {
                  departmentdropdown = item.toString();
                },
                items: departmentListList
                    .map<DropdownMenuItem<String>>(
                        (value) => DropdownMenuItem<String>(
                              value: value["id"].toString(),
                              child: Text(value["department_name"].toString()),
                            ))
                    .toList()

                )),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
          
                TextFormField(
                  keyboardType: TextInputType.number,
                     controller: Feescontroller,
                      autovalidateMode: AutovalidateMode.always,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Fees *'
                  ),
                ),
          SizedBox(height: screenHeight*0.02),
               Container(
                 child: Helper().isvalidElement(selectedmedicine)
                ? RenderPatientdata(screenHeight, screenWidth)
                : renderPatientAutoComplete(screenHeight, screenWidth)
               ),
          SizedBox(height: screenHeight*0.02),
          Medicine_List.length>0?renderMedicineListWidget(screenHeight, screenWidth):Container(),
                SizedBox(
                  height: screenHeight * 0.02,
                ),

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
                      child: Text(
                        'Save',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                      onPressed: () async {
                        if (Treatmentcontroller.text.isEmpty) {
                          NigDocToast().showErrorToast('Enter Treatment Name');
                        } else if (Medicine_List.length == 0) {
                          NigDocToast().showErrorToast('Please Select Medicine List');
                        } else if (departmentdropdown == "Select Department *") {
                          NigDocToast().showErrorToast('Please Select Department');
                        } else if (Feescontroller.text.isEmpty) {
                          NigDocToast().showErrorToast('Enter Fees');
                         }else {
                          var data = {
                            "treatmentname": Treatmentcontroller.text.toString(),
                            "medicinelist": Medicine_List,
                            "department": departmentdropdown.toString(),
                            "fees": Feescontroller.text.toString(),
                          };
                          var list = await PatientApi().AddTreatment(accesstoken, data);
                           if (list['message'] ==
                                    "Add Treatment successfully") {
                                  NigDocToast().showSuccessToast(
                                      'Treatment Add successfully');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TreatmentList()));
                                } else {
                                  NigDocToast()
                                      .showErrorToast('Please TryAgain later');
                                }
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),),
    );
  }

  RenderPatientdata(screenHeight, screenWidth) {
    return Card(
        elevation: 20,
        child: Container(
          width: screenWidth * 0.95,
          child: ListTile(
            trailing: IconButton(onPressed: (){
              if(Medicine_List.contains(selectedmedicine)){
                                print('exists');
                                Fluttertoast.showToast(
                            msg: 'Already Medicine', fontSize: 15.0);
                                setState(() {
                                    selectedmedicine = null;
                                });
                               
                                }else{
                                  Medicine_List.add(selectedmedicine);
                                  setState(() {
                                    medicine = false;
                                    selectedmedicine = null;
                                  });
                                }

              
            }, icon: Icon(Icons.send)),
            
            title: Text('${selectedmedicine['name'].toString().toUpperCase()}',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
        )
        
        );
  }

  renderPatientAutoComplete(screenHeight, screenWidth) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Autocomplete<List>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isNotEmpty) {
            var matches = [];
            setState(() {});
            matches.addAll(medicineList);
            matches.retainWhere((s) {
              return s['name']
                  .toString()
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            });
            return [matches];
          } else {
            return const Iterable<List>.empty();
          }
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return Container(
            height: screenHeight * 0.07,
            width: screenWidth * 0.95,
            decoration: BoxDecoration(
              // color: Colors.white,
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            padding: EdgeInsets.only(left: 10),
            child: Center(
              child: Center(
                child: TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Medicine'),
                  controller: textEditingController,
                  focusNode: focusNode,
                  onChanged: (text) {
                    Medicinecontroller.text = text;
                  },
                ),
              ),
            ),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<List> onSelected, Iterable<List> options) {
          return options.toList()[0].isNotEmpty
              ? Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    child: Container(
                      width: screenWidth * 0.95,
                      // height: screenHeight * 0.78,
                      color: Colors.white,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(5.0),
                          itemCount: options.toList()[0].length,
                          itemBuilder: (BuildContext context, int index) {
                            var option = options.toList()[0].elementAt(index);

                            return ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                      selectedmedicine= option;
                                  });
                              
                                // // select_test = option;
                                
                                },
                                
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            OutlinedBorder?>(
                                        ContinuousRectangleBorder()),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            custom_color.appcolor)),
                                child: Container(
                                  color: custom_color.appcolor,
                                 
                                  child: Row(
                                    
                                    children: [
                                      SizedBox(
                                        
                                        width: screenWidth * 0.5,
                                        child: Text(
                                            '${options.toList()[0][index]['name'].toString().toUpperCase()} ',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      const Divider(
                                        thickness: 1,
                                      )
                                    ],
                                  ),
                                ));
                          },
                        ),
                      ),
                    ),
                  ),
                )
              : Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: screenWidth * 0.9,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<OutlinedBorder?>(
                                ContinuousRectangleBorder()),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                custom_color.appcolor)),
                        child: Container(
                          child: const Text(
                            'Search List Empty',
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          ),
                        )),
                  ),
                );
        },
      ),
    );
  }

  renderMedicineListWidget(screenHeight, screenWidth){
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color:Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        
        width: screenWidth,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                 width: screenWidth*0.92,
                                      child: ListView.builder(
                                         shrinkWrap: true,
                                          itemCount: Medicine_List.length,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            var data = Medicine_List[index];
                                              return Container(
                                                  child: Column(children: [
                                                ListTile(
                                                  title: Text("${data["name"].toString()}"),
                                                 trailing: IconButton(onPressed: (){
              if(Medicine_List.contains(data)){
                 Medicine_List.remove(data);
                 setState(() {
                     print('exists');

                 });
                                print('exists');

                                }else{
                                  
                                }

              
            }, icon: Icon(Icons.close,),color: custom_color.error_color,),
                                                )
                                                  ])
                                              );
                                              }
                                      )
              
              ),
            
            ],
          ),
        ),
      ),
    );
  }
}
