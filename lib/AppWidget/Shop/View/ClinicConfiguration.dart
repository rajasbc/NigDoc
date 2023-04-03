import 'package:flutter/material.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/DoctorWidget/Api.dart';
import 'package:nigdoc/AppWidget/Shop/Api.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../../AppWidget/common/Colors.dart'as custom_color;

class ClinicConfig extends StatefulWidget {
  const ClinicConfig({super.key});

  @override
  State<ClinicConfig> createState() => _ClinicConfigState();
}

class _ClinicConfigState extends State<ClinicConfig> {
  TextEditingController presprefixController = TextEditingController();
  TextEditingController patprefixController = TextEditingController();
  TextEditingController calltokenController = TextEditingController();
  TextEditingController visittokenController = TextEditingController();
  TextEditingController lowqualityController = TextEditingController();
  TextEditingController feesController = TextEditingController();

  int? _lablinkSelected;
  String _lablinkVal = "";

  int? _bloodSelected;
  String _bloodVal = "";
  int? _refferedSelected;
  String _refferedVal = "";
  int? _bmiSelected;
  String _bmiVal = "";
  int? _heightSelected;
  String _heightVal = "";
  int? _weightSelected;
  String _weightVal = "";
  int? _sugarSelected;
  String _sugarVal = "";
  int? _bpSelected;
  String _bpVal = "";
  int? _pulseSelected;
  String _pulseVal = "";
  int? _tempSelected;
  String _tempVal = "";
  int? _spo2Selected;
  String _spo2Val = "";
  int? _medipriceSelected;
  String _medipriceVal = "";
  int? _patternSelected;
  String _patternVal = "";
  int? _expensesSelected;
  String _expensesVal = "";
  int? _appointmentsSelected;
  String _appointmentsVal = "";
  int? _dobSelected;
  String _dobVal = "";
  int? _emailSelected;
  String _emailVal = "";
  int? _recptformtSelected;
  String _recptformtVal = "";

