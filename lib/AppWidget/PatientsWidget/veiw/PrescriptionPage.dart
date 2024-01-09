import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/veiw/Dashboardpage.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:intl/intl.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;

class PrescriptionPage extends StatefulWidget {
  PrescriptionPage({super.key});
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
  TextEditingController injectionnameController = TextEditingController();
  TextEditingController doseController = TextEditingController();
  var searchList;
  var PatientList;
  String treatmentDropdownvalue = 'Select Treatment';
  String patternDropdownvalue = 'pattern';
  String prescriptionDropdownvalue = 'Select Prescription';
  String? finaldiscount = 'amount';
  var select_button = 'treatment';
  var Medicine = 'Medicine';
  var total;
  var count;
  var mor;
  var noon;
  var night;
  var cal;
  var Pattern_type;
  double grand_total = 0.0;
  double balance = 0.0;
  bool showAutoComplete = true;
  var selectedPatient;
  var TreatmentList;
  var treatmentname;
  var treatmentid;
  var click_button;
  var MediAndLabNameList;
  var SelectedLab;
  var SelectedPharmacy;
  var SelectedInjection;
  // bool isLoading=false;
  bool labshowAutoComplete = true;
  bool testshowAutoComplete = false;
  bool pharmacyshowAutoComplete = true;
  bool medicineshowAutoComplete = false;
  bool injectionshowautoComplete = true;
  bool prescriptionDD = true;
  var TestList;
  var SelectedTest;
  var MedicineList;
  var Selectedmedicine;
  var InjectionList;
  double final_grand_total = 0.0;
  var Prescription_data;

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
  final GlobalKey<FormFieldState> _patternkey = GlobalKey<FormFieldState>();

  // final GlobalObjectKey<FormFieldState<String>> emailKey =
  //     GlobalKey<FormFieldState<String>>();
  var Prescription = ['Select Prescription', 'BF', 'AF'];
  List treatmentList = [];
  List testList = [];
  List medicineList = [];
  List table_list = [];
  List injectionlist = [];
  double fees_total = 0.0;
  var accesstoken;
  bool isloading = false;
  bool medicineAdded = false;
  @override
  void initState() {
    super.initState();
    accesstoken = storage.getItem('userResponse')['access_token'];
    selectedPatient = storage.getItem('selectedcustomer');
    method();

    getpatientlist();
    gettreatmentlist();
    // grandtotalController.text = grand_total.toString();
    getInjectionList();
    medicineAdded = false;
  }
 bool pattern =false;
  method() {
    showAutoComplete = Helper().isvalidElement(selectedPatient) ? false : true;
  }

