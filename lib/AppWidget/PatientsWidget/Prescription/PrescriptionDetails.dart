import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Prescription/PrescriptionList.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;

class PrescriptionDetails extends StatefulWidget {
  final select_prescription;
  const PrescriptionDetails({super.key,request, this.select_prescription});

  @override
  State<PrescriptionDetails> createState() => _PrescriptionDetailsState();
}

class _PrescriptionDetailsState extends State<PrescriptionDetails> {
  TextEditingController prescdatecontroller = TextEditingController();
  TextEditingController drnamecontorller = TextEditingController();
  TextEditingController referralcontroller = TextEditingController();
  var userResponse;
  var accesstoken;
  var data;
  List prescriptionList =[]; 
  List injection = [];
  List testlist =[];
  bool isLoading = false;
  var medicine;
  var Testlist;
  var InjectionList;

  @override
  void initState() {
    userResponse = storage.getItem('userResponse');
    accesstoken=userResponse['access_token'];
  setState(() {
      data = widget.select_prescription;
      print(data);
      getprescriptiondetails();
  });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Prescription_List()));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Prescription Details',style: TextStyle(color: Colors.white),),
          leading: IconButton(onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>Prescription_List()));
          }, icon: Icon(Icons.arrow_back,color: Colors.white,)
          ),
          backgroundColor:custom_color.appcolor,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Column(
                  children: [
                    
                   
Container(
  
     child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
           Divider(),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    Text('Pres Date : ${data['setdate']} ', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Doctor Name : ${data['username']}', style: TextStyle(fontWeight: FontWeight.bold)),
                    // Text('Referral Name : ', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: screenHeight*0.02,),
                Container(
                  // color: Colors.amber,
                  width: screenWidth,
                  child: Text('Referral Name : ${data['refe_name']} ', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Medicine Details', style: TextStyle( fontWeight: FontWeight.bold)),
          ),
          buildTable(screenWidth, prescriptionList, ['medi_name', 'days', 'patterntype', 'before_after_food'], 
                    ['Medicine Name', 'No.of.days', 'Method', 'Before / After Food']),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 05.0),
          //   child: Table(
          //     columnWidths: {
          //       0: FlexColumnWidth(3),
          //       1: FlexColumnWidth(1),
          //       2: FlexColumnWidth(2),
          //       3: FlexColumnWidth(2),
          //     },
          //     border: TableBorder.all(color: Colors.grey),
          //     children: [
          //       TableRow(children: [
          //         Padding(
          //           padding: const EdgeInsets.all(07.0),
          //           child: Text('Medicine Name', style: TextStyle(fontWeight: FontWeight.bold)),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(07.0),
          //           child: Container(
          //             width: screenWidth*0.20,
          //             child: Text('No.of.days', style: TextStyle(fontWeight: FontWeight.bold))),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(07.0),
          //           child: Text('Method', style: TextStyle(fontWeight: FontWeight.bold)),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(07.0),
          //           child: Text('Before / After Food', style: TextStyle(fontWeight: FontWeight.bold)),
          //         ),
          //       ]
          //       ),
          //       TableRow(children: [
                  
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Text('${Helper().isvalidElement(medicine)&&Helper().isvalidElement(medicine)?medicine['medi_name'] == null ? '' :medicine['medi_name'].toString() : ''}'),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Text('${Helper().isvalidElement(medicine)&&Helper().isvalidElement(medicine)?medicine['days'] == null ? '' :medicine['days'].toString() : ''}'),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Text('${Helper().isvalidElement(medicine)&&Helper().isvalidElement(medicine)?medicine['patterntype'] == null ? '' :medicine['patterntype'].toString() : ''}'),
          //           // child: Text('${medicine['patterntype'].toString()}'),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Text('${Helper().isvalidElement(medicine)&&Helper().isvalidElement(medicine)?medicine['before_after_food'] == null ? '' :medicine['before_after_food'].toString() : ''}'),
          //           // child: Text('${medicine['before_after_food'].toString()}'),
          //         ),
          //       ]),
          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Injection Details', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          buildTable(screenWidth, injection, ['injection_name', 'dose'], ['Injection Name', 'Dosage']),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 05.0),
          //   child: Table(
          //     columnWidths: {
          //       0: FlexColumnWidth(3),
          //       1: FlexColumnWidth(1),
          //     },
          //     border: TableBorder.all(color: Colors.grey),
          //     children: [
          //       TableRow(children: [
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Text('Injection name', style: TextStyle(fontWeight: FontWeight.bold)),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Text('Doseage', style: TextStyle(fontWeight: FontWeight.bold)),
          //         ),
          //       ]),
          //       TableRow(children: [
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Text('${Helper().isvalidElement(InjectionList)&&Helper().isvalidElement(InjectionList)?InjectionList['injection_name'] == null ? '' :InjectionList['injection_name'].toString() : ''}'),
          //         ),
          //         Padding(
                    
          //           padding: const EdgeInsets.all(8.0),
          //           child: Text('${Helper().isvalidElement(InjectionList)&&Helper().isvalidElement(InjectionList)?InjectionList['dose'] == null ? '' :InjectionList['dose'].toString() : ''}'),
          //         ),
          //       ]),
          //     ],
          //   ),
          // ),
        ],
      ),
   )
                  
                  ],
                ),
              ),
            ),
          )),
      ));
  }
   
   getprescriptiondetails() async {

    var item = {
      "id": data['id'].toString(),
      "patient_id": data['patient_id'].toString(),
      
    };
    
   var list = await PatientApi().getprescriptionDetails(accesstoken, item);
    if (Helper().isvalidElement(list) &&
        Helper().isvalidElement(list['status']) &&
        list['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      prescriptionList = list['list'];
         medicine = prescriptionList[0];
      testlist = list['testlist'];
      Testlist = testlist[0];
      injection = list['injection'];
      InjectionList = injection[0];
      print(prescriptionList);

      this.setState(() {
        isLoading = true;
      });
    }
  }
 Widget buildTable(double screenWidth, List dataList, List<String> keys, List<String> headers) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 05.0),
      child: Table(
        columnWidths: {
          for (int i = 0; i < headers.length; i++) i: FlexColumnWidth(1),
        },
        border: TableBorder.all(color: Colors.grey),
        children: [
          TableRow(
            children: headers
                .map((header) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(header, style: TextStyle(fontWeight: FontWeight.bold)),
                    ))
                .toList(),
          ),
          for (var row in dataList)
            TableRow(
              children: keys.map((key) {
                var value = row[key];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(value != null ? value.toString() : ''),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}