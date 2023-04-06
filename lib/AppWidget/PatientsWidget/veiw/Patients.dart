import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
// import 'package:nigdoc/AppWidget/DashboardWidget/veiw/Dashboardpage.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/veiw/PrescriptionPage.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';

import '../../DoctorWidget/Api.dart';
import '../../../AppWidget/common/Colors.dart'as custom_color;

class Patients extends StatefulWidget {
  const Patients({super.key});

  @override
  State<Patients> createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  final LocalStorage storage = new LocalStorage('doctor_store');
  int? _radioSelected = 1;
  String _radioVal = "";

  int? _vacciSelected = 2;
  String _vacciVal = "";

  int? _typeSelected = 1;
  String _typeVal = "";

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
  bool loading = false;
  bool isloading= false;

  String titleDropdownvalue = 'Mr';
  String heightunitDropdownvalue = 'Ft';
  String weightunittDropdownvalue = 'Pounds';
  String tempunitDropdownvalue = '°F';
   String DoctorDropdownvalue = 'Doctor';
  var accesstoken;
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
  var DoctorList;
  var selectedPatient;
  var PatientList;
  bool name=false;

  DateTime currentDate = DateTime.now();
  DateTime selectedDate = DateTime.now();

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

  // @override
  // void initstate() {
  //   super.initState();
  //   referalcontroller.text = 'Self';
  // }
  @override
  void initState() {
    accesstoken = storage.getItem('userResponse')['access_token'];
    getdoctorlist();
    getpatientlist();

    // getdoctorlist();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(onWillPop: () async {
         Navigator.push(
          context, MaterialPageRoute(builder: (context)=> Dash(),)
         );
         return true;
        },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Registration'),
          backgroundColor: custom_color.appcolor,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                //   SizedBox(
                //   height: 10,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: _typeSelected,
                          activeColor: Colors.blue,
                          onChanged: (value) {
                            setState(() {
                              _typeSelected = value as int;
                              _typeVal = 'IN';
                              print(_typeVal);
                            });
                          },
                        ),
                        const Text("IN"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 2,
                          groupValue: _typeSelected,
                          activeColor: Colors.blue,
                          onChanged: (value) {
                            setState(() {
                              _typeSelected = value as int;
                              _typeVal = 'OUT';
                              print(_typeVal);
                            });
                          },
                        ),
                        const Text("OUT"),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        // color: Colors.red,
                        width: screenWidth * 0.95,
                        height: screenHeight * 0.07,
                        decoration:
                            BoxDecoration(border: Border.all(color: Colors.grey)
                                // border: OutlineInputBorder()
                                ),
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                      // name?renderAutoComplete(screenWidth, screenHeight):
                      // Container(
                      //   width: screenWidth * 0.65,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: TextField(
                      //       controller: namecontroller,
    
                      //       // keyboardType: TextInputType.none,
                      //       decoration: InputDecoration(
                      //           border: OutlineInputBorder(),
                      //           labelText: 'Full Name *'),
                      //     ),
                      //   ),
                      // ),
                      
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Autocomplete<List>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text == '') {
                          return  Iterable<List>.empty();
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
                            decoration:  InputDecoration(
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
                  padding:  EdgeInsets.all(5.0),
                  itemCount: options.toList()[0].length,
                  itemBuilder: (BuildContext context, int index) {
                    final option = options.toList()[0].elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        storage.setItem(
                            'selectedcustomer', options.toList()[0][index]);
                             Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PrescriptionPage()),
        );
                        setState(() {
                          // showAutoComplete = false;
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
                            ),
                          ),
                        );
                      },
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
                        border: OutlineInputBorder(), labelText: 'Mobile Number *'),
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
                        border: OutlineInputBorder(), labelText: 'Age *'),
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
                      width: screenWidth * 0.75,
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
                      width: screenWidth * 0.75,
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
                      width: screenWidth * 0.75,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: weightcontroller,
    
                          // keyboardType: TextInputType.none,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: 'Weight'),
                        ),
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.23,
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
                            value: weightunittDropdownvalue,
                            items: weightunit.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
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
                      width: screenWidth * 0.75,
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
                      width: screenWidth * 0.75,
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
                      width: screenWidth * 0.217,
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
                      width: screenWidth * 0.75,
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
                      width: screenWidth * 0.75,
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
                      width: screenWidth * 0.75,
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
                      child:Helper().isvalidElement(DoctorList)&&DoctorList.length>0? DropdownButtonFormField(
                        // validator: (value) => validateDrops(value),
                        // isExpanded: true,
                        decoration: InputDecoration.collapsed(hintText: ''),
                        isExpanded: true,
                        hint: Padding(
                          padding:
                              const EdgeInsets.only(top: 0.0, left: 8, right: 8),
                          child: Text(
                            'Select Doctor *',
                            style: TextStyle(
                                color: Color.fromARGB(255, 112, 107, 107)),
                          ),
                        ),
                        // value:' _selectedState[i]',
                        onChanged: (selecteddoctor) {
                          setState(() {
                            DoctorDropdownvalue=selecteddoctor.toString();
                            // selectedDoctor = selectedDoctor;
                            // print("Stae value");
                            // print(newValue);
                            // _selectedState[i]= newValue;
                            // getMyDistricts(newValue, i);
                          });
                        },
                        items: DoctorList.map<DropdownMenuItem<String>>((item) {
                          return new DropdownMenuItem(
                            child: new Text(item['name'].toString()),
                            value: item['id'].toString(),
                          );
                        }).toList(),
                      ):DropdownButtonFormField(
                                                                // validator: (value) => validateDrops(value),
                                                                // isExpanded: true,
                                                                hint: Text(
                                                                    'No Doctor List'),
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
                        border: OutlineInputBorder(), labelText: 'Fees'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Text(
                        'Vaccination ?',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                      ),
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
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(width: screenWidth,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                              primary: custom_color.appcolor,
                            ),
                        onPressed: () {
                          if (namecontroller.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Please Fill Your Name',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 15.0);
                          } else if (mobilecontroller.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Enter Mobile Number',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 15.0);
                          } else if (mobilecontroller.text.length < 10) {
                            Fluttertoast.showToast(
                                msg: 'Enter Valid Mobile Number',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 15.0);
                          } else if (agecontroller.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Enter Your Age',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 15.0);
                          } else if (DoctorDropdownvalue=='Doctor'||DoctorDropdownvalue.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Please Select Doctor',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 15.0);
                          }else {
                            var patient_details = {
                              "patient_type":Helper().isvalidElement(_typeSelected)&& _typeSelected == 1 ?"IN":"OUT",
                              "patientName": namecontroller.text,
                              "title": titleDropdownvalue.toString(),
                              "alt_phone": alternatemobilecontroller.text,
                              "pincode": pincodecontroller.text,
                              "emailId": emailcontroller.text,
                              "mobileNo": mobilecontroller.text,
                              "gender":Helper().isvalidElement(_radioSelected)&& _radioSelected == 1 ?"Male": _radioSelected==2 ? "Female":"other",
                              "area": areacontroller.text,
                              "city": citycontroller.text,
                              "age": agecontroller.text,
                              "sugar": sugarcontroller.text,
                              "bp": bpcontroller.text,
                              "pulse": pulsecontroller.text,
                              "temp": temmpcontroller.text,
                              "temp_type": tempunitDropdownvalue.toString(),
                              "bmi": bmicontroller.text,
                              "spo": spO2controller.text,
                              "weight": weightcontroller.text,
                              "weight_type": weightunittDropdownvalue.toString(),
                              "height": heightcontroller.text,
                              "height_type": heightunitDropdownvalue.toString(),
                               "typical":"",
                              "vaccine": Helper().isvalidElement(_vacciSelected)&& _vacciSelected == 1 ?"Yes":"No",
                               "vaccine_info":"",
                                 "Reason": reasoncontroller.text,
                              "consulting_fees": consultcontroller.text,
                             "father_name":"",
                               "mother_name":"",
                              "general_fees": feescontroller.text,
                              "blood_grp": bloodgroupcontroller.text,
                              "dob": dobcontroller.text,
                              "doctor_id": DoctorDropdownvalue.toString(),
                              "admit_date":"${(Helper().formateDate1(selectedDate))}",
                            };
                            add_patient(patient_details);
                            var list=patient_details;
                      
                            // add_patient(patient_details);
                          }
                        },
                        child: Text('Register')),
                  ),
                ),
                    SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  add_patient(patient_details)async{
    this.setState(() {
      loading = true;
    });
        var result = await PatientApi().add_patient(accesstoken, patient_details);

         if (Helper().isvalidElement(result) &&
        Helper().isvalidElement(result['status']) &&
        result['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      if (Helper().isvalidElement(result) &&
          Helper().isvalidElement(result['message']) &&
          result['message'] == 'Successfully') {
        Fluttertoast.showToast(
            msg: 'Patient Registered successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 15.0);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PrescriptionPage()),
        );
      }else
      {
         Fluttertoast.showToast(
            msg: 'Please Try Again Later',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 15.0);
      }
      this.setState(() {
        // appointment_list = result['appointment_list'];
      });
    }
    this.setState(() {
      loading = false;
    });
  }

   getdoctorlist() async {
   
   var doctorlist = await api().getdoctorlist(accesstoken);
    if (Helper().isvalidElement(doctorlist) &&
        Helper().isvalidElement(doctorlist['status']) &&
        doctorlist['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      DoctorList = doctorlist['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
      this.setState(() {
        isloading = true;
      });
    }
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
        name=true;
        PatientList = list['Customer_list'];
        isloading = true;
      });
    }
  }

   renderAutoComplete(screenWidth, screenHeight) {
    return Autocomplete<List>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return  Iterable<List>.empty();
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
            decoration:  InputDecoration(
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
                padding:  EdgeInsets.all(5.0),
                itemCount: options.toList()[0].length,
                itemBuilder: (BuildContext context, int index) {
                  final option = options.toList()[0].elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      storage.setItem(
                          'selectedPatient', options.toList()[0][index]);
                      setState(() {
                        // showAutoComplete = false;
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
            ),
          ),
        );
      },
    );
  }
}