  DateTime selectedDate = DateTime.now();
  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime(2015, 8),
  //       lastDate: DateTime(2101));
  //   if (picked != null && picked != selectedDate) {
  //     setState(() {
  //       selectedDate = picked;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height - 50;
    double screenWidth = MediaQuery.of(context).size.width;
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return new WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Dash()),
        );
        storage.deleteItem('selectedcustomer');
        selectedPatient = null;
        showAutoComplete = true;
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // resizeToAvoidBottomInset: false,
        // resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            backgroundColor: custom_color.appcolor,
            title: Text(
              'Prescription',
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Dash()));
                storage.deleteItem('selectedcustomer');
                selectedPatient = null;
                showAutoComplete = true;
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            // actions: [
            //   IconButton(
            //       onPressed: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) =>  Dashboardpage()),
            //         );
            //       },
            //       icon: Icon(
            //         Icons.people_alt_outlined,
            //         color: Colors.black,
            //       )),
            // ],
          ),
        ),
        body: isloading
            ? Container(
              // color: Colors.amber,
              // height: screenHeight,
              width: screenWidth,
              child: Column(
                children: [
                  SizedBox(height: 1,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          showAutoComplete
                              ? Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Card(
                                      child: renderAutoComplete(
                                          screenWidth, screenHeight)
                                      //     Container(
                                      //   height: screenHeight * 0.08,
                                      //   width: screenWidth,
                                      //   // color:Colors.amber,
                                      //   child: Padding(
                                      //     padding:  EdgeInsets.only(
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
                                  padding: EdgeInsets.all(8.0),
                                  child: Container(
                                      child: Column(
                                    children: [
                                      Card(
                                        child: ListTile(
                                          title: Row(
                                            children: [
                                              Icon(Icons.people,
                                                  color: custom_color.appcolor),
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
                            padding: EdgeInsets.all(5.0),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    child: Container(
                                      // width: screenWidth * 0.2,
                                      height: screenHeight * 0.05,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2, color: Colors.white),
                                        color: select_button == "treatment"
                                            ? Color.fromARGB(255, 77, 93, 184)
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
                                                : Color.fromARGB(255, 77, 93, 184),
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    onTap: () {
                                      // this.setState(() {
                                      //   select_button = "treatment";
                                      //   // billList();
                                      // });
                                    },
                                  ),
                                  InkWell(
                                    child: Container(
                                      width: screenWidth * 0.2,
                                      height: screenHeight * 0.05,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2, color: Colors.white),
                                        color: select_button == "test"
                                            ? Color.fromARGB(255, 77, 93, 184)
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
                                                : Color.fromARGB(255, 77, 93, 184),
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    onTap: () {
                                      // this.setState(() {
                                      //   select_button = "test";
                                      //   click_button = "lab";
                                      //   getMediAndLabNameList();
                                      //   // billList();
                                      // });
                                    },
                                  ),
                                  InkWell(
                                    child: Container(
                                      width: screenWidth * 0.2,
                                      height: screenHeight * 0.05,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2, color: Colors.white),
                                        color: select_button == "injection"
                                            ? Color.fromARGB(255, 77, 93, 184)
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
                                                : Color.fromARGB(255, 77, 93, 184),
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    onTap: () {
                                      // this.setState(() {
                                      //   select_button = "injection";
                                      //   // billList();
                                      // });
                                    },
                                  ),
                                  InkWell(
                                    child: Container(
                                      width: screenWidth * 0.2,
                                      height: screenHeight * 0.05,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2, color: Colors.white),
                                        color: select_button == "medicine"
                                            ? Color.fromARGB(255, 77, 93, 184)
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
                                                : Color.fromARGB(255, 77, 93, 184),
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    onTap: () {
                                      // getMedicineList();
                                      // this.setState(() {
                                      //   select_button = "medicine";
                                      //   click_button = 'pharmacy';
                                      //   getMediAndLabNameList();
                                      //   getMedicineList();
                                      //   // getMedicineList();
                                      //   // billList();
                                      // });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          select_button == "treatment"
                              ? Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Container(
                                    // color: Colors.red,
                                    // height: screenHeight * 0.68,
                                    child: SingleChildScrollView(
                                      physics: ScrollPhysics(),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(3.0),
                                            child: Container(
                                              height: screenHeight * 0.08,
                                              width: screenWidth,
                                              // color:Colors.amber,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 5,
                                                    bottom: 1,
                                                    left: 0,
                                                    right: 0),
                                                child: Container(
                                                  // height: screenHeight * 0.06,
                                                  width: screenWidth,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      // border: Border.all(
                                                      //     color: Color.fromARGB(255, 12, 12, 12)),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(4))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      // Container(
                                                      //     width: screenWidth * 0.1,
                                                      //     height: screenHeight,
                                                      //     child: Icon(Icons.search,
                                                      //         color: Color.fromARGB(255, 8, 122, 135))),
                                                      Container(
                                                        width: screenWidth * 0.92,
                                                        child: Padding(
                                                          padding: EdgeInsets.only(
                                                              bottom: 0.0),
                                                          child: Helper().isvalidElement(
                                                                      TreatmentList) &&
                                                                  TreatmentList
                                                                          .length >
                                                                      0
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
                                                                      InputDecoration(
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
                                                                        .split(
                                                                            '&*');
                                                                    fees.text =
                                                                        data[0];
                                                                    treatmentname =
                                                                        data[1];
                                                                    treatmentid =
                                                                        data[2];
                                                                  },
                                                                  items: TreatmentList.map<
                                                                      DropdownMenuItem<
                                                                          String>>((item) {
                                                                    return DropdownMenuItem(
                                                                      child: Text(
                                                                        item['treatment_name']
                                                                            .toString(),
                                                                      ),
                                                                      value: item[
                                                                                  'fees']
                                                                              .toString() +
                                                                          '&*' +
                                                                          item['treatment_name']
                                                                              .toString() +
                                                                          '&*' +
                                                                          item['id']
                                                                              .toString() +
                                                                          '&*',
                                                                    );
                                                                  }).toList(),
                                                                )
                                                              : DropdownButtonFormField(
                                                                  // validator: (value) => validateDrops(value),
                                                                  // isExpanded: true,
                                                                  hint: Text(
                                                                      'Select Treatment'),
                                                                  // value:' _selectedState[i]',
                                                                  onChanged:
                                                                      (Pharmacy) {
                                                                    setState(() {});
                                                                  },
                                                                  items: [].map<
                                                                      DropdownMenuItem<
                                                                          String>>((item) {
                                                                    return new DropdownMenuItem(
                                                                      child:
                                                                          new Text(
                                                                              ''),
                                                                      value: '',
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                        ),
                                                      ),
                                                      // Container(
                                                      //     width: screenWidth * 0.1,
                                                      //     height: screenHeight,
                                                      //     color: Colors.grey,
                                                      //     child: IconButton(
                                                      //       icon: Icon(
                                                      //         Icons.add,
                                                      //         color: Colors.black,
                                                      //       ),
                                                      //       onPressed: () {
                                                      //         // setState(() {
                                                      //         //   searchText.text = '';
                                                      //         //   searchList = '';
                                                      //         // });
                                                      //         // child:
                                                      //         // showModalBottomSheet(
                                                      //         //     context: context,
                                                      //         //     isScrollControlled: true,
                                                      //         //     shape:  RoundedRectangleBorder(
                                                      //         //       borderRadius: BorderRadius.only(
                                                      //         //         topRight: Radius.circular(25.0),
                                                      //         //         topLeft: Radius.circular(25.0),
                                                      //         //       ),
                                                      //         //     ),
                                                      //         //     builder: (context) {
                                                      //         //       return SizedBox(
                                                      //         //         height: 300,
                                                      //         //         width: MediaQuery.of(context)
                                                      //         //             .size
                                                      //         //             .width,
                                                      //         //         child:  Center(
                                                      //         //           child: Text(
                                                      //         //             "Flutter Frontend",
                                                      //         //             style: TextStyle(
                                                      //         //               color: Colors.black,
                                                      //         //               fontSize: 25,
                                                      //         //               fontWeight: FontWeight.bold,
                                                      //         //             ),
                                                      //         //           ),
                                                      //         //         ),
                                                      //         //       );
                                                      //         //     });
                                                      //       },
                                                      //     )),
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
                                            padding: EdgeInsets.all(5.0),
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 180,
                                                    child: TextFormField(
                                                      decoration: InputDecoration(
                                                        labelText: 'Fees',
                                                        border:
                                                            OutlineInputBorder(),
                                                        // icon: Icon(Icons.numbers),
                                                      ),
                                                      controller: fees,
                                                      keyboardType: TextInputType
                                                          .numberWithOptions(
                                                              decimal: true),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      // width: 100,
                                                      child: ElevatedButton(
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
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    custom_color
                                                                        .appcolor),
                                                        shape: MaterialStateProperty
                                                            .all<RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  4.0),
                                                        ))),
                                                    onPressed: () {
                                                      if (selectedPatient == null ||
                                                          selectedPatient == '') {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                'Please select Patient',
                                                            toastLength:
                                                                Toast.LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity.CENTER,
                                                            timeInSecForIosWeb: 2,
                                                            backgroundColor:
                                                                Colors.red,
                                                            textColor: Colors.white,
                                                            fontSize: 15.0);
                                                      } else if (treatmentDropdownvalue ==
                                                              'null' ||
                                                          treatmentDropdownvalue ==
                                                              'Select Treatment') {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                'Please select treatment',
                                                            toastLength:
                                                                Toast.LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity.CENTER,
                                                            timeInSecForIosWeb: 2,
                                                            backgroundColor:
                                                                Colors.red,
                                                            textColor: Colors.white,
                                                            fontSize: 15.0);
                                                      } else if (fees
                                                          .text.isEmpty) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                'Please enter Fees',
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
                                                          "treatmentname":
                                                              treatmentid
                                                                  .toString(),
                                                          "treatment": treatmentname
                                                              .toString(),
                                                          "consult_fees":
                                                              fees.text.toString(),
                                                          "description": ""
                                                        };
                                                        // print(data);
                                                        print(data);
                                                        print(treatmentList);
                                                        // for(var i=0;i<treatmentList.length;i++)
                                                        // {
                                                        //   if(treatmentList[i]==data){
                                                        //     print('already added');
                                                        //     totalCalcution();
                                                        //     return;
                      
                                                        //   }
                                                        //   else{
                                                        //      print('pls  add');
                                                        //      treatmentList
                                                        //       .add(data);
                                                        //       totalCalcution();
                                                        //       return;
                                                        //   }
                      
                                                        // }
                                                        // treatmentList
                                                        //       .add(data);
                                                        //       totalCalcution();
                                                        if (treatmentList.length >
                                                            0) {
                                                          int i = 0;
                                                          for (var checkitem
                                                              in treatmentList) {
                                                            if (checkitem[
                                                                    'treatmentname'] ==
                                                                data[
                                                                    'treatmentname']) {
                                                              Fluttertoast.showToast(
                                                                  msg:
                                                                      'This Treatment Already Added',
                                                                  toastLength: Toast
                                                                      .LENGTH_SHORT,
                                                                  gravity:
                                                                      ToastGravity
                                                                          .CENTER,
                                                                  timeInSecForIosWeb:
                                                                      2,
                                                                  backgroundColor:
                                                                      Colors.red,
                                                                  textColor:
                                                                      Colors.white,
                                                                  fontSize: 15.0);
                      
                                                              print(
                                                                  'already added');
                                                              return;
                                                            } else {
                                                              i++;
                      
                                                              if (treatmentList
                                                                      .length ==
                                                                  i) {
                                                                this.setState(() {
                                                                  treatmentList
                                                                      .add(data);
                                                                  print(
                                                                      treatmentList);
                                                                });
                                                                totalCalcution();
                                                                print(
                                                                    treatmentList);
                                                                gettreatmentlist();
                      
                                                                setState(() {
                                                                  TreatmentList =
                                                                      null;
                                                                  treatmentDropdownvalue =
                                                                      'null';
                                                                  fees.clear();
                                                                });
                                                                setState(() {
                                                                  gettreatmentlist();
                                                                });
                                                                return;
                                                              }
                                                            }
                                                          }
                                                        } else {
                                                          setState(() {
                                                            treatmentList.add(data);
                      
                                                            print(treatmentList);
                                                          });
                                                          totalCalcution();
                                                          print(treatmentList);
                                                          gettreatmentlist();
                      
                                                          setState(() {
                                                            TreatmentList = null;
                                                            treatmentDropdownvalue =
                                                                'null';
                                                            fees.clear();
                                                          });
                                                          setState(() {
                                                            gettreatmentlist();
                                                          });
                                                          return;
                                                        }
                      
                                                        // if (treatmentList
                                                        //     .contains(data)) {
                                                        //   treatmentList
                                                        //       .remove(data);
                                                        // } else {
                                                        //   treatmentList
                                                        //       .add(data);
                      
                                                        // }
                      
                                                        // totalCalcution();
                                                        // print(treatmentList);
                                                        // gettreatmentlist();
                      
                                                        // setState(() {
                                                        //   TreatmentList = null;
                                                        //   treatmentDropdownvalue =
                                                        //       'null';
                                                        //   fees.clear();
                                                        // });
                                                        // setState(() {
                                                        //   gettreatmentlist();
                                                        // });
                                                      }
                                                    },
                                                  )
                      
                                                      // TextFormField(
                                                      //   decoration:  InputDecoration(
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
                                              padding: EdgeInsets.all(5),
                                              // height: screenHeight * 0.6,
                                              width: screenWidth,
                                              child: Helper()
                                                      .isvalidElement(treatmentList)
                                                  ? ListView.builder(
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          treatmentList.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        final data =
                                                            treatmentList[index];
                                                        return Container(
                                                            child: Column(
                                                          children: [
                                                            Card(
                                                              child: ListTile(
                                                                title: Text(
                                                                  '${data['treatment'].toString()}',
                                                                ),
                                                                subtitle: Text(
                                                                    '${"₹ " + data['consult_fees'].toString()}'),
                                                                trailing:
                                                                    IconButton(
                                                                  onPressed: () {
                                                                    setState(() {
                                                                      treatmentList
                                                                          .remove(
                                                                              data);
                                                                      totalCalcution();
                                                                    });
                                                                  },
                                                                  icon: Icon(
                                                                    Icons.close,
                                                                    color:
                                                                        Colors.red,
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
                                          Container(
                                            width: screenWidth,
                                            child: Card(
                                              color: Color.fromARGB(
                                                  255, 103, 118, 207),
                                              child: Padding(
                                                padding: EdgeInsets.all(15.0),
                                                child: Text(
                                                  'Total Treatment Amount : ₹ ${fees_total}',
                                                  style: TextStyle(fontSize: 20),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                          select_button == "test"
                              ? Container(
                                  // height: screenHeight * 0.7,
                                  child: SingleChildScrollView(
                                    physics: ScrollPhysics(),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
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
                                                              InputDecoration(
                                                            labelText: 'Lab Name',
                                                            border:
                                                                OutlineInputBorder(),
                                                            // icon: Icon(Icons.numbers),
                                                          ),
                                                          controller:
                                                              labnameController,
                                                          onChanged: (text) {
                                                            setState(() {
                                                              SelectedLab = null;
                                                              testList.clear();
                                                              testnameController
                                                                  .clear();
                      
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
                                                              InputDecoration(
                                                            labelText: 'Test Name',
                                                            border:
                                                                OutlineInputBorder(),
                                                            // icon: Icon(Icons.numbers),
                                                          ),
                                                          controller:
                                                              testnameController,
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
                                                  height: 6,
                                                ),
                                                SizedBox(
                                                  width: screenWidth,
                                                  child: TextButton(
                                                      onPressed: () async {
                                                        if (labnameController
                                                                .text.isEmpty ||
                                                            SelectedLab
                                                                    .toString() ==
                                                                'null') {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  'Please select Lab',
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity: ToastGravity
                                                                  .CENTER,
                                                              timeInSecForIosWeb: 2,
                                                              backgroundColor:
                                                                  Colors.red,
                                                              textColor:
                                                                  Colors.white,
                                                              fontSize: 15.0);
                                                        } else if (testnameController
                                                            .text.isEmpty) {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  'Please select testlist',
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity: ToastGravity
                                                                  .CENTER,
                                                              timeInSecForIosWeb: 2,
                                                              backgroundColor:
                                                                  Colors.red,
                                                              textColor:
                                                                  Colors.white,
                                                              fontSize: 15.0);
                                                        } else {
                                                          var test = {
                                                            "lab_name":
                                                                labnameController
                                                                    .text
                                                                    .toString(),
                                                            "test_name":
                                                                testnameController
                                                                    .text
                                                                    .toString(),
                                                            "test_id": SelectedTest[
                                                                'test_id'],
                                                          };
                                                          // print(test);
                                                          print(test);
                                                          print(testList);
                                                          print(testList
                                                              .contains(test));
                      
                                                          if (testList.length > 0) {
                                                            int i = 0;
                                                            for (var checkitem
                                                                in testList) {
                                                              if (checkitem[
                                                                      'test_id'] ==
                                                                  test['test_id']) {
                                                                Fluttertoast.showToast(
                                                                    msg:
                                                                        'This Test Already Added',
                                                                    toastLength: Toast
                                                                        .LENGTH_SHORT,
                                                                    gravity:
                                                                        ToastGravity
                                                                            .CENTER,
                                                                    timeInSecForIosWeb:
                                                                        2,
                                                                    backgroundColor:
                                                                        Colors.red,
                                                                    textColor:
                                                                        Colors
                                                                            .white,
                                                                    fontSize: 15.0);
                      
                                                                print(
                                                                    'already added');
                                                                return;
                                                              } else {
                                                                i++;
                      
                                                                if (testList
                                                                        .length ==
                                                                    i) {
                                                                  print(testList);
                                                                  setState(() {
                                                                    testList
                                                                        .add(test);
                                                                    // labshowAutoComplete =
                                                                    //     true;
                                                                    testshowAutoComplete =
                                                                        true;
                                                                    // labnameController
                                                                    //     .clear();
                                                                    testnameController
                                                                        .clear();
                                                                  });
                      
                                                                  return;
                                                                }
                                                              }
                                                            }
                                                          } else {
                                                            setState(() {
                                                              testList.add(test);
                                                              print(testList);
                                                              setState(() {
                                                                // labshowAutoComplete =
                                                                //     true;
                                                                testshowAutoComplete =
                                                                    true;
                                                                // labnameController
                                                                //     .clear();
                                                                testnameController
                                                                    .clear();
                                                              });
                      
                                                              print(testList);
                                                            });
                      
                                                            return;
                                                          }
                      
                                                          // if (testList
                                                          //     .contains(test)) {
                                                          //   testList.remove(test);
                                                          // } else {
                                                          //   testList.add(test);
                                                          // }
                                                          // print(testList);
                                                          // setState(() {
                                                          //   // labshowAutoComplete =
                                                          //   //     true;
                                                          //   testshowAutoComplete =
                                                          //       true;
                                                          //   // labnameController
                                                          //   //     .clear();
                                                          //   testnameController
                                                          //       .clear();
                                                          // });
                                                        }
                                                      },
                                                      child: Text(
                                                        "ADD TEST",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<
                                                                          Color>(
                                                                      custom_color
                                                                          .appcolor),
                                                          shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(4.0),
                                                          )))),
                                                  // TextFormField(
                                                  //   decoration:  InputDecoration(
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
                                            padding: EdgeInsets.all(5),
                                            // height: screenHeight * 0.6,
                                            width: screenWidth,
                                            child: Helper()
                                                        .isvalidElement(testList) &&
                                                    select_button == 'test'
                                                ? ListView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: testList.length,
                                                    itemBuilder:
                                                        (BuildContext context,
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
                                                                    testList.remove(
                                                                        data);
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
                          select_button == "injection"
                              ? Container(
                                  // height: screenHeight * 0.7,
                                  child: SingleChildScrollView(
                                    physics: ScrollPhysics(),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Container(
                                            width: screenWidth,
                                            child: Column(
                                              children: [
                                                injectionshowautoComplete
                                                    ? renderinjectionlistAutoComplete(
                                                        screenWidth, screenHeight)
                                                    : SizedBox(
                                                        // width: 180,
                                                        child: TextFormField(
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'Injection Name',
                                                            border:
                                                                OutlineInputBorder(),
                                                            // icon: Icon(Icons.numbers),
                                                          ),
                                                          controller:
                                                              injectionnameController,
                                                          onChanged: (text) {
                                                            setState(() {
                                                              injectionnameController
                                                                      .text.isEmpty
                                                                  ? injectionshowautoComplete =
                                                                      true
                                                                  : injectionshowautoComplete =
                                                                      false;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                SizedBox(height: 10),
                                                SizedBox(
                                                  // width: 180,
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                      labelText: 'Dose',
                                                      border: OutlineInputBorder(),
                                                      // icon: Icon(Icons.numbers),
                                                    ),
                                                    controller: doseController,
                                                    onChanged: (text) {
                                                      setState(() {});
                                                    },
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                SizedBox(
                                                  width: screenWidth,
                                                  child: TextButton(
                                                      onPressed: () async {
                                                        if (injectionnameController
                                                            .text.isEmpty) {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  'Please select Injection',
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity: ToastGravity
                                                                  .CENTER,
                                                              timeInSecForIosWeb: 2,
                                                              backgroundColor:
                                                                  Colors.red,
                                                              textColor:
                                                                  Colors.white,
                                                              fontSize: 15.0);
                                                        } else if (doseController
                                                            .text.isEmpty) {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  'Please enter Dose',
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity: ToastGravity
                                                                  .CENTER,
                                                              timeInSecForIosWeb: 2,
                                                              backgroundColor:
                                                                  Colors.red,
                                                              textColor:
                                                                  Colors.white,
                                                              fontSize: 15.0);
                                                        } else {
                                                          var injection = {
                                                            "injectionname":
                                                                injectionnameController
                                                                    .text
                                                                    .toString(),
                                                            "dose": doseController
                                                                .text
                                                                .toString(),
                                                          };
                                                          // print(test);
                                                          print(injection);
                                                          print(injectionlist);
                                                          print(injectionlist
                                                              .contains(injection));
                      
                                                          if (injectionlist
                                                              .contains(
                                                                  injection)) {
                                                            injectionlist
                                                                .remove(injection);
                                                          } else {
                                                            injectionlist
                                                                .add(injection);
                                                          }
                                                          print(injectionlist);
                                                          setState(() {
                                                            injectionshowautoComplete =
                                                                true;
                                                            // labshowAutoComplete = true;
                                                            // testshowAutoComplete = false;
                                                            injectionnameController
                                                                .clear();
                                                            doseController.clear();
                                                          });
                                                        }
                                                      },
                                                      child: Text(
                                                        "ADD INJECTION",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<
                                                                          Color>(
                                                                      custom_color
                                                                          .appcolor),
                                                          shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(4.0),
                                                          )))),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Helper().isvalidElement(injectionlist) &&
                                                select_button == 'injection' &&
                                                injectionlist.length > 0
                                            ? Container(
                                                width: screenWidth,
                                                child: Text(
                                                  ' Injection List :',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              )
                                            : Container(),
                                        Container(
                                            padding: EdgeInsets.all(5),
                                            // height: screenHeight * 0.6,
                                            width: screenWidth,
                                            child: Helper().isvalidElement(
                                                        injectionlist) &&
                                                    select_button == 'injection'
                                                ? ListView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: injectionlist.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      final data =
                                                          injectionlist[index];
                                                      return Container(
                                                          child: Column(
                                                        children: [
                                                          Card(
                                                            child: ListTile(
                                                              title: Text(
                                                                'Injection Name: ${data['injectionname'].toString()}',
                                                              ),
                                                              subtitle: Text(
                                                                  'Dose: ${data['dose'].toString()}'),
                                                              trailing: IconButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    injectionlist
                                                                        .remove(
                                                                            data);
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
                                  // height: screenHeight * 0.7 - keyboardHeight,
                                  child: SingleChildScrollView(
                                    physics: NeverScrollableScrollPhysics(),
                      
                                    //  reverse: true,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Container(
                                              child: Column(
                                            children: [
                                              pharmacyshowAutoComplete
                                                  ? renderpharmacylistAutoComplete(
                                                      screenWidth, screenHeight)
                                                  : SizedBox(
                                                      width: screenWidth,
                                                      child: TextFormField(
                                                        decoration: InputDecoration(
                                                          labelText:
                                                              'Pharmacy Name',
                                                          border:
                                                              OutlineInputBorder(),
                                                          // icon: Icon(Icons.numbers),
                                                        ),
                                                        controller:
                                                            pharmacyController,
                                                        onChanged: (text) {
                                                          setState(() {
                                                            table_list.clear();
                                                            medicineshowAutoComplete =
                                                                false;
                                                            // SelectedPharmacy = null;
                                                            // getMedicineList();
                      
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
                                                        decoration: InputDecoration(
                                                          labelText:
                                                              'Medicine Name',
                                                          border:
                                                              OutlineInputBorder(),
                                                          // icon: Icon(Icons.numbers),
                                                        ),
                                                        controller:
                                                            medicineController,
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
                                                  // SizedBox(
                                                  //   width: screenWidth * 0.455,
                                                  //   child: TextFormField(
                                                  //     decoration:  InputDecoration(
                                                  //       labelText: 'Price',
                                                  //       border: OutlineInputBorder(),
                                                  //       // icon: Icon(Icons.numbers),
                                                  //     ),
                                                  //     controller: priceController,
                                                  //     keyboardType:
                                                  //         TextInputType.numberWithOptions(
                                                  //             decimal: true),
                                                  //   ),
                                                  // ),
                                                  SizedBox(
                                                    width: screenWidth * 0.95,
                                                    child: TextFormField(
                                                      decoration: InputDecoration(
                                                        labelText: 'Day',
                                                        border:
                                                            OutlineInputBorder(),
                                                        // icon: Icon(Icons.numbers),
                                                      ),
                                                      controller: dayController,
                                                      keyboardType: TextInputType
                                                          .numberWithOptions(
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
                                                      width: screenWidth * 0.35,
                                                      child: pattern
                                                          ? DropdownButtonFormField(
                                                              // validator: (value) => validateDrops(value),
                                                              // isExpanded: true,
                                                              hint: Text(
                                                                  'Select Pattern'),
                                                              // value:' _selectedState[i]',
                                                              onChanged:
                                                                  (Pharmacy) {
                                                                setState(() {});
                                                              },
                                                              items: [].map<
                                                                  DropdownMenuItem<
                                                                      String>>((item) {
                                                                return new DropdownMenuItem(
                                                                  child:
                                                                      new Text(''),
                                                                  value: '',
                                                                );
                                                              }).toList(),
                                                            )
                                                          : DropdownButtonFormField(
                                                              key: _patternkey,
                                                              decoration:
                                                                  InputDecoration(
                                                                labelText:
                                                                    'Pattern',
                                                                border:
                                                                    OutlineInputBorder(),
                                                                //icon: Icon(Icons.numbers),
                                                              ),
                                                              isExpanded: true,
                                                              hint: Text('Pattern'),
                                                              // value:patternDropdownvalue,
                                                              onChanged:
                                                                  (item) async {
                                                                patternDropdownvalue =
                                                                    item.toString();
                                                                var data = item
                                                                    .toString()
                                                                    .split('&*');
                                                                Pattern_type =
                                                                    data[1];
                                                                count = data[0];
                                                                mor = data[2];
                                                                noon = data[3];
                                                                night = data[4];
                                                              },
                                                              items: demo.map<
                                                                  DropdownMenuItem<
                                                                      String>>((item) {
                                                                return DropdownMenuItem(
                                                                  child: Text(
                                                                    item['name']
                                                                        .toString(),
                                                                  ),
                                                                  value: item['value']
                                                                          .toString() +
                                                                      '&*' +
                                                                      item['name']
                                                                          .toString() +
                                                                      '&*' +
                                                                      item['mor']
                                                                          .toString() +
                                                                      '&*' +
                                                                      item['noon']
                                                                          .toString() +
                                                                      '&*' +
                                                                      item['night']
                                                                          .toString() +
                                                                      '&*',
                                                                );
                                                              }).toList(),
                                                            )),
                                                  SizedBox(
                                                    width: screenWidth * 0.6,
                                                    child: DropdownButtonFormField(
                                                      value:
                                                          prescriptionDropdownvalue,
                                                      autovalidateMode:
                                                          AutovalidateMode.always,
                                                      decoration: InputDecoration(
                                                        labelText: 'Prescription',
                                                        border:
                                                            OutlineInputBorder(),
                                                        //icon: Icon(Icons.numbers),
                                                      ),
                                                      items: Prescription.map(
                                                          (String items) {
                                                        return DropdownMenuItem(
                                                          value: items,
                                                          child: Text(items),
                                                        );
                                                      }).toList(),
                                                      onChanged:
                                                          (String? newValue) {
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
                                                    width: screenWidth * 0.955,
                                                    child: TextButton(
                                                        onPressed: () async {
                                                          // if (pharmacyController
                                                          //     .text.isNotEmpty) {
                                                          //   Fluttertoast.showToast(
                                                          //       msg:
                                                          //           'Please select pharmacy',
                                                          //       toastLength:
                                                          //           Toast.LENGTH_SHORT,
                                                          //       gravity:
                                                          //           ToastGravity.CENTER,
                                                          //       timeInSecForIosWeb: 2,
                                                          //       backgroundColor:
                                                          //           Colors.red,
                                                          //       textColor: Colors.white,
                                                          //       fontSize: 15.0);
                                                          // } else
                      
                                                          // return;
                                                          if (medicineController
                                                              .text.isEmpty) {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    'Please select medicine',
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .CENTER,
                                                                timeInSecForIosWeb:
                                                                    2,
                                                                backgroundColor:
                                                                    Colors.red,
                                                                textColor:
                                                                    Colors.white,
                                                                fontSize: 15.0);
                                                          } else if (priceController
                                                              .text.isEmpty) {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    'Please select price',
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .CENTER,
                                                                timeInSecForIosWeb:
                                                                    2,
                                                                backgroundColor:
                                                                    Colors.red,
                                                                textColor:
                                                                    Colors.white,
                                                                fontSize: 15.0);
                                                          } else if (dayController
                                                              .text.isEmpty) {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    'Please enter the days',
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .CENTER,
                                                                timeInSecForIosWeb:
                                                                    2,
                                                                backgroundColor:
                                                                    Colors.red,
                                                                textColor:
                                                                    Colors.white,
                                                                fontSize: 15.0);
                                                          } else if (patternDropdownvalue
                                                                  .isEmpty ||
                                                              patternDropdownvalue ==
                                                                  'pattern') {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    'Please select pattern',
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .CENTER,
                                                                timeInSecForIosWeb:
                                                                    2,
                                                                backgroundColor:
                                                                    Colors.red,
                                                                textColor:
                                                                    Colors.white,
                                                                fontSize: 15.0);
                                                          } else if (prescriptionDropdownvalue
                                                                  .isEmpty ||
                                                              prescriptionDropdownvalue ==
                                                                  'Select Prescription') {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    'Please select prescription',
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .CENTER,
                                                                timeInSecForIosWeb:
                                                                    2,
                                                                backgroundColor:
                                                                    Colors.red,
                                                                textColor:
                                                                    Colors.white,
                                                                fontSize: 15.0);
                                                          } else {
                                                            // tableCalCulation();/////////final
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
                                                              "itemno":
                                                                  Selectedmedicine[
                                                                          'id']
                                                                      .toString(),
                                                              "medicinename":
                                                                  medicineController
                                                                      .text
                                                                      .toString(),
                                                              // "price": priceController
                                                              //     .text
                                                              //     .toString(),
                                                              "days": dayController
                                                                  .text
                                                                  .toString(),
                                                              "patterntype":
                                                                  Pattern_type
                                                                      .toString(),
                                                              "mor": mor.toString(),
                                                              "noon":
                                                                  noon.toString(),
                                                              "evng": '',
                                                              "night":
                                                                  night.toString(),
                                                              "total_qty":
                                                                  count.toString(),
                                                              "BA_food_select":
                                                                  prescriptionDropdownvalue
                                                                      .toString()
                                                                      .toLowerCase(),
                                                              // "total": total.toString(),
                                                              "comment": '',
                                                            };
                                                            print(data);
                                                            print(medicineList);
                      
                                                            if (table_list.length >
                                                                0) {
                                                              int i = 0;
                                                              for (var checkitem
                                                                  in table_list) {
                                                                if (checkitem[
                                                                        'itemno'] ==
                                                                    data[
                                                                        'itemno']) {
                                                                  Fluttertoast.showToast(
                                                                      msg:
                                                                          'This Medicine Already Added',
                                                                      toastLength: Toast
                                                                          .LENGTH_SHORT,
                                                                      gravity:
                                                                          ToastGravity
                                                                              .CENTER,
                                                                      timeInSecForIosWeb:
                                                                          2,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                      textColor:
                                                                          Colors
                                                                              .white,
                                                                      fontSize:
                                                                          15.0);
                      
                                                                  print(
                                                                      'already added');
                      
                                                                  return;
                                                                } else {
                                                                  i++;
                      
                                                                  if (table_list
                                                                          .length ==
                                                                      i) {
                                                                    print(testList);
                                                                    setState(() {
                                                                      totalCalcution();
                                                                      table_list
                                                                          .add(
                                                                              data);
                                                                      // labshowAutoComplete =
                                                                      //     true;
                                                                      testshowAutoComplete =
                                                                          true;
                                                                      // labnameController
                                                                      //     .clear();
                                                                      testnameController
                                                                          .clear();
                                                                    });
                                                                    setState(() {
                                                                      prescriptionDD =
                                                                          false;
                                                                      medicineshowAutoComplete =
                                                                          true;
                      
                                                                      medicineController
                                                                          .clear();
                                                                      priceController
                                                                          .clear();
                                                                      dayController
                                                                          .clear();
                                                                      patternDropdownvalue =
                                                                          'pattern';
                                                                      prescriptionDropdownvalue =
                                                                          'Select Prescription';
                                                                      prescriptionDD =
                                                                          true;
                                                                    });
                                                                    _patternkey
                                                                        .currentState
                                                                        ?.reset();
                                                                    return;
                                                                  }
                                                                }
                                                              }
                                                            } else {
                                                              setState(() {
                                                                table_list
                                                                    .add(data);
                                                                print(table_list);
                                                                setState(() {
                                                                  totalCalcution();
                                                                  // labshowAutoComplete =
                                                                  //     true;
                                                                  testshowAutoComplete =
                                                                      true;
                                                                  // labnameController
                                                                  //     .clear();
                                                                  testnameController
                                                                      .clear();
                                                                });
                                                                setState(() {
                                                                  // prescriptionDD=false;
                                                                  medicineshowAutoComplete =
                                                                      true;
                      
                                                                  medicineController
                                                                      .clear();
                                                                  priceController
                                                                      .clear();
                                                                  dayController
                                                                      .clear();
                                                                  patternDropdownvalue =
                                                                      'pattern';
                                                                  medicineAdded =
                                                                      true;
                                                                  prescriptionDropdownvalue =
                                                                      'Select Prescription';
                                                                  // prescriptionDD=true;
                                                                });
                                                                print(testList);
                                                              });
                                                              _patternkey
                                                                  .currentState
                                                                  ?.reset();
                                                              return;
                                                            }
                                                          }
                                                          _patternkey.currentState
                                                              ?.reset();
                                                        },
                                                        child: Text(
                                                          "Add Medicine",
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight.bold),
                                                        ),
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all<Color>(
                                                                        custom_color
                                                                            .appcolor),
                                                            shape: MaterialStateProperty.all<
                                                                    RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4.0),
                                                            )))),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                            ],
                                          )),
                                        ),
                                        Helper().isvalidElement(table_list) &&
                                                select_button == 'medicine' &&
                                                table_list.length > 0
                                            ? Container(
                                                width: screenWidth,
                                                child: Text(
                                                  '  Medicine List :',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              )
                                            : Container(),
                                        Helper().isvalidElement(table_list) &&
                                                table_list.length > 0
                                            ? Container(
                                                padding: EdgeInsets.all(5),
                                                // height: screenHeight * 0.6,
                                                width: screenWidth,
                                                child: ListView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: table_list.length,
                                                    // itemCount: testList.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      final data =
                                                          table_list[index];
                                                      return Container(
                                                        child: Card(
                                                            color: index % 2 == 0
                                                                ? custom_color
                                                                    .lightcolor
                                                                : Colors.white,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      8.0),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      SizedBox(
                                                                        width:
                                                                            screenWidth *
                                                                                0.6,
                                                                        child: Row(
                                                                          children: [
                                                                            Text(
                                                                              'Medicine :',
                                                                              style: TextStyle(
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 13),
                                                                            ),
                                                                            Text(
                                                                              "${data['medicinename'].toString().length < 20 ? data['medicinename'].toString() : data['medicinename'].toString().substring(0, 19)}",
                                                                              style:
                                                                                  TextStyle(fontSize: 15),
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
                                                                                    FontWeight.bold,
                                                                                fontSize: 13),
                                                                          ),
                                                                          Text(
                                                                            "${data['days'].toString()}",
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                    15),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      // Row(
                                                                      //   children: [
                                                                      //     Text(
                                                                      //       'BF/AF: ',
                                                                      //       style: TextStyle(
                                                                      //           fontWeight:
                                                                      //               FontWeight
                                                                      //                   .bold,
                                                                      //           fontSize: 13),
                                                                      //     ),
                                                                      //     Text(
                                                                      //       "${data['BA_food_select'].toString()}",
                                                                      //       style: TextStyle(
                                                                      //           fontSize: 15),
                                                                      //     )
                                                                      //   ],
                                                                      // ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                      height: 10),
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
                                                                                    FontWeight.bold,
                                                                                fontSize: 13),
                                                                          ),
                                                                          Text(
                                                                            "${data['mor'].toString()}",
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                    15),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            'Noon: ',
                                                                            style: TextStyle(
                                                                                fontWeight:
                                                                                    FontWeight.bold,
                                                                                fontSize: 13),
                                                                          ),
                                                                          Text(
                                                                            "${data['noon'].toString()} ",
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                    15),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            'Night: ',
                                                                            style: TextStyle(
                                                                                fontWeight:
                                                                                    FontWeight.bold,
                                                                                fontSize: 13),
                                                                          ),
                                                                          Text(
                                                                            "${data['night'].toString()} ",
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                    15),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            'Total Qty: ',
                                                                            style: TextStyle(
                                                                                fontWeight:
                                                                                    FontWeight.bold,
                                                                                fontSize: 13),
                                                                          ),
                                                                          Text(
                                                                            "${data['total_qty'].toString()}",
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                    15),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  // SizedBox(height:8),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      // Row(
                                                                      //   children: [
                                                                      //     Text(
                                                                      //       'Total Qty: ',
                                                                      //       style: TextStyle(
                                                                      //           fontWeight:
                                                                      //               FontWeight
                                                                      //                   .bold,
                                                                      //           fontSize: 13),
                                                                      //     ),
                                                                      //     Text(
                                                                      //       "${data['total_qty'].toString()}",
                                                                      //       style: TextStyle(
                                                                      //           fontSize: 15),
                                                                      //     )
                                                                      //   ],
                                                                      // ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            'BF / AF : ',
                                                                            style: TextStyle(
                                                                                fontWeight:
                                                                                    FontWeight.bold,
                                                                                fontSize: 13),
                                                                          ),
                                                                          Text(
                                                                            "${data['BA_food_select'].toString()}",
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                    15),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      // Row(
                                                                      //   children: [
                                                                      //     Text(
                                                                      //       'Total: ',
                                                                      //       style: TextStyle(
                                                                      //           fontWeight:
                                                                      //               FontWeight
                                                                      //                   .bold,
                                                                      //           fontSize: 13),
                                                                      //     ),
                                                                      //     Text(
                                                                      //       "₹ ${data['total'].toString()} ",
                                                                      //       style: TextStyle(
                                                                      //           fontSize: 15),
                                                                      //     )
                                                                      //   ],
                                                                      // ),
                                                                      SizedBox(
                                                                        child:
                                                                            TextButton(
                                                                          child:
                                                                              Text(
                                                                            "Remove",
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                    15,
                                                                                color:
                                                                                    Colors.red),
                                                                          ),
                                                                          onPressed:
                                                                              () async {
                                                                            setState(
                                                                                () {
                                                                              //  table_List.remove(data);
                                                                              table_list
                                                                                  .remove(data);
                                                                              // tableCalCulation();
                                                                            });
                                                                            // tableCalCulation();
                                                                            totalCalcution();
                                                                          },
                                                                        ),
                                                                      )
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
                                        Container(
                                          child: Column(
                                            children: [
                                              Text(
                                                "Final Discount",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              Divider(),
                                              // Row(
                                              //   children: [
                                              //     Container(
                                              //       width: screenWidth * 0.5,
                                              //       child: RadioListTile(
                                              //         title: Text("Amount ₹"),
                                              //         value: "amount",
                                              //         groupValue: finaldiscount,
                                              //         onChanged: (value) {
                                              //           setState(() {
                                              //             finaldiscount =
                                              //                 value.toString();
                                              //             totalCalcution();
                                              //           });
                                              //         },
                                              //       ),
                                              //     ),
                                              //     Container(
                                              //       width: screenWidth * 0.5,
                                              //       child: RadioListTile(
                                              //         title: Text("percentage %"),
                                              //         value: "Percentage",
                                              //         groupValue: finaldiscount,
                                              //         onChanged: (value) {
                                              //           // setState(() {
                                              //           //   finaldiscount =
                                              //           //       value.toString();
                                              //           //   totalCalcution();
                                              //           // });
                                              //         },
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                            ],
                                          ),
                                        ),
                                        //  Container(height: screenHeight*0.5,),
                                        SizedBox(height: 5),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: screenWidth * 0.455,
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                    labelText: 'Discount(₹)',
                                                    border: OutlineInputBorder(),
                                                    // icon: Icon(Icons.numbers),
                                                  ),
                                                  controller: discountController,
                                                  onChanged: (text) {
                                                    if (finaldiscount ==
                                                        'amount') {}
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
                                                  keyboardType: TextInputType
                                                      .numberWithOptions(
                                                          decimal: true),
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenWidth * 0.455,
                                                child: TextFormField(
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                    labelText: 'Grant Total',
                      
                                                    border: OutlineInputBorder(),
                                                    // icon: Icon(Icons.numbers),
                                                  ),
                                                  controller: grandtotalController,
                                                  // grandtotalController=
                                                  keyboardType: TextInputType
                                                      .numberWithOptions(
                                                          decimal: true),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Container(
                                            child: Column(
                                              children: [
                                                //   ],),
                                                // )
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: screenWidth * 0.455,
                                                      child: TextFormField(
                                                        decoration: InputDecoration(
                                                          labelText: 'Recieved',
                                                          border:
                                                              OutlineInputBorder(),
                                                          // icon: Icon(Icons.numbers),
                                                        ),
                                                        controller:
                                                            receivedController,
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
                                                        readOnly: true,
                                                        decoration: InputDecoration(
                                                          labelText: 'Balance',
                                                          border:
                                                              OutlineInputBorder(),
                                                          // icon: Icon(Icons.numbers),
                                                        ),
                                                        controller:
                                                            balanceController,
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: screenWidth * 0.455,
                                                      child: TextFormField(
                                                        readOnly: true,
                                                        decoration: InputDecoration(
                                                          labelText: 'Change',
                                                          border:
                                                              OutlineInputBorder(),
                                                          // icon: Icon(Icons.numbers),
                                                        ),
                                                        controller:
                                                            changeController,
                                                        keyboardType: TextInputType
                                                            .numberWithOptions(
                                                                decimal: true),
                                                      ),
                                                    ),
                                                    //   SizedBox(
                                                    //   width:  screenWidth*0.455,
                                                    //   child: TextFormField(
                                                    //     decoration:  InputDecoration(
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
                                                    padding: EdgeInsets.all(8.0),
                                                    child: TextButton(
                                                        onPressed: () async {
                                                          if (selectedPatient ==
                                                                  null ||
                                                              selectedPatient ==
                                                                  '') {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    'Please select Patient',
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .CENTER,
                                                                timeInSecForIosWeb:
                                                                    2,
                                                                backgroundColor:
                                                                    Colors.red,
                                                                textColor:
                                                                    Colors.white,
                                                                fontSize: 15.0);
                                                          } else if (Helper()
                                                                  .isvalidElement(
                                                                      treatmentList) &&
                                                              treatmentList
                                                                      .length ==
                                                                  0) {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    'Please select Treatment',
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .CENTER,
                                                                timeInSecForIosWeb:
                                                                    2,
                                                                backgroundColor:
                                                                    Colors.red,
                                                                textColor:
                                                                    Colors.white,
                                                                fontSize: 15.0);
                                                          } else {
                                                            Prescription_data = {
                                                              "doctor_id":
                                                                  selectedPatient[
                                                                          'doctor_id']
                                                                      .toString(),
                                                              "patient_name":
                                                                  selectedPatient[
                                                                          'customer_name']
                                                                      .toString(),
                                                              "patient_mobile":
                                                                  selectedPatient[
                                                                          'phone']
                                                                      .toString(),
                                                              "patient_id":
                                                                  selectedPatient[
                                                                          'cid']
                                                                      .toString(),
                                                              "pharmeasyid": Helper()
                                                                      .isvalidElement(
                                                                          SelectedPharmacy)
                                                                  ? SelectedPharmacy[
                                                                          'shop_id']
                                                                      .toString()
                                                                  : '',
                                                              "labid": Helper()
                                                                      .isvalidElement(
                                                                          SelectedLab)
                                                                  ? SelectedLab[
                                                                          'shop_id']
                                                                      .toString()
                                                                  : '',
                                                              "date":
                                                                  "${(Helper().formateDate1(selectedDate))}",
                                                              "prescription_comment":
                                                                  "",
                                                              "sugar":
                                                                  selectedPatient[
                                                                          'sugar']
                                                                      .toString(),
                                                              "pulse":
                                                                  selectedPatient[
                                                                          'pulse']
                                                                      .toString(),
                                                              "bp": selectedPatient[
                                                                      'bp']
                                                                  .toString(),
                                                              "temp":
                                                                  selectedPatient[
                                                                          'temp']
                                                                      .toString(),
                                                              "advance":
                                                                  receivedController
                                                                      .text
                                                                      .toString(),
                                                              "discount_type":
                                                                  finaldiscount
                                                                      .toString(),
                                                              "discount":
                                                                  discountController
                                                                      .text
                                                                      .toString(),
                                                              "balance":
                                                                  balanceController
                                                                      .text
                                                                      .toString(),
                                                              "change":
                                                                  changeController
                                                                      .text
                                                                      .toString(),
                                                              "grand_total":
                                                                  grandtotalController
                                                                      .text
                                                                      .toString(),
                                                              "height":
                                                                  selectedPatient[
                                                                          'height']
                                                                      .toString(),
                                                              "weight":
                                                                  selectedPatient[
                                                                          'weight']
                                                                      .toString(),
                                                              "treatment_item":
                                                                  treatmentList,
                                                              "medicine_item":
                                                                  table_list,
                                                              "test_item": testList,
                                                              "injection_item":
                                                                  injectionlist,
                                                            };
                                                            postPrescription();
                                                            // toClear();
                                                          }
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
                                                                MaterialStateProperty
                                                                    .all<Color>(
                                                                        custom_color
                                                                            .appcolor),
                                                            shape: MaterialStateProperty.all<
                                                                    RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4.0),
                                                            )))),
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
                          Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  select_button != 'treatment'
                                      ?
                                      // Container(
                                      //   child: IconButton(
                                      //     icon: Icon(Icons.arrow_back_sharp),
                                      //     onPressed: (){
                      
                                      //     },
                                      //   ),
                                      // )
                                      FloatingActionButton(
                                          backgroundColor: custom_color.appcolor,
                                          foregroundColor: Colors.white,
                                          onPressed: () {
                                            if (select_button == 'medicine') {
                                              setState(() {
                                                select_button = 'injection';
                                              });
                                            } else if (select_button ==
                                                'injection') {
                                              setState(() {
                                                select_button = 'test';
                                                click_button = "lab";
                      
                                                getMediAndLabNameList();
                                              });
                                            } else if (select_button == 'test') {
                                              setState(() {
                                                select_button = 'treatment';
                                              });
                                            }
                                          },
                                          child: Icon(Icons.arrow_back),
                                        )
                                      : Container(),
                                  select_button != 'medicine'
                                      ? FloatingActionButton(
                                          backgroundColor: custom_color.appcolor,
                                          foregroundColor: Colors.white,
                                          onPressed: () {
                                            if (select_button == 'treatment') {
                                              if (selectedPatient == null ||
                                                  selectedPatient == '') {
                                                Fluttertoast.showToast(
                                                    msg: 'Please select Patient',
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 2,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 15.0);
                                              } else if (treatmentList.isEmpty) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        'Please Add a Atleast one treatment',
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 2,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 15.0);
                                              } else
                                                setState(() {
                                                  select_button = 'test';
                      
                                                  click_button = "lab";
                                                  getMediAndLabNameList();
                                                });
                                            } else if (select_button == 'test') {
                                              setState(() {
                                                select_button = 'injection';
                                              });
                                            } else if (select_button ==
                                                'injection') {
                                              setState(() {
                                                select_button = 'medicine';
                                                medicineAdded = false;
                                                click_button = 'pharmacy';
                                                getMediAndLabNameList();
                                                // getMedicineList();
                                              });
                                            }
                                          },
                                          child: Icon(Icons.arrow_forward),
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            )
            : SpinLoader(),
        //           floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // floatingActionButton: Container(
        //   padding:  EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: <Widget>[

        //       // Container(
        //       //   child: IconButton(
        //       //     icon: Icon(Icons.arrow_back_sharp),
        //       //     onPressed: (){

        //       //     },
        //       //   ),
        //       // ),

        //       FloatingActionButton(
        //          backgroundColor: custom_color.appcolor,
        //       foregroundColor: Colors.white,

        //         onPressed:(){},
        //         child:  Icon(Icons.arrow_back),
        //       ),

        //       FloatingActionButton(
        //         backgroundColor: custom_color.appcolor,
        //       foregroundColor: Colors.white,
        //         onPressed:() {},
        //         child:  Icon(Icons.arrow_forward),
        //       )

        //     ],
        //   ),
        // ),

      //   floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     FloatingActionButton(
      //       onPressed: () => {},
      //       child: Icon(Icons.navigate_before_rounded),
      //       heroTag: "fab1",
      //     ),
          
      //     FloatingActionButton(
      //       onPressed: () => {},
      //       child: Icon(Icons.navigate_next_rounded),
      //       heroTag: "fab2",
      //     ),
      //   ]
      // )
      ),
    );
  }

  // tableCalCulation() {
  //   total = 0.0;
  //   var price = double.parse(priceController.text);
  //   var day = double.parse(dayController.text);
  //   var number = double.parse(count);
  //   setState(() {
  //     total = (number * price) * day;
  //     // cal={
  //     //   "total":total.toString(),
  //     // };
  //   });
  // }

  totalCalcution() {
    //treatment
    fees_total = 0.0;
    for (var value in treatmentList) {
      fees_total = fees_total + double.parse(value['consult_fees']);
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
    grand_total = 0.0;
//     if (table_list.length > 0) {
//       for (var value in table_list) {

//         grand_total = grand_total + double.parse(value['total']);
//       }
//  final_grand_total=grand_total+fees_total;
//     } else {
//       final_grand_total = grand_total + fees_total;
//     }
    final_grand_total = grand_total + fees_total;
    // return grand_total;
    setState(() {
      grandtotalController.text = final_grand_total.toString();
      //balance

      if (finaldiscount == 'Percentage') {
        finaldiscountvalue = final_grand_total * (finaldiscountvalue / 100);
      } else {
        final_grand_total;
      }

      if (final_grand_total >= finaldiscountvalue) {
        balance = final_grand_total - finaldiscountvalue;

        // balance=(balance)-(recieved);
      } else {
        Fluttertoast.showToast(
            msg: 'Discount Amount is greater then Grand total',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 15.0);
        setState(() {
          discountController.clear();
          finaldiscountvalue = 0.0;
          totalCalcution();
        });
      }
      if (recieved <= balance) {
        balance = balance - recieved;
        change = 0;
      } else if (recieved > balance) {
        change = recieved - balance;
        balance = 0;
      }
      // if(recieved==balance){
      //   setState(() {
      //     balance=0.0;
      //     totalCalcution();
      //   });

      // }else if(recieved<balance){
      //   setState(() {
      //      balance=balance-recieved;
      //       totalCalcution();
      //   });

      // }
      // if(recieved>balance){
      //   setState(() {
      //     change=recieved-balance;
      //   balance=0.0;
      //    totalCalcution();
      //   });

      // }

      balanceController.text = balance.toString();
      changeController.text = change.toString();
    });
  }

  toClear() {
    treatmentList.clear();
    testList.clear();
    injectionlist.clear();
    medicineList.clear();
    table_list.clear();
    discountController.clear();
    receivedController.clear();
    changeController.clear();
    grandtotalController.clear();
    balanceController.clear();
    fees_total = 0.0;
    table_list.clear();
  }

  getpatientlist() async {
    // this.setState(() {
    //   isloading = true;
    // });
    var list = await PatientApi().getpatientlist(accesstoken);
    if (Helper().isvalidElement(list) &&
        Helper().isvalidElement(list['status']) &&
        list['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      //  storage.setItem('diagnosisList', diagnosisList);
      setState(() {
        PatientList = list['Customer_list'];
        isloading = true;
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
      "shop_id": SelectedPharmacy['shop_id'].toString(),

      //  Helper().isvalidElement(SelectedPharmacy)
      //     ? SelectedPharmacy['shop_id'].toString()
      //     : ' ',
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

  getInjectionList() async {
    var List = await PatientApi().getinjectionList(accesstoken);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        InjectionList = List['list'];
      });
      // TreatmentList = List['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
    }
  }

  postPrescription() async {
    // var data = data;
    var result =
        await PatientApi().add_prescription(accesstoken, Prescription_data);
    if (Helper().isvalidElement(result) &&
        Helper().isvalidElement(result['status']) &&
        result['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else if (Helper().isvalidElement(result) &&
        Helper().isvalidElement(result['message']) &&
        result['message'] == 'Successfully') {
      AudioPlayer().play(AssetSource('medimessage.mp3'));
      toClear();
      storage.deleteItem('selectedcustomer');
      print(result['message']);
      Fluttertoast.showToast(
          msg: 'New Prescription Added Successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 15.0);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dash()),
      );
    } else {
      Fluttertoast.showToast(
          msg: 'Please Try Again Later',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }
  renderAutoComplete(screenWidth, screenHeight) {
    return Autocomplete<List>(
      optionsBuilder: (TextEditingValue textEditingValue) {
      

        if (textEditingValue.text == '') {
          return  const Iterable<List>.empty();
        } else {
          var matches = [];
          matches.addAll(PatientList);
          matches.retainWhere((s) {
            return s['customer_name']
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
          setState(() {});
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
                  hintText: 'Search Patient Name',
                  
                  prefixIcon: const Icon(Icons.search),
                  
                  
                  enabledBorder: OutlineInputBorder(
                    
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: custom_color.appcolor,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: custom_color.appcolor,
                      width: 1.0,
                    ),
                  ),
                ),
            
            // decoration:  InputDecoration(
            //     border: OutlineInputBorder(),
            //     // prefix: Icon(Icons.search),
            //     prefixIcon: Icon(Icons.search),
            //     hintText: ' Search Patient Name'),
            onFieldSubmitted: (String value) {
              onFieldSubmitted();
            });
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<List> onSelected, Iterable<List> options) {
        return options.toList()[0].isNotEmpty ?
         Align(
          alignment: Alignment.topLeft,
          child: Material(
            child: SizedBox(
              width: screenWidth ,
              // height: screenHeight * 0.8,
              // color:Colors.transparent,
              // color: Colors.white,
              child: Card(
                 color: Colors.transparent,
                      elevation: 30,
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
             
                  child: Column(
                    children: [
                     
                
                      ListView.builder(
                        shrinkWrap: true,
                        padding:  const EdgeInsets.all(5.0),
                        itemCount: options.toList()[0].length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                                final option =
                                    options.toList()[0].elementAt(index);
                                return GestureDetector(
                                  onTap: () {
                                    storage.setItem('selectedPatient',
                                        options.toList()[0][index]);
                                    setState(() {
                                      showAutoComplete = false;
                                      selectedPatient =
                                          options.toList()[0][index];
                                    });
                                  },
                                  child: Card(
                                    color: Colors.grey,
                                    // color: custom_color.app_color,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                                              Padding(
                                    padding:  EdgeInsets.all(8.0),
                                    child: Text(
                                        '${options.toList()[0][index]['customer_name'].toString()} , ${options.toList()[0][index]['phone'].toString()}',
                                        style:  TextStyle(color: Colors.black)),
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ):Align(
                alignment: Alignment.topCenter,
                child: Material(
                  child: Container(
                    width: screenWidth * 0.5,
                    color: Colors.blue.shade100,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(5.0),
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              // setState(() {
                              //   selectedPatient = options.toList()[0][index];
                              //   showAutoComplete = false;
                              // });
                            },
                            child: const Card(
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text('Search List Empty'),
                              ),
                            ));
                      },
                    ),
                  ),
                ),
              );
      },
    );
  }

  // renderAutoComplete(screenWidth, screenHeight) {
  //   return Autocomplete<List>(
  //     optionsBuilder: (TextEditingValue textEditingValue) {
  //       if (textEditingValue.text == '') {
  //         return Iterable<List>.empty();
  //       } else {
  //         var matches = [];
  //         matches.addAll(PatientList);
  //         matches.retainWhere((s) {
  //           return s['customer_name']
  //               .toString()
  //               .toLowerCase()
  //               .contains(textEditingValue.text.toLowerCase());
  //         });
  //         this.setState(() {});
  //         return [matches];
  //       }
  //     },
  //     fieldViewBuilder: (BuildContext context,
  //         TextEditingController textEditingController,
  //         FocusNode focusNode,
  //         VoidCallback onFieldSubmitted) {
  //       return TextFormField(
  //           controller: textEditingController,
  //           focusNode: focusNode,
  //           decoration: InputDecoration(
  //               border: OutlineInputBorder(),
  //               // prefix: Icon(Icons.search),
  //               prefixIcon: Icon(Icons.search),
  //               hintText: ' Search Patient Name'),
  //           onFieldSubmitted: (String value) {
  //             onFieldSubmitted();
  //           });
  //     },
  //     optionsViewBuilder: (BuildContext context,
  //         AutocompleteOnSelected<List> onSelected, Iterable<List> options) {
  //       return Align(
  //         alignment: Alignment.topLeft,
  //         child: Material(
  //           child: Container(
  //             width: screenWidth * 0.9,
  //             height: screenHeight * 0.8,
  //             color: Colors.white,
  //             child: ListView.builder(
  //               shrinkWrap: true,
  //               padding: EdgeInsets.all(5.0),
  //               itemCount: options.toList()[0].length,
  //               itemBuilder: (BuildContext context, int index) {
  //                 final option = options.toList()[0].elementAt(index);
  //                 return GestureDetector(
  //                   onTap: () {
  //                     storage.setItem(
  //                         'selectedPatient', options.toList()[0][index]);
  //                     setState(() {
  //                       showAutoComplete = false;
  //                       selectedPatient = options.toList()[0][index];
  //                     });
  //                   },
  //                   child: Card(
  //                     color: Colors.grey,
  //                     // color: custom_color.app_color,
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Padding(
  //                           padding: EdgeInsets.all(8.0),
  //                           child: Text(
  //                               '${options.toList()[0][index]['customer_name'].toString()} , ${options.toList()[0][index]['phone'].toString()}',
  //                               style: TextStyle(color: Colors.black)),
  //                         ),
  //                         // Divider(
  //                         //   thickness: 1,
  //                         // )
  //                       ],
  //                     ),
  //                   ),
  //                 );
  //                 //  GestureDetector(
  //                 //   onTap: () {
  //                 //     storage.setItem(
  //                 //         'selectedPatient', options.toList()[0][index]);
  //                 //     setState(() {
  //                 //       showAutoComplete = false;
  //                 //       selectedPatient = options.toList()[0][index];
  //                 //     });
  //                 //   },
  //                 //   child: Card(
  //                 //     color: Colors.grey,
  //                 //     // color: custom_color.app_color,
  //                 //     child: Column(
  //                 //       crossAxisAlignment: CrossAxisAlignment.start,
  //                 //       children: [
  //                 //         Padding(
  //                 //           padding: EdgeInsets.all(8.0),
  //                 //           child: Text(
  //                 //               '${options.toList()[0][index]['customer_name'].toString()} , ${options.toList()[0][index]['phone'].toString()}',
  //                 //               style: TextStyle(color: Colors.black)),
  //                 //         ),
  //                 //         // Divider(
  //                 //         //   thickness: 1,
  //                 //         // )
  //                 //       ],
  //                 //     ),
  //                 //   ),
  //                 // );
  //               },
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  renderLablistAutoComplete(screenWidth, screenHeight) {
    return Autocomplete<List>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return Iterable<List>.empty();
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
        return options.toList()[0].isNotEmpty ?Align(
          alignment: Alignment.topLeft,
          child: Material(
            child: Container(
              width: screenWidth ,
              // height: screenHeight * 0.4,
              color: Colors.white,
              child: ListView.builder(
                padding: EdgeInsets.all(5.0),
                shrinkWrap: true,
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
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                '${options.toList()[0][index]['pharmacy_name'].toString()} ',
                                style: TextStyle(color: Colors.black)),
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
        ):Align(
                alignment: Alignment.topCenter,
                child: Material(
                  child: Container(
                    width: screenWidth * 0.5,
                    color: Colors.blue.shade100,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(5.0),
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              // setState(() {
                              //   selectedPatient = options.toList()[0][index];
                              //   showAutoComplete = false;
                              // });
                            },
                            child: const Card(
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text('Search List Empty'),
                              ),
                            ));
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
          return Iterable<List>.empty();
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
        return options.toList()[0].isNotEmpty ? Align(
          alignment: Alignment.topLeft,
          child: Material(
            child: Container(
              width: screenWidth ,
              // height: screenHeight * 0.5,
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
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                '${options.toList()[0][index]['test_name'].toString()} ',
                                style: TextStyle(color: Colors.black)),
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
        ):Align(
                alignment: Alignment.topCenter,
                child: Material(
                  child: Container(
                    width: screenWidth * 0.5,
                    color: Colors.blue.shade100,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(5.0),
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              // setState(() {
                              //   selectedPatient = options.toList()[0][index];
                              //   showAutoComplete = false;
                              // });
                            },
                            child: const Card(
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text('Search List Empty'),
                              ),
                            ));
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
          return Iterable<List>.empty();
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
        return options.toList()[0].isNotEmpty ? Align(
          alignment: Alignment.topLeft,
          child: Material(
            child: Container(
              width: screenWidth ,
              // height: screenHeight * 0.4,
              color: Colors.white,
              child: ListView.builder(
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
                        pharmacyshowAutoComplete = false;
                        testshowAutoComplete = true;
                        SelectedPharmacy = options.toList()[0][index];
                        medicineshowAutoComplete = true;
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
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                '${options.toList()[0][index]['pharmacy_name'].toString()} ',
                                style: TextStyle(color: Colors.black)),
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
        ):Align(
                alignment: Alignment.topCenter,
                child: Material(
                  child: Container(
                    width: screenWidth * 0.5,
                    color: Colors.blue.shade100,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(5.0),
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              // setState(() {
                              //   selectedPatient = options.toList()[0][index];
                              //   showAutoComplete = false;
                              // });
                            },
                            child: const Card(
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text('Search List Empty'),
                              ),
                            ));
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
          return Iterable<List>.empty();
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
        return options.toList()[0].isNotEmpty ? Align(
          alignment: Alignment.topLeft,
          child: Material(
            child: Container(
              width: screenWidth ,
              // height: screenHeight * 0.4,
              color: Colors.white,
              child: ListView.builder(
                padding: EdgeInsets.all(5.0),
                itemCount: options.toList()[0].length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final option = options.toList()[0].elementAt(index);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        medicineAdded = false;
                        medicineshowAutoComplete = false;
                        Selectedmedicine = options.toList()[0][index];
                        getMedicineList();
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
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                '${options.toList()[0][index]['name'].toString()} ',
                                style: TextStyle(color: Colors.black)),
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
        ):Align(
                alignment: Alignment.topCenter,
                child: Material(
                  child: Container(
                    width: screenWidth * 0.5,
                    color: Colors.blue.shade100,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(5.0),
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              // setState(() {
                              //   selectedPatient = options.toList()[0][index];
                              //   showAutoComplete = false;
                              // });
                            },
                            child: const Card(
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text('Search List Empty'),
                              ),
                            ));
                      },
                    ),
                  ),
                ),
              );
      },
    );
  }

  renderinjectionlistAutoComplete(screenWidth, screenHeight) {
    return Autocomplete<List>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return Iterable<List>.empty();
        } else {
          var matches = [];
          matches.addAll(InjectionList);
          matches.retainWhere((s) {
            return s['injections_name']
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
                hintText: ' Search Injection Name'),
            onFieldSubmitted: (String value) {
              onFieldSubmitted();
            });
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<List> onSelected, Iterable<List> options) {
        return options.toList()[0].isNotEmpty ? Align(
          alignment: Alignment.topLeft,
          child: Material(
            child: Container(
              width: screenWidth ,
              // height: screenHeight * 0.4,
              color: Colors.white,
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(5.0),
                itemCount: options.toList()[0].length,
                itemBuilder: (BuildContext context, int index) {
                  final option = options.toList()[0].elementAt(index);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        injectionshowautoComplete = false;
                        SelectedInjection =
                            options.toList()[0].elementAt(index);
                        injectionnameController.text = Helper().isvalidElement(
                                SelectedInjection['injections_name'])
                            ? SelectedInjection['injections_name'].toString()
                            : '';

                        // medicineshowAutoComplete = false;
                        // Selectedmedicine = options.toList()[0][index];
                        // // getMedicineList();
                        // medicineController.text =
                        //     Helper().isvalidElement(Selectedmedicine['name'])
                        //         ? Selectedmedicine['name'].toString()
                        //         : '';
                        // priceController.text =
                        //     Helper().isvalidElement(Selectedmedicine['mrp'])
                        //         ? Selectedmedicine['mrp'].toString()
                        //         : '';
                        // // getLabtestNameList();
                      });
                    },
                    child: Card(
                      color: Colors.grey,
                      // color: custom_color.app_color,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                '${options.toList()[0][index]['injections_name'].toString()} ',
                                style: TextStyle(color: Colors.black)),
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
        ):Align(
                alignment: Alignment.topCenter,
                child: Material(
                  child: Container(
                    width: screenWidth * 0.5,
                    color: Colors.blue.shade100,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(5.0),
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              // setState(() {
                              //   selectedPatient = options.toList()[0][index];
                              //   showAutoComplete = false;
                              // });
                            },
                            child: const Card(
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text('Search List Empty'),
                              ),
                            ));
                      },
                    ),
                  ),
                ),
              );
      },
    );
  }
  // date() {
  //                 DateTime pickedDate = await showDatePicker(
  //                     context: context, initialDate: DateTime.now(),
  //                     firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
  //                     lastDate: DateTime(2101)
  //                 );

  //                 if(pickedDate != null ){
  //                     print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
  //                     String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
  //                     print(formattedDate); //formatted date output using intl package =>  2021-03-16
  //                       //you can implement different kind of Date Format here according to your requirement

  //                     setState(() {
  //                        dateinput.text = formattedDate; //set output date to TextField value.
  //                     });
  //                 }else{
  //                     print("Date is not selected");
  //                 }
  //               },
}