  var prespageconfig = [
    'PageFormat 1',
    'PageFormat 2',
    'PageFormat 3',
  ];
  var accesstoken;
  var clinicconfig;
  bool isLoading = false;
  @override
  void initState() {
    accesstoken = storage.getItem('userResponse')['access_token'];

    // getdoctorlist();
    getclinicconfig();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Dash(),
            ));
        return true;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              'Clinic Configuration',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor:custom_color.appcolor,
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Dash(),
                    ));
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          body:isLoading? Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      readOnly: true,
                      controller: presprefixController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Prescription Prefix'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      readOnly: true,
                      controller: patprefixController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Patient Prefix'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      readOnly: true,
                      controller: calltokenController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Call Token'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      readOnly: true,
                      controller: visittokenController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Visit Token'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      readOnly: true,
                      controller: lowqualityController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Low Quality'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: screenWidth * 0.50,
                        child: Text(
                          'Lab Link',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
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
                                  groupValue: _lablinkSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _lablinkSelected = value as int;
                                      // _lablinkVal = 'Yes';
                                      print(_lablinkVal);
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
                                  groupValue: _lablinkSelected,
                                  activeColor: Color.fromRGBO(33, 150, 243, 1),
                                  onChanged: (value) {
                                    setState(() {
                                      // _lablinkSelected = value as int;
                                      // _lablinkVal = 'No';
                                      print(_lablinkVal);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: screenWidth * 0.50,
                        child: Text(
                          'Blood Group',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
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
                                  groupValue: _bloodSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _bloodSelected = value as int;
                                      // _bloodVal = 'Yes';
                                      print(_bloodVal);
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
                                  groupValue: _bloodSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _bloodSelected = value as int;
                                      // _bloodVal = 'No';
                                      print(_bloodVal);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: screenWidth * 0.50,
                        child: Text(
                          'Reffered',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
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
                                  groupValue: _refferedSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _refferedSelected = value as int;
                                      // _refferedVal = 'Yes';
                                      print(_refferedVal);
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
                                  groupValue: _refferedSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _refferedSelected = value as int;
                                      // _refferedVal = 'No';
                                      print(_refferedVal);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: screenWidth * 0.50,
                        child: Text(
                          'BMI',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
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
                                  groupValue: _bmiSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _bmiSelected = value as int;
                                      // _bmiVal = 'Yes';
                                      print(_bmiVal);
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
                                  groupValue: _bmiSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _bmiSelected = value as int;
                                      // _bmiVal = 'No';
                                      print(_bmiVal);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: screenWidth * 0.50,
                        child: Text(
                          'Height',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
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
                                  groupValue: _heightSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _heightSelected = value as int;
                                      // _heightVal = 'Yes';
                                      print(_heightVal);
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
                                  groupValue: _heightSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _heightSelected = value as int;
                                      // _heightVal = 'No';
                                      print(_heightVal);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: screenWidth * 0.50,
                        child: Text(
                          'Weight',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
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
                                  groupValue: _weightSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _weightSelected = value as int;
                                      // _weightVal = 'Yes';
                                      print(_weightVal);
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
                                  groupValue: _weightSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _weightSelected = value as int;
                                      // _weightVal = 'No';
                                      print(_weightVal);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: screenWidth * 0.50,
                        child: Text(
                          'Sugar',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
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
                                  groupValue: _sugarSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _sugarSelected = value as int;
                                      // _sugarVal = 'Yes';
                                      print(_sugarVal);
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
                                  groupValue: _sugarSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _sugarSelected = value as int;
                                      // _sugarVal = 'No';
                                      print(_sugarVal);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: screenWidth * 0.50,
                        child: Text(
                          'Pulse',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
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
                                  groupValue: _pulseSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _pulseSelected = value as int;
                                      // _pulseVal = 'Yes';
                                      print(_pulseVal);
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
                                  groupValue: _pulseSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _pulseSelected = value as int;
                                      // _pulseVal = 'No';
                                      print(_pulseVal);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: screenWidth * 0.50,
                        child: Text(
                          'BP',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
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
                                  groupValue: _bpSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _bpSelected = value as int;
                                      // _bpVal = 'Yes';
                                      print(_bpVal);
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
                                  groupValue: _bpSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _bpSelected = value as int;
                                      // _bpVal = 'No';
                                      print(_bpVal);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: screenWidth * 0.50,
                        child: Text(
                          'Temparature',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
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
                                  groupValue: _tempSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _tempSelected = value as int;
                                      // _tempVal = 'Yes';
                                      print(_tempVal);
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
                                  groupValue: _tempSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _tempSelected = value as int;
                                      // _tempVal = 'No';
                                      print(_tempVal);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: screenWidth * 0.50,
                        child: Text(
                          'spO2',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
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
                                  groupValue: _spo2Selected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _spo2Selected = value as int;
                                      // _spo2Val = 'Yes';
                                      print(_spo2Val);
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
                                  groupValue: _spo2Selected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _spo2Selected = value as int;
                                      // _spo2Val = 'No';
                                      print(_spo2Val);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: screenWidth * 0.50,
                        child: Text(
                          'Medicine with price',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
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
                                  groupValue: _medipriceSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _medipriceSelected = value as int;
                                      // _medipriceVal = 'Yes';
                                      print(_medipriceVal);
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
                                  groupValue: _medipriceSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _medipriceSelected = value as int;
                                      // _medipriceVal = 'No';
                                      print(_medipriceVal);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: screenWidth * 0.50,
                        child: Text(
                          'Patterns',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
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
                                  groupValue: _patternSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _patternSelected = value as int;
                                      // _patternVal = 'Yes';
                                      print(_patternVal);
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
                                  groupValue: _patternSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _patternSelected = value as int;
                                      // _patternVal = 'No';
                                      print(_patternVal);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: screenWidth * 0.50,
                        child: Text(
                          'Expenses',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
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
                                  groupValue: _expensesSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _expensesSelected = value as int;
                                      // _expensesVal = 'Yes';
                                      print(_expensesVal);
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
                                  groupValue: _expensesSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _expensesSelected = value as int;
                                      // _expensesVal = 'No';
                                      print(_expensesVal);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: screenWidth * 0.50,
                        child: Text(
                          'Appointments',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
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
                                  groupValue: _appointmentsSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _appointmentsSelected = value as int;
                                      // _appointmentsVal = 'Yes';
                                      print(_appointmentsVal);
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
                                  groupValue: _appointmentsSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _appointmentsSelected = value as int;
                                      // _appointmentsVal = 'No';
                                      print(_appointmentsVal);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: screenWidth * 0.50,
                        child: Text(
                          'Date Of Birth',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
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
                                  groupValue: _dobSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _dobSelected = value as int;
                                      // _dobVal = 'Yes';
                                      print(_dobVal);
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
                                  groupValue: _dobSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _dobSelected = value as int;
                                      // _dobVal = 'No';
                                      print(_dobVal);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: screenWidth * 0.50,
                        child: Text(
                          'Email',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
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
                                  groupValue: _emailSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _emailSelected = value as int;
                                      // _emailVal = 'Yes';
                                      print(_emailVal);
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
                                  groupValue: _emailSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _emailSelected = value as int;
                                      // _emailVal = 'No';
                                      print(_emailVal);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: screenWidth * 0.50,
                        child: Text(
                          'Receipt Format',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
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
                                  groupValue: _recptformtSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _recptformtSelected = value as int;
                                      // _recptformtVal = 'Yes';
                                      print(_recptformtVal);
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
                                  groupValue: _recptformtSelected,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      // _recptformtSelected = value as int;
                                      // _recptformtVal = 'No';
                                      print(_recptformtVal);
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      readOnly: true,
                      controller: feesController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Fees'),
                    ),
                  ),
                  SizedBox(height: 20,)
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //     height: screenHeight * 0.06,
                  //     width: screenWidth * 0.95,
                  //     decoration:
                  //         BoxDecoration(border: Border.all(color: Colors.grey)
                  //             // border: OutlineInputBorder()
                  //             ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: DropdownButtonFormField(
                  //         // validator: (value) => validateDrops(value),
                  //         // isExpanded: true,
                  //         decoration: InputDecoration.collapsed(hintText: ''),
                  //         isExpanded: true,
                  //         hint: Padding(
                  //           padding: const EdgeInsets.only(
                  //               top: 0, left: 8, right: 8),
                  //           child: Text(
                  //             'Prescription Page Config',
                  //             style: TextStyle(
                  //                 color: Color.fromARGB(255, 112, 107, 107)),
                  //           ),
                  //         ),
                  //         // value:' _selectedState[i]',
                  //         onChanged: (selecteddoctor) {
                  //           setState(() {
                  //             // selectedDoctor = selectedDoctor;
                  //             // print("Stae value");
                  //             // print(newValue);
                  //             // _selectedState[i]= newValue;
                  //             // getMyDistricts(newValue, i);
                  //           });
                  //         },
                  //         items: prespageconfig
                  //             .map<DropdownMenuItem<String>>((item) {
                  //           return new DropdownMenuItem(
                  //             child: new Text(item),
                  //             value: item.toString(),
                  //           );
                  //         }).toList(),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // ElevatedButton(onPressed: () {}, child: Text('Update'))
                ],
              ),
            ),
          ):Center(child: SpinLoader(),)),
    );
  }

  getclinicconfig() async {
   

    clinicconfig = await ShopApi().getclinicconfig(accesstoken);
    if (Helper().isvalidElement(clinicconfig) &&
        Helper().isvalidElement(clinicconfig['status']) &&
        clinicconfig['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      var data = clinicconfig['list'];

      //  storage.setItem('diagnosisList', diagnosisList);
      presprefixController.text = data[0]['bill_prefix'].toString();
      patprefixController.text = data[0]['patient_prefix'].toString();
      calltokenController.text = data[0]['call_tkn'].toString();
      visittokenController.text = data[0]['visit_tkn'].toString();
      lowqualityController.text = data[0]['low_quantity'].toString();
      data[0]['required_lablink'].toString().toLowerCase() == "yes"
          ? _lablinkSelected = 1
          : _lablinkSelected = 2;
      data[0]['required_blood_group'].toString().toLowerCase() == "yes"
          ? _bloodSelected = 1
          : _bloodSelected = 2;
      data[0]['required_referred'].toString().toLowerCase() == "yes"
          ? _refferedSelected = 1
          : _refferedSelected = 2;
      data[0]['required_bmi'].toString().toLowerCase() == "yes"
          ? _bmiSelected = 1
          : _bmiSelected = 2;

      data[0]['required_height'].toString().toLowerCase() == "yes"
          ? _heightSelected = 1
          : _heightSelected = 2;

      data[0]['required_weightlink'].toString().toLowerCase() == "yes"
          ? _weightSelected = 1
          : _weightSelected = 2;

      data[0]['required_sugar'].toString().toLowerCase() == "yes"
          ? _sugarSelected = 1
          : _sugarSelected = 2;

      data[0]['required_pulse'].toString().toLowerCase() == "yes"
          ? _pulseSelected = 1
          : _pulseSelected = 2;

      data[0]['required_bplink'].toString().toLowerCase() == "yes"
          ? _bpSelected = 1
          : _bpSelected = 2;

      data[0]['required_temp'].toString().toLowerCase() == "yes"
          ? _tempSelected = 1
          : _tempSelected = 2;

      data[0]['required_sp'].toString().toLowerCase() == "yes"
          ? _spo2Selected = 1
          : _spo2Selected = 2;

      data[0]['medicine_price'].toString().toLowerCase() == "yes"
          ? _medipriceSelected = 1
          : _medipriceSelected = 2;

      data[0]['pattern_modal'].toString().toLowerCase() == "yes"
          ? _patternSelected = 1
          : _patternSelected = 2;

      data[0]['expenses'].toString().toLowerCase() == "yes"
          ? _expensesSelected = 1
          : _expensesSelected = 2;

      data[0]['appoinment'].toString().toLowerCase() == "yes"
          ? _appointmentsSelected = 1
          : _appointmentsSelected = 2;

      data[0]['required_dob'].toString().toLowerCase() == "yes"
          ? _dobSelected = 1
          : _dobSelected = 2;

      data[0]['required_mail'].toString().toLowerCase() == "yes"
          ? _emailSelected = 1
          : _emailSelected = 2;

      data[0]['required_receipt'].toString().toLowerCase() == "yes"
          ? _recptformtSelected = 1
          : _recptformtSelected = 2;

      feesController.text = data[0]['fees'].toString();
      this.setState(() {
        isLoading = true;
      });
    }
  }
}