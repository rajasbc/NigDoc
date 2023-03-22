import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/material.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
// import 'package:nigdoc/AppWidget/DashboardWidget/veiw/Dashboardpage.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';

class Prescription extends StatefulWidget {
  const Prescription({super.key});

  @override
  State<Prescription> createState() => _PrescriptionState();
}

class _PrescriptionState extends State<Prescription> {
  TextEditingController searchText=TextEditingController();
  int current_step = 0;
  var searchList;
   int? _radioSelected = 1;
  String _radioVal = "";

  int? _vacciSelected = 2;
  String _vacciVal = "";

  TextEditingController namecontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController alternatemobilecontroller = TextEditingController();
  TextEditingController dobcontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController bloodgroupcontroller = TextEditingController();
  final referalcontroller = TextEditingController(text: "Self");
  TextEditingController bmicontroller = TextEditingController();
  final bmiunitcontroller = TextEditingController(text: "kg/m²");
  TextEditingController heightcontroller = TextEditingController();
  TextEditingController weightcontroller = TextEditingController();
  TextEditingController sugarcontroller = TextEditingController();
  TextEditingController bpcontroller = TextEditingController();
  TextEditingController pulsecontroller = TextEditingController();
  TextEditingController temmpcontroller = TextEditingController();
  final sugarunitcontroller = TextEditingController(text: "mg/dL");
  final bpunitcontroller = TextEditingController(text: "mm/Hg");
  final pulseunitcontroller = TextEditingController(text: "bpm");
  TextEditingController spO2controller = TextEditingController();
  final spo2unitcontroller = TextEditingController(text: "(%)");
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController areacontroller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController pincodecontroller = TextEditingController();
  TextEditingController consultcontroller = TextEditingController();
  TextEditingController reasoncontroller = TextEditingController();
  TextEditingController feescontroller = TextEditingController();

  String titleDropdownvalue = 'Mr';
  String heightunitDropdownvalue = 'Ft';
  String weightunittDropdownvalue = 'Pounds';
  String tempunitDropdownvalue = '°F';

  var title = [
    'Mr',
    'Mrs',
    'Ms',
    'Master',
    'Miss',
    'Smt',
    'Dr',
    'Selvi',
    'B/O',
    // 'Baby or Justborn B/O',
    'Baby',
  ];
  var heightunit = ['Ft', 'Cm', 'In'];
  var weightunit = ['Pounds', 'Kg'];
  var temp = ['°F', '°C', '°K'];
  var doctors = ['Saveetha', 'Sathish'];

