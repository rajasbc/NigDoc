import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/veiw/Dashboardpage.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';

class PrescriptionPage extends StatefulWidget {
  const PrescriptionPage({super.key});
  @override
  State<PrescriptionPage> createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  final LocalStorage storage = new LocalStorage('doctor_store');
  TextEditingController searchText = TextEditingController();
  TextEditingController fees = TextEditingController();
  TextEditingController labnameController = TextEditingController();
  TextEditingController testnameController = TextEditingController();
  TextEditingController medicineController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController grandtotalController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController receivedController = TextEditingController();
  TextEditingController balanceController = TextEditingController();
  TextEditingController changeController = TextEditingController();
  TextEditingController pharmacyController = TextEditingController();
  var searchList;
  var PatientList;
  String treatmentDropdownvalue = 'Select Treatment';
  String patternDropdownvalue = 'pattern';
  String prescriptionDropdownvalue = 'Prescription';
  var select_button = 'treatment';
  var Medicine = 'Medicine';
  var total;
  var count;
  var mor;
  var noon;
  var night;
  var cal;
  double grand_total = 0.0;
  double balance = 0;
  bool showAutoComplete = true;
  var selectedPatient;
  var TreatmentList;
  var treatmentname;
  var click_button;
  var MediAndLabNameList;
  var SelectedLab;
  var SelectedPharmacy;
  bool labshowAutoComplete = true;
  bool testshowAutoComplete = false;
  bool pharmacyshowAutoComplete = true;
  bool medicineshowAutoComplete = true;
  var TestList;
  var SelectedTest;
  var MedicineList;
  var Selectedmedicine;

