import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/TreatmentWidget/treatment.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;

class Edittreatment extends StatefulWidget {
  final medicinelist;
  const Edittreatment({super.key, required this.medicinelist});

  @override
  State<Edittreatment> createState() => _EdittreatmentState();
}

class _EdittreatmentState extends State<Edittreatment> {
  final LocalStorage storage = new LocalStorage('doctor_store');
    TextEditingController Medicinecontroller = TextEditingController();
  TextEditingController Treatmentcontroller = TextEditingController();
  TextEditingController Feescontroller = TextEditingController();
  final FocusNode treatmentFocusNode = FocusNode();
  final FocusNode feesFocusNode = FocusNode();
  var departmentdropdown;
  List departmentListList =[];
  var SelectedPharmacy;
  var userResponse;
  var accesstoken;
  var medicinelist;
 var selectedmedicine;
  List Medicine_List =[];
  bool medicine =true;
  List medicineList=[];
  var demo;
  var dep;
  var treatment_id;
  var data1;
  @override
  void initState() {
     userResponse = storage.getItem('userResponse');
    accesstoken=userResponse['access_token'];
    getdepartmentList();
    getMedicineList();
    super.initState();
    var data = widget.medicinelist;
    treatment_id = data['treatment_id'];
    setState(() {
       demo = data["medicinelist"];
      Treatmentcontroller.text = data["treatment"].toString();
      dep = data["department"];
      departmentdropdown = data["department_id"];
      Feescontroller.text = data["fees"].toString();
      Medicine_List = demo;
    });
  }
  void dispose(){
    treatmentFocusNode.dispose();
    feesFocusNode.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return PopScope(
       canPop:false,
       onPopInvoked:(bool didpop) {
         Navigator.push(
          context, MaterialPageRoute(builder: (context)=> TreatmentList(),)
         );
        },
    child: Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Treatment',
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
                  focusNode: treatmentFocusNode,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Treatment Name'
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
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
                hint: Text(
                  '${dep}',
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
                     focusNode: feesFocusNode,
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
                        'Update',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                      onPressed: () async {
                        if (Treatmentcontroller.text.isEmpty) {
                          treatmentFocusNode.requestFocus();
                          NigDocToast().showErrorToast('Enter Treatment Name');
                        } else if (Medicine_List.length == 0) {
                          NigDocToast().showErrorToast('Please Select Medicine List');
                        } else if (departmentdropdown == null ) {
                          NigDocToast().showErrorToast('Please Select Department');
                        } else if (Feescontroller.text.isEmpty) {
                          feesFocusNode.requestFocus();
                          NigDocToast().showErrorToast('Enter Fees');
                         }else {
                           data1 = {
                           "treatmentid":treatment_id.toString(),
                           "treatmentname":Treatmentcontroller.text.toString(),
                           "fees":Feescontroller.text.toString(),
                           "medicinelist":Medicine_List,
                           "departmentid":departmentdropdown.toString(),
                          };
                          var list = await PatientApi().EditTreatment(accesstoken, data1);
                          if (list['message'] ==
                                    "Edit Treatment successfully") {
                                  NigDocToast().showSuccessToast(
                                      'Treatment Edit successfully');
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
              ])
          )))
    )
    );
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