  DateTime currentDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1950),
        lastDate: DateTime(2024));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
    dobcontroller.text = pickedDate.toString().split(' ')[0];
  }
  //2 page
  //  TextEditingController searchText = TextEditingController();
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
  // var searchList;
  String treatmentDropdownvalue = 'Select Treatment';
  String patternDropdownvalue = 'pattern';
  String prescriptionDropdownvalue = 'Prescription';
  var select_button = 'treatment';
  var Medicine = 'Medicine';

  var treatment = ['Select Treatment', 'Ferver', 'Head Ache'];
  var pattern = ['pattern', '0-0-0', '1-1-1', '1-0-1'];
  // List pattern = [
  //   {"name": "pattern", "value": "0"},
  //  {"name": "0-0-1", "value": "1"},
  //   {"name": "0-1-0", "value": "2"},
  //  {"name": "0-1-1", "value": "3"},
  //  {"name": "1-0-0", "value": "4"},
  //  {"name": "1-0-1", "value": "5"},
  //  {"name": "1-1-0", "value": "2"},
  //  {"name": "1-1-1", "value": "3"},
  //  {"name": "0-0-2", "value": "2"},
  //  {"name": "0-2-0", "value": "2"},
  //  {"name": "2-0-0", "value": "2"},
  //  {"name": "2-2-0", "value": "4"},
  //  {"name": "0-2-2", "value": "4"},
  //  {"name": "2-0-2", "value": "4"},
  //  {"name": "2-2-2", "value": "6"},
  // ];
  var Prescription = ['Prescription', 'BF', 'AF'];
  List treatmentList = [];
  List testList = [];
  List medicineList = [];

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
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
              backgroundColor: Color.fromARGB(255, 8, 122, 135),
              title: const Text(
                'New Bill',
                style: TextStyle(color: Colors.black),
              ),
              iconTheme: IconThemeData(color: Colors.black),
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
          body: Container(
              height: screenHeight,
              width: screenWidth,
              child: EnhanceStepper(
                physics: const NeverScrollableScrollPhysics(),
                stepIconSize: 25,
                type: StepperType.horizontal,
                horizontalTitlePosition: HorizontalTitlePosition.bottom,
                horizontalLinePosition: HorizontalLinePosition.center,
                currentStep: current_step,
                // physics: ClampingScrollPhysics(),
                steps: [
                  EnhanceStep(
                    title: Text(
                      'Add Customer',
                      style: TextStyle(fontSize: 11),
                    ),
                    content: Container(
                        height: screenHeight * 0.75,
                        // color: Colors.red,
                        width: screenWidth,
                        child: CustomerWidget(screenHeight, screenWidth)),
                    icon: Image(
                      color:
                          current_step == 0 ? Colors.red : Colors.grey.shade200,
                      image: AssetImage(
                        'assets/user.png',
                      ),
                    ),
                  ),
                  EnhanceStep(
                      title: Text('To Bill', style: TextStyle(fontSize: 11)),
                      content: Container(
                        // color: Colors.yellow,
                        width: screenWidth,
                        child: Container(
                            height: screenHeight * 0.75,
                            // color: Colors.red,
                            child: BillWidget(screenHeight, screenWidth)),
                      ),
                      icon: Icon(
                        Icons.file_open_rounded,
                        color: current_step == 1
                            ? Colors.red
                            : Colors.grey.shade200,
                      )),
                  EnhanceStep(
                      title: Text('List', style: TextStyle(fontSize: 11)),
                      content: Container(
                        // color: Colors.yellow,
                        width: screenWidth,
                        child: Container(
                            height: screenHeight * 0.75,
                            // color: Colors.red,
                            child: listWidget(screenHeight, screenWidth)),
                      ),
                      icon: Icon(
                        Icons.file_open_rounded,
                        color: current_step == 2
                            ? Colors.red
                            : Colors.grey.shade200,
                      )),
                  EnhanceStep(
                      title: Text('Status', style: TextStyle(fontSize: 11)),
                      content: Container(
                        // color: Colors.yellow,
                        width: screenWidth,
                        child: Container(
                            height: screenHeight * 0.75,
                            // color: Colors.red,
                            child: StatusWidget(screenHeight, screenWidth)),
                      ),
                      icon: Icon(
                        Icons.file_open_rounded,
                        color: current_step == 3
                            ? Colors.red
                            : Colors.grey.shade200,
                      )),
                ],
                onStepTapped: (index) {
                  setState(() {
                    current_step = index;
                  });
                },
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                  return Container(
                    // color: Colors.amber,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        current_step > 0
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    current_step = current_step - 1;
                                  });
                                },
                                icon: Icon(Icons.arrow_back))
                            : Container(),
                        current_step < 3
                            ? IconButton(
                                onPressed: () {
                                  // if (current_step == 0) {
                                  //   if (selectedMedicineList.length > 0) {
                                  //     setState(() {
                                  //       current_step = current_step + 1;
                                  //     });
                                  //   } else {
                                  //     ZoctorToast().showErrorToast(
                                  //         'Please select medicine');
                                  //   }
                                  // }
                                  // if (current_step == 1) {
                                  //   if (Helper()
                                  //       .isvalidElement(patientDetails)) {
                                  //     setState(() {
                                  //       current_step = current_step + 1;
                                  //     });
                                  //   } else {
                                  //     ZoctorToast().showErrorToast(
                                  //         'Please select patient');
                                  //   }
                                  // }
                                  // if (current_step == 2) {
                                  //   if (Helper()
                                  //       .isvalidElement(homeCollection)) {
                                  //     setState(() {
                                  //       current_step = current_step + 1;
                                  //     });
                                  //   } else {
                                  //     ZoctorToast().showErrorToast(
                                  //         'Please select HomeCollection');
                                  //   }
                                  // }

                                  setState(() {
                                    current_step = current_step + 1;
                                  });
                                },
                                icon: Icon(Icons.arrow_forward))
                            : Container(),
                      ],
                    ),
                  );
                },
              ))),
    );
  }

  CustomerWidget(screenHeight, screenWidth) {
    return Column(children: [
      Expanded(
        child: Container(
          height: screenHeight * 0.75,
          width: screenWidth * 0.99,
          // color: Colors.grey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                 Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      height: screenHeight * 0.08,
                      width: screenWidth,
                      // color:Colors.amber,
                      child: Padding(
                        
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 5, left: 5, right: 5),
                        child: Container(
                          // height: screenHeight * 0.06,
                          width: screenWidth,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Color.fromARGB(255, 8, 122, 135)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(1))),
                          child: Row(
                            children: [
                              Container(
                                  width: screenWidth * 0.1,
                                  height: screenHeight,
                                  child: Icon(Icons.search,
                                      color: Color.fromARGB(255, 8, 122, 135))),
                              Container(
                                width: screenWidth * 0.6,
                                child: TextField(
                                  controller: searchText,
                                  onChanged: (text) {
                                    print(text);

                                    this.setState(() {});

                                    // searchList = StaffList.where((element) {
                                    //   var List =
                                    //       element['name'].toString().toLowerCase();
                                    //   return List.contains(text.toLowerCase());
                                    //   // return true;
                                    // }).toList();
                                    // this.setState(() {});
                                  },
                                  decoration: new InputDecoration(
                                    filled: true,
                                    border: InputBorder.none,
                                    fillColor: Colors.white,
                                    hintText: 'Search Patient list...',
                                  ),
                                ),
                              ),
                              searchText.text.isNotEmpty
                                  ? Container(
                                      width: screenWidth * 0.1,
                                      height: screenHeight,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            searchText.text = '';
                                            searchList = '';
                                          });
                                        },
                                      ))
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    )
            ),
            Container(height: screenHeight*0.03,),
             Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // color: Colors.red,
                      width: screenWidth * 0.26,
                      height: screenHeight * 0.07,
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)
                              // border: OutlineInputBorder()
                              ),
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: DropdownButton(
                            value: titleDropdownvalue,
                            items: title.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                titleDropdownvalue = newValue!;
                                if (titleDropdownvalue == 'Mr') {
                                  _radioSelected = 1;
                                } else if (titleDropdownvalue == 'Mrs') {
                                  _radioSelected = 2;
                                } else if (titleDropdownvalue == 'Miss') {
                                  _radioSelected = 2;
                                } else if (titleDropdownvalue == 'Ms') {
                                  _radioSelected = 2;
                                } else if (titleDropdownvalue == 'Master') {
                                  _radioSelected = 1;
                                } else if (titleDropdownvalue == 'Smt') {
                                  _radioSelected = 3;
                                } else if (titleDropdownvalue == 'Selvi') {
                                  _radioSelected = 2;
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                   Container(
                    width: screenWidth * 0.56,
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: TextField(
                        controller: namecontroller,

                        // keyboardType: TextInputType.none,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Full Nme'),
                      ),
                    ),
                  ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: _radioSelected,
                        activeColor: Colors.blue,
                        onChanged: (value) {
                          setState(() {
                            _radioSelected = value as int;
                            _radioVal = 'Male';
                            print(_radioVal);
                          });
                        },
                      ),
                      const Text("Male"),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 2,
                        groupValue: _radioSelected,
                        activeColor: Colors.blue,
                        onChanged: (value) {
                          setState(() {
                            _radioSelected = value as int;
                            _radioVal = 'Female';
                            print(_radioVal);
                          });
                        },
                      ),
                      const Text("Female"),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 3,
                        groupValue: _radioSelected,
                        activeColor: Colors.blue,
                        onChanged: (value) {
                          setState(() {
                            _radioSelected = value as int;
                            _radioVal = 'Other';
                            print(_radioVal);
                          });
                        },
                      ),
                      const Text("Other"),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: mobilecontroller,
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Mobile Number'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                child: TextField(
                  controller: alternatemobilecontroller,
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Alternate Mobile Number'),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 8.0),
                child: TextField(
                  // obscure/Text: true,
                  keyboardType: TextInputType.none,
                  // maxLength: 3,
                  controller: dobcontroller,
                  onTap: () {
                    selectDate(context);
                  },
                  decoration: InputDecoration(
                    labelText: 'D O B',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: agecontroller,
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Age'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: bloodgroupcontroller,

                  // keyboardType: TextInputType.none,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Blood Group'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  // initialValue: 'Self',
                  controller: referalcontroller,

                  // keyboardType: TextInputType.none,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Reffered By'),
                ),
              ),
              Row(
                children: [
                  Container(
                    width: screenWidth * 0.65,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: bmicontroller,

                        // keyboardType: TextInputType.none,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'BMI'),
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.20,
                    child: TextField(
                      controller: bmiunitcontroller,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // label: Text('hii'),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    width: screenWidth * 0.65,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: heightcontroller,

                        // keyboardType: TextInputType.none,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Height'),
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.20,
                    height: screenHeight * 0.07,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)
                            // border: OutlineInputBorder()
                            ),
                    child: DropdownButtonHideUnderline(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          value: heightunitDropdownvalue,
                          items: heightunit.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              heightunitDropdownvalue = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    width: screenWidth * 0.65,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        controller: weightcontroller,

                        // keyboardType: TextInputType.none,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Weight'),
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.20,
                    height: screenHeight * 0.07,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)
                            // border: OutlineInputBorder()
                            ),
                    child: DropdownButtonHideUnderline(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          value: weightunittDropdownvalue,
                          items: weightunit.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items,style: TextStyle(fontSize: 10),),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              weightunittDropdownvalue = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    width: screenWidth * 0.65,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: sugarcontroller,

                        // keyboardType: TextInputType.none,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Sugar'),
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.20,
                    child: TextField(
                      controller: sugarunitcontroller,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // label: Text('hii'),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    width: screenWidth * 0.65,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: bpcontroller,

                        // keyboardType: TextInputType.none,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Bp'),
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.2,
                    child: TextField(
                      controller: bpunitcontroller,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // label: Text('hii'),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    width: screenWidth * 0.65,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: pulsecontroller,

                        // keyboardType: TextInputType.none,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Pulse'),
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.20,
                    child: TextField(
                      controller: pulseunitcontroller,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // label: Text('hii'),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    width: screenWidth * 0.65,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: temmpcontroller,

                        // keyboardType: TextInputType.none,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Temparature'),
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.20,
                    height: screenHeight * 0.07,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)
                            // border: OutlineInputBorder()
                            ),
                    child: DropdownButtonHideUnderline(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 8, bottom: 8, left: 1.5),
                        child: DropdownButton(
                          value: tempunitDropdownvalue,
                          items: temp.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              tempunitDropdownvalue = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    width: screenWidth * 0.65,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: spO2controller,

                        // keyboardType: TextInputType.none,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'SpO2'),
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.20,
                    child: TextField(
                      controller: spo2unitcontroller,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // label: Text('hii'),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Email Id'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: areacontroller,

                  // keyboardType: TextInputType.none,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Area'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: citycontroller,

                  // keyboardType: TextInputType.none,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'City'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: pincodecontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Pin Code'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: screenHeight * 0.06,
                  width: screenWidth * 0.95,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)
                          // border: OutlineInputBorder()
                          ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      // validator: (value) => validateDrops(value),
                      // isExpanded: true,
                      decoration: InputDecoration.collapsed(hintText: ''),
                      isExpanded: true,
                      hint: Padding(
                        padding: const EdgeInsets.only(top:0.0,left: 0,right: 0),
                        child: Text(
                          'Select Doctor',
                          style: TextStyle(color: Color.fromARGB(255, 112, 107, 107)),
                        ),
                      ),
                      // value:' _selectedState[i]',
                      onChanged: (selecteddoctor) {
                        setState(() {
                          // selectedDoctor = selectedDoctor;
                          // print("Stae value");
                          // print(newValue);
                          // _selectedState[i]= newValue;
                          // getMyDistricts(newValue, i);
                        });
                      },
                      items: doctors.map<DropdownMenuItem<String>>((item) {
                        return new DropdownMenuItem(
                          child: new Text(item),
                          value: item.toString(),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: consultcontroller,

                  // keyboardType: TextInputType.none,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Consulting'),
                ),
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: reasoncontroller,

                  // keyboardType: TextInputType.none,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Reason'),
                ),
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: feescontroller,

                  // keyboardType: TextInputType.none,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Fess'),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Text('Vaccination ?',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                  ),
                  Container(
                    child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: _vacciSelected,
                        activeColor: Colors.blue,
                        onChanged: (value) {
                          setState(() {
                            _vacciSelected = value as int;
                            _vacciVal = 'Yes';
                            print(_vacciVal);
                          });
                        },
                      ),
                      const Text("Yes"),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 2,
                        groupValue: _vacciSelected,
                        activeColor: Colors.blue,
                        onChanged: (value) {
                          setState(() {
                            _vacciSelected = value as int;
                            _vacciVal = 'No';
                            print(_vacciVal);
                          });
                        },
                      ),
                      const Text("No"),
                    ],
                  ),
                ],
              ) ,
                  )
                ],
              ),

            
            
            
            ],
            ),
          ),
        ),
      ),
    ]);
  }

  BillWidget(screenHeight, screenWidth) {
    return Column(children: [
      Container(
        height: screenHeight * 0.75,
        width: screenWidth * 0.99,
        // color: Colors.grey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [  SizedBox(height: 2),
            Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(
                          //   width: 180,
                          //   child: TextFormField(
                          //     decoration: const InputDecoration(
                          //       labelText: 'Fees',
                          //       border: OutlineInputBorder(),
                          //       // icon: Icon(Icons.numbers),
                          //     ),
                          //     controller: fees,
                          //     keyboardType: TextInputType.numberWithOptions(
                          //         decimal: true),
                          //   ),
                          // ),
                         
                          InkWell(
                            child: Container(
                              width: screenWidth * 0.40,
                              height: screenHeight * 0.05,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Colors.white),
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
                              width: screenWidth * 0.40,
                              height: screenHeight * 0.05,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Colors.white),
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
                                // billList();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  select_button == "treatment"?
                  Column(
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Container(
                                  //     width: screenWidth * 0.1,
                                  //     height: screenHeight,
                                  //     child: Icon(Icons.search,
                                  //         color: Color.fromARGB(255, 8, 122, 135))),
                                  Container(
                                    width: screenWidth * 0.7,
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: DropdownButtonFormField(
                                        value: treatmentDropdownvalue,
                                        autovalidateMode: AutovalidateMode.always,
                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty ||
                                              value == "Title") {
                                            return 'please select Title';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          labelText: 'Treatment',
                                          border: OutlineInputBorder(),
                                          //icon: Icon(Icons.numbers),
                                        ),
                                        items: treatment.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            treatmentDropdownvalue = newValue!;
                                          });
                                        },
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                ),
                              ),
                               SizedBox(
                        // width: 100,
                        child: TextButton(
                            onPressed: () async {
                              var data = {
                                "treatment": treatmentDropdownvalue.toString(),
                                "fees": fees.text.toString(),
                              };

                              print(data);

                              print(data);
                              print(treatmentList);
                              print(treatmentList.contains(data));
                              if (treatmentList.contains(data)) {
                                treatmentList.remove(data);
                              } else {
                                treatmentList.add(data);
                              }
                              print(treatmentList);
                              setState(() {
                                fees.clear();
                                treatmentDropdownvalue = 'Select Treatment';
                              });
                            },
                            child: Text(
                              "ADD TREATMENT",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Color.fromARGB(255, 10, 132, 87)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4.0),
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
                      // SizedBox(
                      //   // width: 100,
                      //   child: TextButton(
                      //       onPressed: () async {
                      //         var data = {
                      //           "treatment": treatmentDropdownvalue.toString(),
                      //           "fees": fees.text.toString(),
                      //         };

                      //         print(data);

                      //         print(data);
                      //         print(treatmentList);
                      //         print(treatmentList.contains(data));
                      //         if (treatmentList.contains(data)) {
                      //           treatmentList.remove(data);
                      //         } else {
                      //           treatmentList.add(data);
                      //         }
                      //         print(treatmentList);
                      //         setState(() {
                      //           fees.clear();
                      //           treatmentDropdownvalue = 'Select Treatment';
                      //         });
                      //       },
                      //       child: Text(
                      //         "ADD TREATMENT",
                      //         style: TextStyle(
                      //             color: Colors.white,
                      //             fontSize: 12,
                      //             fontWeight: FontWeight.bold),
                      //       ),
                      //       style: ButtonStyle(
                      //           backgroundColor: MaterialStateProperty.all<Color>(
                      //               Color.fromARGB(255, 10, 132, 87)),
                      //           shape: MaterialStateProperty.all<
                      //                   RoundedRectangleBorder>(
                      //               RoundedRectangleBorder(
                      //                   borderRadius: BorderRadius.circular(4.0),
                      //                   side: BorderSide(color: Colors.blue))))),

                      //   // TextFormField(
                      //   //   decoration: const InputDecoration(
                      //   //     labelText: 'Clinic Notes',
                      //   //     border: OutlineInputBorder(),
                      //   //     //icon: Icon(Icons.numbers),
                      //   //   ),

                      //   //   // controller: addressController,

                      //   // ),
                      // ),
                      Helper().isvalidElement(treatmentList) &&
                              treatmentList.length > 0
                          ? Container(
                              width: screenWidth,
                              child: Text(
                                '  Treatment List :',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            )
                          : Container(),
                      Container(
                          padding: const EdgeInsets.all(5),
                          // height: screenHeight * 0.6,
                          width: screenWidth,
                          child: Helper().isvalidElement(treatmentList)
                              ? ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: treatmentList.length,
                                  itemBuilder: (BuildContext context, int index) {
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
                                                  treatmentList.remove(data);
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
                  ):Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            width: screenWidth,
                            child: Column(
                              children: [
                                SizedBox(
                                  // width: 180,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Lab Name',
                                      border: OutlineInputBorder(),
                                      // icon: Icon(Icons.numbers),
                                    ),
                                    controller: labnameController,
                                    // keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  // width: 180,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Test Name',
                                      border: OutlineInputBorder(),
                                      // icon: Icon(Icons.numbers),
                                    ),
                                    controller: testnameController,
                                    // keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                SizedBox(
                                  width: 100,
                                  child: TextButton(
                                      onPressed: () async {
                                        var test = {
                                          "lab_name":
                                              labnameController.text.toString(),
                                          "test_name": testnameController.text
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
                                          labnameController.clear();
                                          testnameController.clear();
                                        });
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
                     
                  Helper().isvalidElement(testList)&&select_button=='test' && testList.length > 0
                      ? Container(
                          width: screenWidth,
                          child: Text(
                            '  Test List :',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        )
                      : Container(),
                  Container(
                      padding: const EdgeInsets.all(5),
                      // height: screenHeight * 0.6,
                      width: screenWidth,
                      child: Helper().isvalidElement(testList)&&select_button=='test'
                          ? ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: testList.length,
                              itemBuilder: (BuildContext context, int index) {
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
    ]);
  }

  listWidget(screenHeight, screenWidth) {
    return Column(children: [
      Container(
        height: screenHeight * 0.75,
        width: screenWidth * 0.99,
        // color: Colors.grey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
               Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(
                          //   width: 180,
                          //   child: TextFormField(
                          //     decoration: const InputDecoration(
                          //       labelText: 'Fees',
                          //       border: OutlineInputBorder(),
                          //       // icon: Icon(Icons.numbers),
                          //     ),
                          //     controller: fees,
                          //     keyboardType: TextInputType.numberWithOptions(
                          //         decimal: true),
                          //   ),
                          // ),
                         
                          InkWell(
                            child: Container(
                              width: screenWidth * 0.40,
                              height: screenHeight * 0.05,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Colors.white),
                                color: Medicine == "Medicine"
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
                                    color: Medicine == "Medicine"
                                        ? Colors.white
                                        : Colors.blue,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                            onTap: () {
                              this.setState(() {
                                Medicine = "Medicine";
                                // billList();
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              width: screenWidth * 0.40,
                              height: screenHeight * 0.05,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Colors.white),
                                color: Medicine == "injection"
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
                                    color: Medicine == "injection"
                                        ? Colors.white
                                        : Colors.blue,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                            onTap: () {
                              this.setState(() {
                                Medicine = "injection";
                                // billList();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height:5)
            ],
          ),
        ),
      ),
    ]);
  }

  StatusWidget(screenHeight, screenWidth) {
    return Column(children: [
      Container(
        height: screenHeight * 0.75,
        width: screenWidth * 0.99,
        // color: Colors.grey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [],
          ),
        ),
      ),
    ]);
  }
}