  var treatment = ['Select Treatment', 'Ferver', 'Head Ache'];
  // var pattern = ['pattern', '0-0-0', '1-1-1', '1-0-1'];
  var demo = {
    {"name": "pattern", "value": "0", "mor": "0", "noon": "0", "night": "0"},
    {"name": "0-0-1", "value": "1", "mor": "0", "noon": "0", "night": "1"},
    {"name": "0-1-0", "value": "1", "mor": "0", "noon": "1", "night": "0"},
    {"name": "0-1-1", "value": "2", "mor": "0", "noon": "1", "night": "1"},
    {"name": "1-0-0", "value": "1", "mor": "1", "noon": "0", "night": "0"},
    {"name": "1-0-1", "value": "2", "mor": "1", "noon": "0", "night": "1"},
    {"name": "1-1-0", "value": "2", "mor": "1", "noon": "1", "night": "0"},
    {"name": "1-1-1", "value": "3", "mor": "1", "noon": "1", "night": "1"},
    {"name": "0-0-2", "value": "2", "mor": "0", "noon": "0", "night": "2"},
    {"name": "0-2-0", "value": "2", "mor": "0", "noon": "2", "night": "0"},
    {"name": "2-0-0", "value": "2", "mor": "2", "noon": "0", "night": "0"},
    {"name": "2-2-0", "value": "4", "mor": "2", "noon": "2", "night": "0"},
    {"name": "0-2-2", "value": "4", "mor": "0", "noon": "2", "night": "2"},
    {"name": "2-0-2", "value": "4", "mor": "2", "noon": "0", "night": "2"},
    {"name": "2-2-2", "value": "6", "mor": "2", "noon": "2", "night": "2"},
  };
  var Prescription = ['Prescription', 'BF', 'AF'];
  List treatmentList = [];
  List testList = [];
  List medicineList = [];
  List table_list = [];
  double fees_total = 0;
  var accesstoken;
  bool isloading = false;
  @override
  void initState() {
    super.initState();
    accesstoken = storage.getItem('userResponse')['access_token'];
    getpatientlist();
    gettreatmentlist();
    grandtotalController.text = grand_total.toString();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height - 50;
    double screenWidth = MediaQuery.of(context).size.width;
    return new WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Dash()),
        );
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // resizeToAvoidBottomInset: false,
        // resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Color.fromARGB(255, 8, 122, 135),
            title: const Text(
              'Prescription',
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            // actions: [
            //   IconButton(
            //       onPressed: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => const Dashboardpage()),
            //         );
            //       },
            //       icon: Icon(
            //         Icons.people_alt_outlined,
            //         color: Colors.black,
            //       )),
            // ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            height: screenHeight,
            width: screenWidth,
            child: Column(
              children: [
                showAutoComplete
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                            child: renderAutoComplete(screenWidth, screenHeight)
                            //     Container(
                            //   height: screenHeight * 0.08,
                            //   width: screenWidth,
                            //   // color:Colors.amber,
                            //   child: Padding(
                            //     padding: const EdgeInsets.only(
                            //         top: 5, bottom: 5, left: 5, right: 5),
                            //     child: Container(
                            //       // height: screenHeight * 0.06,
                            //       width: screenWidth,
                            //       decoration: BoxDecoration(
                            //           color: Colors.white,
                            //           border: Border.all(
                            //               color: Color.fromARGB(255, 8, 122, 135)),
                            //           borderRadius: BorderRadius.all(Radius.circular(1))),
                            //       child: Row(
                            //         children: [
                            //           Container(
                            //               width: screenWidth * 0.1,
                            //               height: screenHeight,
                            //               child: Icon(Icons.search,
                            //                   color: Color.fromARGB(255, 8, 122, 135))),
                            //           Container(
                            //             width: screenWidth * 0.7,
                            //             child: TextField(
                            //               controller: searchText,
                            //               onChanged: (text) {
                            //                 renderAutoComplete(screenWidth, screenHeight);
                            //                 print(text);

                            //                 this.setState(() {});

                            //                 // searchList = StaffList.where((element) {
                            //                 //   var List =
                            //                 //       element['name'].toString().toLowerCase();
                            //                 //   return List.contains(text.toLowerCase());
                            //                 //   // return true;
                            //                 // }).toList();
                            //                 // this.setState(() {});
                            //               },
                            //               decoration: new InputDecoration(
                            //                 filled: true,
                            //                 border: InputBorder.none,
                            //                 fillColor: Colors.white,
                            //                 hintText: 'Search Patient list...',
                            //               ),
                            //             ),
                            //           ),
                            //           searchText.text.isNotEmpty
                            //               ? Container(
                            //                   width: screenWidth * 0.1,
                            //                   height: screenHeight,
                            //                   child: IconButton(
                            //                     icon: Icon(
                            //                       Icons.close,
                            //                       color: Colors.red,
                            //                     ),
                            //                     onPressed: () {
                            //                       setState(() {
                            //                         searchText.text = '';
                            //                         searchList = '';
                            //                       });
                            //                     },
                            //                   ))
                            //               : Container(),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // )
                            ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            child: Column(
                          children: [
                            Card(
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Icon(Icons.people,
                                        color:
                                            Color.fromARGB(255, 8, 122, 135)),
                                    Text(
                                      '     ${selectedPatient['customer_name'].toString()}',
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                    '             ${selectedPatient['phone'].toString()}'),
                                trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedPatient = null;
                                      showAutoComplete = true;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            // ListTile(title: Text('Test name'),
                            // trailing: IconButton(onPressed: (){} ,icon: Icon(Icons.add)),),
                          ],
                        )),
                      ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          child: Container(
                            width: screenWidth * 0.2,
                            height: screenHeight * 0.05,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.white),
                              color: select_button == "treatment"
                                  ? Colors.blue
                                  : Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                                child: Text(
                              "Treatment",
                              style: TextStyle(
                                  color: select_button == "treatment"
                                      ? Colors.white
                                      : Colors.blue,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                          onTap: () {
                            this.setState(() {
                              select_button = "treatment";
                              // billList();
                            });
                          },
                        ),
                        InkWell(
                          child: Container(
                            width: screenWidth * 0.2,
                            height: screenHeight * 0.05,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.white),
                              color: select_button == "test"
                                  ? Colors.blue
                                  : Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                                child: Text(
                              "TEST",
                              style: TextStyle(
                                  color: select_button == "test"
                                      ? Colors.white
                                      : Colors.blue,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                          onTap: () {
                            this.setState(() {
                              select_button = "test";
                              click_button = "lab";
                              getMediAndLabNameList();
                              // billList();
                            });
                          },
                        ),
                        InkWell(
                          child: Container(
                            width: screenWidth * 0.2,
                            height: screenHeight * 0.05,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.white),
                              color: select_button == "medicine"
                                  ? Colors.blue
                                  : Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                                child: Text(
                              "Medicine",
                              style: TextStyle(
                                  color: select_button == "medicine"
                                      ? Colors.white
                                      : Colors.blue,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                          onTap: () {
                            getMedicineList();
                            this.setState(() {
                              select_button = "medicine";
                              click_button = 'pharmacy';
                              getMediAndLabNameList();
                              // getMedicineList();
                              // billList();
                            });
                          },
                        ),
                        InkWell(
                          child: Container(
                            width: screenWidth * 0.2,
                            height: screenHeight * 0.05,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.white),
                              color: select_button == "injection"
                                  ? Colors.blue
                                  : Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                                child: Text(
                              "Injection",
                              style: TextStyle(
                                  color: select_button == "injection"
                                      ? Colors.white
                                      : Colors.blue,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                          onTap: () {
                            this.setState(() {
                              select_button = "injection";
                              // billList();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                select_button == "treatment"
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.65,
                          child: SingleChildScrollView(
                            physics: ScrollPhysics(),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    height: screenHeight * 0.08,
                                    width: screenWidth,
                                    // color:Colors.amber,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5, left: 0, right: 0),
                                      child: Container(
                                        // height: screenHeight * 0.06,
                                        width: screenWidth,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            // border: Border.all(
                                            //     color: Color.fromARGB(255, 12, 12, 12)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Container(
                                            //     width: screenWidth * 0.1,
                                            //     height: screenHeight,
                                            //     child: Icon(Icons.search,
                                            //         color: Color.fromARGB(255, 8, 122, 135))),
                                            Container(
                                              width: screenWidth * 0.7,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                child: Helper().isvalidElement(
                                                            TreatmentList) &&
                                                        TreatmentList.length > 0
                                                    ? DropdownButtonFormField(
                                                        // validator: (value) => validateDrops(value),
                                                        // decoration: InputDecoration(
                                                        //     enabledBorder: InputBorder.none,
                                                        //     border: UnderlineInputBorder(
                                                        //         borderSide: BorderSide(
                                                        //             color: Colors.white))),
                                                        // decoration:
                                                        //     InputDecoration.collapsed(
                                                        //         hintText: ''),
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText:
                                                              'Treatment',
                                                          border:
                                                              OutlineInputBorder(),
                                                          //icon: Icon(Icons.numbers),
                                                        ),
                                                        isExpanded: true,
                                                        hint: Text(
                                                          'Select Treatment',
                                                        ),
                                                        // value:patternDropdownvalue,
                                                        onChanged:
                                                            (item) async {
                                                          treatmentDropdownvalue =
                                                              item.toString();
                                                          var data = item
                                                              .toString()
                                                              .split('&*');
                                                          fees.text = data[0];
                                                          treatmentname =
                                                              data[1];
                                                        },
                                                        items: TreatmentList.map<
                                                            DropdownMenuItem<
                                                                String>>((item) {
                                                          return DropdownMenuItem(
                                                            child: Text(
                                                              item['treatment_name']
                                                                  .toString(),
                                                            ),
                                                            value: item['fees']
                                                                    .toString() +
                                                                '&*' +
                                                                item['treatment_name']
                                                                    .toString(),
                                                          );
                                                        }).toList(),
                                                      )
                                                    : DropdownButtonFormField(
                                                        // validator: (value) => validateDrops(value),
                                                        // isExpanded: true,
                                                        hint: Text(
                                                            'Select Treatment'),
                                                        // value:' _selectedState[i]',
                                                        onChanged: (Pharmacy) {
                                                          setState(() {});
                                                        },
                                                        items: [].map<
                                                            DropdownMenuItem<
                                                                String>>((item) {
                                                          return new DropdownMenuItem(
                                                            child: new Text(''),
                                                            value: '',
                                                          );
                                                        }).toList(),
                                                      ),
                                              ),
                                            ),
                                            Container(
                                                width: screenWidth * 0.1,
                                                height: screenHeight,
                                                color: Colors.grey,
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.add,
                                                    color: Colors.black,
                                                  ),
                                                  onPressed: () {
                                                    // setState(() {
                                                    //   searchText.text = '';
                                                    //   searchList = '';
                                                    // });
                                                    // child:
                                                    // showModalBottomSheet(
                                                    //     context: context,
                                                    //     isScrollControlled: true,
                                                    //     shape: const RoundedRectangleBorder(
                                                    //       borderRadius: BorderRadius.only(
                                                    //         topRight: Radius.circular(25.0),
                                                    //         topLeft: Radius.circular(25.0),
                                                    //       ),
                                                    //     ),
                                                    //     builder: (context) {
                                                    //       return SizedBox(
                                                    //         height: 300,
                                                    //         width: MediaQuery.of(context)
                                                    //             .size
                                                    //             .width,
                                                    //         child: const Center(
                                                    //           child: Text(
                                                    //             "Flutter Frontend",
                                                    //             style: TextStyle(
                                                    //               color: Colors.black,
                                                    //               fontSize: 25,
                                                    //               fontWeight: FontWeight.bold,
                                                    //             ),
                                                    //           ),
                                                    //         ),
                                                    //       );
                                                    //     });
                                                  },
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 180,
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              labelText: 'Fees',
                                              border: OutlineInputBorder(),
                                              // icon: Icon(Icons.numbers),
                                            ),
                                            controller: fees,
                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                                    decimal: true),
                                          ),
                                        ),
                                        SizedBox(
                                          // width: 100,
                                          child: TextButton(
                                              onPressed: () {
                                                if (treatmentname.isEmpty) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'pls select treatment',
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 2,
                                                      backgroundColor:
                                                          Colors.red,
                                                      textColor: Colors.white,
                                                      fontSize: 15.0);
                                                } else {
                                                  var data = {
                                                    "treatment": treatmentname
                                                        .toString(),
                                                    "fees":
                                                        fees.text.toString(),
                                                  };
                                                  // print(data);
                                                  print(data);
                                                  print(treatmentList);

//                                                 print(treatmentList
//                                                     .contains(data));
//                                                     if(treatmentList.every((data) => data != null)){
//                                                       print(data);
//                                                   treatmentList.add(data);

//                                                     }else{
// print('data');
//                                                     }
                                                  if (treatmentList
                                                      .contains(data)) {
                                                    treatmentList.remove(data);
                                                  } else {
                                                    treatmentList.add(data);
                                                    totalCalcution();
                                                    // fees_total=0;

                                                    // for (var value
                                                    //     in treatmentList) {
                                                    //   fees_total = fees_total +
                                                    //       double.parse(
                                                    //           value['fees']);

                                                    // }
                                                  }
                                                  print(treatmentList);
                                                  gettreatmentlist();

                                                  setState(() {
                                                    TreatmentList = null;
                                                    fees.clear();
                                                  });
                                                  setState(() {
                                                    gettreatmentlist();
                                                  });
                                                }
                                              },
                                              child: Text(
                                                "ADD TREATMENT",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Color.fromARGB(
                                                              255, 10, 132, 87)),
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(4.0),
                                                          side: BorderSide(color: Colors.blue))))),
                                          // TextFormField(
                                          //   decoration: const InputDecoration(
                                          //     labelText: 'Clinic Notes',
                                          //     border: OutlineInputBorder(),
                                          //     //icon: Icon(Icons.numbers),
                                          //   ),
                                          //   // controller: addressController,
                                          // ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Helper().isvalidElement(treatmentList) &&
                                        treatmentList.length > 0
                                    ? Container(
                                        width: screenWidth,
                                        child: Text(
                                          '  Treatment List :',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      )
                                    : Container(),
                                Container(
                                    padding: const EdgeInsets.all(5),
                                    // height: screenHeight * 0.6,
                                    width: screenWidth,
                                    child: Helper()
                                            .isvalidElement(treatmentList)
                                        ? ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: treatmentList.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final data = treatmentList[index];
                                              return Container(
                                                  child: Column(
                                                children: [
                                                  Card(
                                                    child: ListTile(
                                                      title: Text(
                                                        '${data['treatment'].toString()}',
                                                      ),
                                                      subtitle: Text(
                                                          '${"₹ " + data['fees'].toString()}'),
                                                      trailing: IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            treatmentList
                                                                .remove(data);
                                                            totalCalcution();
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons.close,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  // ListTile(title: Text('Test name'),
                                                  // trailing: IconButton(onPressed: (){} ,icon: Icon(Icons.add)),),
                                                  Divider(
                                                    height: 0.1,
                                                  )
                                                ],
                                              ));
                                            })
                                        : Container()),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
                select_button == "test"
                    ? Container(
                        height: screenHeight * 0.7,
                        child: SingleChildScrollView(
                          physics: ScrollPhysics(),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: screenWidth,
                                  child: Column(
                                    children: [
                                      click_button == 'lab' &&
                                              labshowAutoComplete
                                          ? renderLablistAutoComplete(
                                              screenWidth, screenHeight)
                                          : SizedBox(
                                              // width: 180,
                                              child: TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Lab Name',
                                                  border: OutlineInputBorder(),
                                                  // icon: Icon(Icons.numbers),
                                                ),
                                                controller: labnameController,
                                                onChanged: (text) {
                                                  setState(() {
                                                    labnameController
                                                            .text.isEmpty
                                                        ? labshowAutoComplete =
                                                            true
                                                        : labshowAutoComplete =
                                                            false;
                                                    testshowAutoComplete =
                                                        false;
                                                    // labnameController.text.isEmpty? SelectedLab='':labshowAutoComplete=false;
                                                    // TestList=null;
                                                    // getLabtestNameList();
                                                  });
                                                },
                                                // keyboardType: TextInputType.numberWithOptions(decimal: true),
                                              ),
                                            ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      testshowAutoComplete
                                          ? rendertestlistAutoComplete(
                                              screenWidth, screenHeight)
                                          : SizedBox(
                                              // width: 180,
                                              child: TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Test Name',
                                                  border: OutlineInputBorder(),
                                                  // icon: Icon(Icons.numbers),
                                                ),
                                                controller: testnameController,
                                                onChanged: (text) {
                                                  setState(() {
                                                    testnameController
                                                            .text.isEmpty
                                                        ? testshowAutoComplete =
                                                            true
                                                        : testshowAutoComplete =
                                                            false;
                                                  });

                                                  // getLabtestNameList();
                                                },

                                                // keyboardType: TextInputType.numberWithOptions(decimal: true),
                                              ),
                                            ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      SizedBox(
                                        width: screenWidth,
                                        child: TextButton(
                                            onPressed: () async {
                                              if (labnameController
                                                  .text.isEmpty) {
                                                Fluttertoast.showToast(
                                                    msg: 'pls select Lab',
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 2,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 15.0);
                                              } else if (testnameController
                                                  .text.isEmpty) {
                                                Fluttertoast.showToast(
                                                    msg: 'pls select testlist',
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 2,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 15.0);
                                              } else {
                                                var test = {
                                                  "lab_name": labnameController
                                                      .text
                                                      .toString(),
                                                  "test_name":
                                                      testnameController.text
                                                          .toString(),
                                                };
                                                print(test);
                                                print(test);
                                                print(testList);
                                                print(testList.contains(test));
                                                if (testList.contains(test)) {
                                                  testList.remove(test);
                                                } else {
                                                  testList.add(test);
                                                }
                                                print(testList);
                                                setState(() {
                                                  labshowAutoComplete = true;
                                                  testshowAutoComplete = false;
                                                  labnameController.clear();
                                                  testnameController.clear();
                                                });
                                              }
                                            },
                                            child: Text(
                                              "ADD TEST",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<Color>(
                                                        Color.fromARGB(
                                                            255, 10, 132, 87)),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                4.0),
                                                        side: BorderSide(color: Colors.blue))))),
                                        // TextFormField(
                                        //   decoration: const InputDecoration(
                                        //     labelText: 'Clinic Notes',
                                        //     border: OutlineInputBorder(),
                                        //     //icon: Icon(Icons.numbers),
                                        //   ),
                                        //   // controller: addressController,
                                        // ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Helper().isvalidElement(testList) &&
                                      select_button == 'test' &&
                                      testList.length > 0
                                  ? Container(
                                      width: screenWidth,
                                      child: Text(
                                        '  Test List :',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    )
                                  : Container(),
                              Container(
                                  padding: const EdgeInsets.all(5),
                                  // height: screenHeight * 0.6,
                                  width: screenWidth,
                                  child: Helper().isvalidElement(testList) &&
                                          select_button == 'test'
                                      ? ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: testList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final data = testList[index];
                                            return Container(
                                                child: Column(
                                              children: [
                                                Card(
                                                  child: ListTile(
                                                    title: Text(
                                                      'Lab Name: ${data['lab_name'].toString()}',
                                                    ),
                                                    subtitle: Text(
                                                        'Test Name: ${data['test_name'].toString()}'),
                                                    trailing: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          testList.remove(data);
                                                        });
                                                      },
                                                      icon: Icon(
                                                        Icons.close,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // ListTile(title: Text('Test name'),
                                                // trailing: IconButton(onPressed: (){} ,icon: Icon(Icons.add)),),
                                                // Divider(
                                                //   height: 0.1,
                                                // )
                                              ],
                                            ));
                                          })
                                      : Container()),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                select_button == "medicine"
                    ? Container(
                        height: screenHeight * 0.75,
                        child: SingleChildScrollView(
                          physics: ClampingScrollPhysics(),
                          //  reverse: true,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    child: Column(
                                  children: [
                                    pharmacyshowAutoComplete
                                        ? renderpharmacylistAutoComplete(
                                            screenWidth, screenHeight)
                                        : SizedBox(
                                            width: screenWidth,
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                labelText: 'Pharmacy Name',
                                                border: OutlineInputBorder(),
                                                // icon: Icon(Icons.numbers),
                                              ),
                                              controller: pharmacyController,
                                              onChanged: (text) {
                                                setState(() {
                                                  pharmacyController
                                                          .text.isEmpty
                                                      ? pharmacyshowAutoComplete =
                                                          true
                                                      : pharmacyshowAutoComplete =
                                                          false;
                                                });
                                              },
                                              // keyboardType: TextInputType.numberWithOptions(decimal: true),
                                            ),
                                          ),
                                    SizedBox(height: 5),
                                    medicineshowAutoComplete
                                        ? rendermedicinelistAutoComplete(
                                            screenWidth, screenHeight)
                                        : SizedBox(
                                            width: screenWidth,
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                labelText: 'Medicine Name',
                                                border: OutlineInputBorder(),
                                                // icon: Icon(Icons.numbers),
                                              ),
                                              controller: medicineController,
                                              onChanged: (text) {
                                                setState(() {
                                                  medicineController
                                                          .text.isEmpty
                                                      ? medicineshowAutoComplete =
                                                          true
                                                      : medicineshowAutoComplete =
                                                          false;
                                                });
                                              },
                                              // keyboardType: TextInputType.numberWithOptions(decimal: true),
                                            ),
                                          ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: screenWidth * 0.455,
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              labelText: 'Price',
                                              border: OutlineInputBorder(),
                                              // icon: Icon(Icons.numbers),
                                            ),
                                            controller: priceController,
                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                                    decimal: true),
                                          ),
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.455,
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              labelText: 'Day',
                                              border: OutlineInputBorder(),
                                              // icon: Icon(Icons.numbers),
                                            ),
                                            controller: dayController,
                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                                    decimal: true),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: screenWidth * 0.455,
                                          child: DropdownButtonFormField(
                                            // validator: (value) => validateDrops(value),
                                            // decoration: InputDecoration(
                                            //     enabledBorder: InputBorder.none,
                                            //     border: UnderlineInputBorder(
                                            //         borderSide: BorderSide(
                                            //             color: Colors.white))),
                                            // decoration:
                                            //     InputDecoration.collapsed(
                                            //         hintText: ''),
                                            decoration: const InputDecoration(
                                              labelText: 'Pattern',
                                              border: OutlineInputBorder(),
                                              //icon: Icon(Icons.numbers),
                                            ),
                                            isExpanded: true,
                                            hint: Text(
                                              'Select Pattern',
                                            ),
                                            // value:patternDropdownvalue,
                                            onChanged: (item) async {
                                              patternDropdownvalue =
                                                  item.toString();
                                              var data =
                                                  item.toString().split('&*');
                                              count = data[0];
                                              mor = data[2];
                                              noon = data[3];
                                              night = data[4];
                                              // selectedPharmacyDetails =
                                              //     item.toString().split('&*');
                                              // data = {
                                              //   'mobile_no': storage
                                              //       .getItem('user_mobileno'),
                                              //   'shop_id':
                                              //       selectedPharmacyDetails[0]
                                              // };
                                              // setState(() {
                                              //   selectedList = null;
                                              // });
                                              // await getcustomerlist(data);
                                              // setState(() {
                                              //     pharmacyDropdownvalue = item;
                                              // });
                                              // data = {
                                              //   'mobile_no': storage
                                              //       .getItem('user_mobileno'),
                                              //   'shop_id': item
                                              // };
                                              // await getcustomerlist(data);
                                              // setState(() {
                                              //   // customerdropdown='';
                                              // });
                                            },
                                            items: demo
                                                .map<DropdownMenuItem<String>>(
                                                    (item) {
                                              return DropdownMenuItem(
                                                child: Text(
                                                  item['name'].toString(),
                                                ),
                                                value: item['value']
                                                        .toString() +
                                                    '&*' +
                                                    item['name'].toString() +
                                                    '&*' +
                                                    item['mor'].toString() +
                                                    '&*' +
                                                    item['noon'].toString() +
                                                    '&*' +
                                                    item['night'].toString() +
                                                    '&*',
                                              );
                                            }).toList(),
                                          ),
                                          // child: DropdownButtonFormField(
                                          //   // value: patternDropdownvalue,
                                          //   // autovalidateMode: AutovalidateMode.always,
                                          //   // validator: (value) {
                                          //   //   if (value == null ||
                                          //   //       value.isEmpty ||
                                          //   //       value == "Title") {
                                          //   //     return 'please select Title';
                                          //   //   }
                                          //   //   return null;
                                          //   // },
                                          //   decoration: const InputDecoration(
                                          //     labelText: 'Prescription',
                                          //     border: OutlineInputBorder(),
                                          //     //icon: Icon(Icons.numbers),
                                          //   ),
                                          //   items: demo.map((String items) {
                                          //     return DropdownMenuItem(
                                          //       value: items['value'],
                                          //       child: Text(items['name']),
                                          //     );
                                          //   }).toList(),
                                          //   onChanged: (String? newValue) {
                                          //     setState(() {
                                          //       patternDropdownvalue = newValue!;
                                          //     });
                                          //   },
                                          // ),
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.455,
                                          child: DropdownButtonFormField(
                                            value: prescriptionDropdownvalue,
                                            autovalidateMode:
                                                AutovalidateMode.always,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty ||
                                                  value == "Title") {
                                                return 'please select Title';
                                              }
                                              return null;
                                            },
                                            decoration: const InputDecoration(
                                              labelText: 'Prescription',
                                              border: OutlineInputBorder(),
                                              //icon: Icon(Icons.numbers),
                                            ),
                                            items: Prescription.map(
                                                (String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                prescriptionDropdownvalue =
                                                    newValue!;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 180,
                                          child: TextButton(
                                              onPressed: () async {
                                                // var data = {
                                                //   "treatment": titleDropdownvalue.toString(),
                                                //   "fees": fees.text.toString(),
                                                // };
                                                // print(data);
                                                // print(data);
                                                // print(treatmentList);
                                                // print(treatmentList.contains(data));
                                                // if (treatmentList.contains(data)) {
                                                //   treatmentList.remove(data);
                                                // } else {
                                                //   treatmentList.add(data);
                                                // }
                                                // print(treatmentList);
                                                // setState(() {
                                                //   fees.clear();
                                                //   titleDropdownvalue = 'Select Treatment';
                                                // });
                                              },
                                              child: Text(
                                                "Add Command",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Color.fromARGB(
                                                              255, 10, 132, 87)),
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(4.0),
                                                          side: BorderSide(color: Colors.blue))))),
                                        ),
                                        SizedBox(
                                          width: 180,
                                          child: TextButton(
                                              onPressed: () async {
                                                if (pharmacyController
                                                    .text.isEmpty) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'pls select pharmacy',
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 2,
                                                      backgroundColor:
                                                          Colors.red,
                                                      textColor: Colors.white,
                                                      fontSize: 15.0);
                                                } else if (medicineController
                                                    .text.isEmpty) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'pls select medicine',
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 2,
                                                      backgroundColor:
                                                          Colors.red,
                                                      textColor: Colors.white,
                                                      fontSize: 15.0);
                                                } else if (priceController
                                                    .text.isEmpty) {
                                                  Fluttertoast.showToast(
                                                      msg: 'pls select price',
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 2,
                                                      backgroundColor:
                                                          Colors.red,
                                                      textColor: Colors.white,
                                                      fontSize: 15.0);
                                                } else if (dayController
                                                    .text.isEmpty) {
                                                  Fluttertoast.showToast(
                                                      msg: 'pls select days',
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 2,
                                                      backgroundColor:
                                                          Colors.red,
                                                      textColor: Colors.white,
                                                      fontSize: 15.0);
                                                } else if (patternDropdownvalue
                                                        .isEmpty ||
                                                    patternDropdownvalue ==
                                                        'pattern') {
                                                  Fluttertoast.showToast(
                                                      msg: 'pls select pattern',
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 2,
                                                      backgroundColor:
                                                          Colors.red,
                                                      textColor: Colors.white,
                                                      fontSize: 15.0);
                                                } else if (prescriptionDropdownvalue
                                                    .isEmpty) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'pls select prescription',
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 2,
                                                      backgroundColor:
                                                          Colors.red,
                                                      textColor: Colors.white,
                                                      fontSize: 15.0);
                                                } else {
                                                  tableCalCulation();
                                                  // total = 0.0;
                                                  // var price = double.parse(
                                                  //     priceController.text);
                                                  // var day = double.parse(
                                                  //     dayController.text);
                                                  // var number =
                                                  //     double.parse(count);
                                                  // setState(() {
                                                  //   total =
                                                  //       (number * price) * day;
                                                  //   // cal={
                                                  //   //   "total":total.toString(),
                                                  //   // };
                                                  // });
                                                  var data = {
                                                    "medicine":
                                                        medicineController.text
                                                            .toString(),
                                                    "price": priceController
                                                        .text
                                                        .toString(),
                                                    "day": dayController.text
                                                        .toString(),
                                                    "pattern":
                                                        patternDropdownvalue
                                                            .toString(),
                                                    "mor": mor.toString(),
                                                    "noon": noon.toString(),
                                                    "night": night.toString(),
                                                    "total_qty":
                                                        count.toString(),
                                                    "prescription":
                                                        prescriptionDropdownvalue
                                                            .toString(),
                                                    "total": total.toString(),
                                                    // "Test":testList,
                                                    // "Treatment":treatmentList,
                                                    // "List":Map.from(treatmentList as Map),
                                                  };
                                                  print(data);
                                                  print(medicineList);
                                                  print(medicineList
                                                      .contains(data));
                                                  if (table_list
                                                      .contains(data)) {
                                                    table_list.remove(data);
                                                  } else {
                                                    table_list.add(data);
                                                    totalCalcution();
                                                    // grand_total=0;

                                                    // for (var value
                                                    //     in table_list) {
                                                    //   grand_total = grand_total +fees_total+
                                                    //       double.parse(
                                                    //           value['total']);
                                                    // }
                                                    // // return grand_total;
                                                    // grandtotalController.text=grand_total.toString();
                                                    //  medicineList.addAll(cal);
                                                    // tableCalCulation();
                                                    //  medicineList.addAll(treatmentList);
                                                    // //  medicineList.asMap()
                                                  }
                                                  print(table_list);
                                                  setState(() {
                                                    medicineshowAutoComplete =
                                                        true;

                                                    medicineController.clear();
                                                    priceController.clear();
                                                    dayController.clear();
                                                    patternDropdownvalue =
                                                        'null';
                                                    prescriptionDropdownvalue =
                                                        'Prescription';
                                                  });
                                                }
                                              },
                                              child: Text(
                                                "Add",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Color.fromARGB(
                                                              255, 10, 132, 87)),
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(4.0),
                                                          side: BorderSide(color: Colors.blue))))),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                )),
                              ),
                              Helper().isvalidElement(table_list) &&
                                      table_list.length > 0
                                  ? Container(
                                      padding: const EdgeInsets.all(5),
                                      // height: screenHeight * 0.6,
                                      width: screenWidth,
                                      child: ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: table_list.length,
                                          // itemCount: testList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final data = table_list[index];
                                            return Container(
                                              child: Card(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                              screenWidth * 0.6,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'Medicine :',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        13),
                                                              ),
                                                              Text(
                                                                "${data['medicine'].toString().length < 20 ? data['medicine'].toString() : data['medicine'].toString().substring(0, 19)}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Days : ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 13),
                                                            ),
                                                            Text(
                                                              "${data['day'].toString()}",
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'BF/AF: ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 13),
                                                            ),
                                                            Text(
                                                              "${data['prescription'].toString()}",
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Mor:',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 13),
                                                            ),
                                                            Text(
                                                              "${data['mor'].toString()}",
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Noon: ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 13),
                                                            ),
                                                            Text(
                                                              "${data['noon'].toString()} ",
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Night: ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 13),
                                                            ),
                                                            Text(
                                                              "${data['night'].toString()} ",
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Total Qty: ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 13),
                                                            ),
                                                            Text(
                                                              "${data['total_qty'].toString()}",
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Price: ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 13),
                                                            ),
                                                            Text(
                                                              "${data['price'].toString()} ",
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Total: ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 13),
                                                            ),
                                                            Text(
                                                              "${data['total'].toString()} ",
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    // Card(
                                                    //   child: ListTile(
                                                    //     title: Text(
                                                    //       'Lab Name: ${data['lab_name'].toString()}',
                                                    //     ),
                                                    //     subtitle: Text(
                                                    //         'Test Name: ${data['test_name'].toString()}'),
                                                    //     trailing: IconButton(
                                                    //       onPressed: () {
                                                    //         setState(() {
                                                    //           testList.remove(data);
                                                    //         });
                                                    //       },
                                                    //       icon: Icon(
                                                    //         Icons.close,
                                                    //         color: Colors.red,
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    // ListTile(title: Text('Test name'),
                                                    // trailing: IconButton(onPressed: (){} ,icon: Icon(Icons.add)),),
                                                  ],
                                                ),
                                              )),
                                            );
                                          }),
                                    )
                                  : Container(),
                              //  Container(height: screenHeight*0.5,),
                              SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.455,
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          labelText: 'Discount',
                                          border: OutlineInputBorder(),
                                          // icon: Icon(Icons.numbers),
                                        ),
                                        controller: discountController,
                                        onChanged: (text) {
                                          totalCalcution();
                                          // double finaldiscountvalue =
                                          //     discountController.text.isNotEmpty
                                          //         ? double.parse(
                                          //             discountController.text)
                                          //         : 0.0;
                                          // // var finaldiscountvalue = double.parse(
                                          //     // discountController.text);
                                          // // balanceController.text=grand_total.toString();
                                          // balance=grand_total-finaldiscountvalue;
                                          //  balanceController.text=balance.toString();
                                        },
                                        // autofocus: true,
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.455,
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          labelText: 'Grant Total',
                                          border: OutlineInputBorder(),
                                          // icon: Icon(Icons.numbers),
                                        ),
                                        controller: grandtotalController,
                                        // grandtotalController=
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Column(
                                    children: [
                                      //   ],),
                                      // )
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.455,
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                labelText: 'Recieved',
                                                border: OutlineInputBorder(),
                                                // icon: Icon(Icons.numbers),
                                              ),
                                              controller: receivedController,
                                              onChanged: (text) {
                                                totalCalcution();
                                              },
                                              // autofocus: true,
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      decimal: true),
                                            ),
                                          ),
                                          SizedBox(
                                            width: screenWidth * 0.455,
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                labelText: 'Balance',
                                                border: OutlineInputBorder(),
                                                // icon: Icon(Icons.numbers),
                                              ),
                                              controller: balanceController,
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      decimal: true),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.455,
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                labelText: 'Change',
                                                border: OutlineInputBorder(),
                                                // icon: Icon(Icons.numbers),
                                              ),
                                              controller: changeController,
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      decimal: true),
                                            ),
                                          ),
                                          //   SizedBox(
                                          //   width:  screenWidth*0.455,
                                          //   child: TextFormField(
                                          //     decoration: const InputDecoration(
                                          //       labelText: 'Day',
                                          //       border: OutlineInputBorder(),
                                          //       // icon: Icon(Icons.numbers),
                                          //     ),
                                          //     controller: dayController,
                                          //     keyboardType: TextInputType.numberWithOptions(decimal: true),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Container(
                                        width: screenWidth,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextButton(
                                              onPressed: () async {
                                                // var data = {
                                                //   "treatment": titleDropdownvalue.toString(),
                                                //   "fees": fees.text.toString(),
                                                // };
                                                // print(data);
                                                // print(data);
                                                // print(treatmentList);
                                                // print(treatmentList.contains(data));
                                                // if (treatmentList.contains(data)) {
                                                //   treatmentList.remove(data);
                                                // } else {
                                                //   treatmentList.add(data);
                                                // }
                                                // print(treatmentList);
                                                // setState(() {
                                                //   fees.clear();
                                                //   titleDropdownvalue = 'Select Treatment';
                                                // });
                                              },
                                              child: Text(
                                                "Prescription",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Color.fromARGB(
                                                              255, 10, 132, 87)),
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(4.0),
                                                          side: BorderSide(color: Colors.blue))))),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  tableCalCulation() {
    total = 0.0;
    var price = double.parse(priceController.text);
    var day = double.parse(dayController.text);
    var number = double.parse(count);
    setState(() {
      total = (number * price) * day;
      // cal={
      //   "total":total.toString(),
      // };
    });
  }

  totalCalcution() {
    //treatment
    fees_total = 0;
    for (var value in treatmentList) {
      fees_total = fees_total + double.parse(value['fees']);
    }
    //discount
    double finaldiscountvalue = discountController.text.isNotEmpty
        ? double.parse(discountController.text)
        : 0.0;
    //recieved
    double recieved = receivedController.text.isNotEmpty
        ? double.parse(receivedController.text)
        : 0.0;
    //change
    double change = changeController.text.isNotEmpty
        ? double.parse(changeController.text)
        : 0.0;
    // var finaldiscountvalue = double.parse(
    // discountController.text);
    // balanceController.text=grand_total.toString();

    //grand total
    grand_total = 0;
    if (table_list.length > 0) {
      for (var value in table_list) {
        grand_total = grand_total + fees_total + double.parse(value['total']);
      }
    } else {
      grand_total = grand_total + fees_total;
    }
    // return grand_total;
    grandtotalController.text = grand_total.toString();
    //balance
    balance = grand_total - finaldiscountvalue;
    balanceController.text = balance.toString();
  }

  getpatientlist() async {
    this.setState(() {
      isloading = true;
    });
    var list = await PatientApi().getpatientlist(accesstoken);
    if (Helper().isvalidElement(list) &&
        Helper().isvalidElement(list['status']) &&
        list['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      PatientList = list['Customer_list'];
      //  storage.setItem('diagnosisList', diagnosisList);
      this.setState(() {
        isloading = false;
      });
    }
  }

  gettreatmentlist() async {
    var List = await PatientApi().gettreatmentlist(accesstoken);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        TreatmentList = List['list'];
      });
      // TreatmentList = List['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
    }
  }

  getMediAndLabNameList() async {
    var data = {
      "type": click_button.toString(),
    };
    var List = await PatientApi().getMediAndLabNameList(accesstoken, data);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        MediAndLabNameList = List['list'];
        var values = MediAndLabNameList;
      });
      // TreatmentList = List['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
    }
  }

  getLabtestNameList() async {
    var data = {
      "shop_id": SelectedLab['shop_id'].toString(),
    };

    var List = await PatientApi().getLabtestList(accesstoken, data);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        //  MediAndLabNameList = List['list'];
        TestList = List['list'];
      });
      // TreatmentList = List['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
    }
  }

  getMedicineList() async {
    var data = {
      "shop_id": Helper().isvalidElement(SelectedPharmacy['shop_id'])
          ? SelectedPharmacy['shop_id'].toString()
          : '',
    };

    var List = await PatientApi().getmedicineList(accesstoken, data);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        //  MediAndLabNameList = List['list'];
        MedicineList = List['list'];
      });
      // TreatmentList = List['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
    }
  }

  renderAutoComplete(screenWidth, screenHeight) {
    return Autocomplete<List>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<List>.empty();
        } else {
          var matches = [];
          matches.addAll(PatientList);
          matches.retainWhere((s) {
            return s['customer_name']
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
          this.setState(() {});
          return [matches];
        }
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
            controller: textEditingController,
            focusNode: focusNode,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                // prefix: Icon(Icons.search),
                prefixIcon: Icon(Icons.search),
                hintText: ' Search Patient Name'),
            onFieldSubmitted: (String value) {
              onFieldSubmitted();
            });
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<List> onSelected, Iterable<List> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            child: Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.8,
              color: Colors.white,
              child: ListView.builder(
                padding: EdgeInsets.all(5.0),
                itemCount: options.toList()[0].length,
                itemBuilder: (BuildContext context, int index) {
                  final option = options.toList()[0].elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      storage.setItem(
                          'selectedPatient', options.toList()[0][index]);
                      setState(() {
                        showAutoComplete = false;
                        selectedPatient = options.toList()[0][index];
                      });
                    },
                    child: Card(
                      color: Colors.grey,
                      // color: custom_color.app_color,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${options.toList()[0][index]['customer_name'].toString()} , ${options.toList()[0][index]['phone'].toString()}',
                                style: const TextStyle(color: Colors.black)),
                          ),
                          // Divider(
                          //   thickness: 1,
                          // )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  renderLablistAutoComplete(screenWidth, screenHeight) {
    return Autocomplete<List>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<List>.empty();
        } else {
          var matches = [];
          matches.addAll(MediAndLabNameList);
          matches.retainWhere((s) {
            return s['pharmacy_name']
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
          this.setState(() {});
          return [matches];
        }
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
            controller: textEditingController,
            focusNode: focusNode,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                // prefix: Icon(Icons.search),
                prefixIcon: Icon(Icons.search),
                hintText: ' Search Lab Name'),
            onFieldSubmitted: (String value) {
              onFieldSubmitted();
            });
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<List> onSelected, Iterable<List> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            child: Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.4,
              color: Colors.white,
              child: ListView.builder(
                padding: EdgeInsets.all(5.0),
                itemCount: options.toList()[0].length,
                itemBuilder: (BuildContext context, int index) {
                  final option = options.toList()[0].elementAt(index);

                  return GestureDetector(
                    onTap: () {
                      //  storage.setItem(
                      //     'selectedPatient', options.toList()[0][index]);
                      setState(() {
                        labshowAutoComplete = false;
                        testshowAutoComplete = true;
                        SelectedLab = options.toList()[0][index];
                        labnameController.text = Helper()
                                .isvalidElement(SelectedLab['pharmacy_name'])
                            ? SelectedLab['pharmacy_name']
                            : '';
                        getLabtestNameList();
                        // getLabtestNameList();
                      });
                    },
                    child: Card(
                      color: Colors.grey,
                      // color: custom_color.app_color,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${options.toList()[0][index]['pharmacy_name'].toString()} ',
                                style: const TextStyle(color: Colors.black)),
                          ),
                          // Divider(
                          //   thickness: 1,
                          // )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  rendertestlistAutoComplete(screenWidth, screenHeight) {
    return Autocomplete<List>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<List>.empty();
        } else {
          //  getLabtestNameList();
          //  setState(() {

          //  });
          var matches = [];
          matches.addAll(TestList);
          matches.retainWhere((s) {
            return s['test_name']
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
          this.setState(() {});
          return [matches];
        }
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
            controller: textEditingController,
            focusNode: focusNode,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                // prefix: Icon(Icons.search),
                prefixIcon: Icon(Icons.search),
                hintText: ' Search Test Name'),
            onFieldSubmitted: (String value) {
              onFieldSubmitted();
            });
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<List> onSelected, Iterable<List> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            child: Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.5,
              color: Colors.white,
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(5.0),
                itemCount: options.toList()[0].length,
                itemBuilder: (BuildContext context, int index) {
                  final option = options.toList()[0].elementAt(index);

                  return GestureDetector(
                    onTap: () {
                      //  storage.setItem(
                      //     'selectedPatient', options.toList()[0][index]);
                      setState(() {
                        testshowAutoComplete = false;
                        SelectedTest = options.toList()[0][index];
                        testnameController.text =
                            Helper().isvalidElement(SelectedTest['test_name'])
                                ? SelectedTest['test_name']
                                : '';
                      });
                    },
                    child: Card(
                      color: Colors.grey,
                      // color: custom_color.app_color,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${options.toList()[0][index]['test_name'].toString()} ',
                                style: const TextStyle(color: Colors.black)),
                          ),
                          // Divider(
                          //   thickness: 1,
                          // )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  renderpharmacylistAutoComplete(screenWidth, screenHeight) {
    return Autocomplete<List>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<List>.empty();
        } else {
          var matches = [];
          matches.addAll(MediAndLabNameList);
          matches.retainWhere((s) {
            return s['pharmacy_name']
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
          this.setState(() {});
          return [matches];
        }
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
            controller: textEditingController,
            focusNode: focusNode,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                // prefix: Icon(Icons.search),
                prefixIcon: Icon(Icons.search),
                hintText: ' Search pharmacy Name'),
            onFieldSubmitted: (String value) {
              onFieldSubmitted();
            });
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<List> onSelected, Iterable<List> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            child: Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.4,
              color: Colors.white,
              child: ListView.builder(
                padding: EdgeInsets.all(5.0),
                itemCount: options.toList()[0].length,
                itemBuilder: (BuildContext context, int index) {
                  final option = options.toList()[0].elementAt(index);

                  return GestureDetector(
                    onTap: () {
                      //  storage.setItem(
                      //     'selectedPatient', options.toList()[0][index]);
                      setState(() {
                        pharmacyshowAutoComplete = false;
                        testshowAutoComplete = true;
                        SelectedPharmacy = options.toList()[0][index];
                        getMedicineList();
                        pharmacyController.text = Helper().isvalidElement(
                                SelectedPharmacy['pharmacy_name'])
                            ? SelectedPharmacy['pharmacy_name']
                            : '';
                        // getLabtestNameList();
                      });
                    },
                    child: Card(
                      color: Colors.grey,
                      // color: custom_color.app_color,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${options.toList()[0][index]['pharmacy_name'].toString()} ',
                                style: const TextStyle(color: Colors.black)),
                          ),
                          // Divider(
                          //   thickness: 1,
                          // )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  rendermedicinelistAutoComplete(screenWidth, screenHeight) {
    return Autocomplete<List>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<List>.empty();
        } else {
          var matches = [];
          matches.addAll(MedicineList);
          matches.retainWhere((s) {
            return s['name']
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
          this.setState(() {});
          return [matches];
        }
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
            controller: textEditingController,
            focusNode: focusNode,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                // prefix: Icon(Icons.search),
                prefixIcon: Icon(Icons.search),
                hintText: ' Search medicine Name'),
            onFieldSubmitted: (String value) {
              onFieldSubmitted();
            });
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<List> onSelected, Iterable<List> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            child: Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.4,
              color: Colors.white,
              child: ListView.builder(
                padding: EdgeInsets.all(5.0),
                itemCount: options.toList()[0].length,
                itemBuilder: (BuildContext context, int index) {
                  final option = options.toList()[0].elementAt(index);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        medicineshowAutoComplete = false;
                        Selectedmedicine = options.toList()[0][index];
                        // getMedicineList();
                        medicineController.text =
                            Helper().isvalidElement(Selectedmedicine['name'])
                                ? Selectedmedicine['name'].toString()
                                : '';
                        priceController.text =
                            Helper().isvalidElement(Selectedmedicine['mrp'])
                                ? Selectedmedicine['mrp'].toString()
                                : '';
                        // getLabtestNameList();
                      });
                    },
                    child: Card(
                      color: Colors.grey,
                      // color: custom_color.app_color,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${options.toList()[0][index]['name'].toString()} ',
                                style: const TextStyle(color: Colors.black)),
                          ),
                          // Divider(
                          //   thickness: 1,
                          // )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}