import 'package:flutter/material.dart';
import 'package:nigdoc/Api/url.dart';
import 'package:nigdoc/AppWidget/Common/utils.dart';
import 'package:nigdoc/AppWidget/LabLink/LabList.dart';
import 'package:nigdoc/AppWidget/Medicine/AddMedicineList.dart';
import 'package:nigdoc/AppWidget/Shop/Api.dart';
import 'package:nigdoc/AppWidget/Shop/View/ClinicConfiguration.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/main.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;

class Edit_Confiuration extends StatefulWidget {
  const Edit_Confiuration({super.key});

  @override
  State<Edit_Confiuration> createState() => _Edit_ConfiurationState();
}

class _Edit_ConfiurationState extends State<Edit_Confiuration> {
  
  TextEditingController prescriptionController = TextEditingController();
  TextEditingController patientprefixController = TextEditingController();
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


  var accesstoken;
  
  var  clinicconfig;
  bool isloading=false;

@override
void initState(){
  accesstoken=storage.getItem('userResponse')['access_token'];
  getclinicconfig();

  super.initState();
}
  
  @override
  Widget build(BuildContext context) {
    double screenHeight=MediaQuery.of(context).size.height;
    double screenWidth=MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
     onPopInvoked: (didPop) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ClinicConfig()));
     },
     child: Scaffold(
      appBar: AppBar(
        title: Text('Edit Clinic Configuration',
        style: TextStyle(color: Colors.white),),
        leading: IconButton(onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>ClinicConfig()));
        }, icon: Icon(Icons.arrow_back,color: Colors.white,),
        ),
        backgroundColor:custom_color.appcolor ,
      ),
      
              
      body: isloading? SafeArea(
        child: SingleChildScrollView(
          child: Container(
      
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: prescriptionController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Prescription Prefix',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: patientprefixController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Patient Prefix',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: calltokenController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Call Token',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: visittokenController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Visit Token',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: lowqualityController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Low Quality',
                    ),
                  ),
                ),
                SizedBox(height: screenHeight*0.02,),

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
                                       _lablinkSelected = value as int;
                                       _lablinkVal = 'Yes';
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
                                       _lablinkSelected = value as int;
                                       _lablinkVal = 'No';
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
                                       _bloodSelected = value as int;
                                       _bloodVal = 'Yes';
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
                                       _bloodSelected = value as int;
                                       _bloodVal = 'No';
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
                                       _refferedSelected = value as int;
                                       _refferedVal = 'Yes';
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
                                       _refferedSelected = value as int;
                                       _refferedVal = 'No';
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
                                       _bmiSelected = value as int;
                                       _bmiVal = 'Yes';
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
                                       _bmiSelected = value as int;
                                       _bmiVal = 'No';
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
                                       _heightSelected = value as int;
                                       _heightVal = 'Yes';
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
                                       _heightSelected = value as int;
                                       _heightVal = 'No';
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
                                       _weightSelected = value as int;
                                       _weightVal = 'Yes';
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
                                       _weightSelected = value as int;
                                       _weightVal = 'No';
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
                                       _sugarSelected = value as int;
                                       _sugarVal = 'Yes';
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
                                       _sugarSelected = value as int;
                                       _sugarVal = 'No';
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
                                       _pulseSelected = value as int;
                                       _pulseVal = 'Yes';
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
                                       _pulseSelected = value as int;
                                       _pulseVal = 'No';
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
                                       _bpSelected = value as int;
                                       _bpVal = 'Yes';
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
                                       _bpSelected = value as int;
                                       _bpVal = 'No';
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
                                       _tempSelected = value as int;
                                       _tempVal = 'Yes';
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
                                       _tempSelected = value as int;
                                       _tempVal = 'No';
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
                                       _spo2Selected = value as int;
                                       _spo2Val = 'Yes';
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
                                       _spo2Selected = value as int;
                                       _spo2Val = 'No';
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
                                       _medipriceSelected = value as int;
                                       _medipriceVal = 'Yes';
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
                                       _medipriceSelected = value as int;
                                       _medipriceVal = 'No';
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
                                       _patternSelected = value as int;
                                       _patternVal = 'Yes';
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
                                       _patternSelected = value as int;
                                       _patternVal = 'No';
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
                                       _expensesSelected = value as int;
                                       _expensesVal = 'Yes';
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
                                       _expensesSelected = value as int;
                                       _expensesVal = 'No';
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
                                       _appointmentsSelected = value as int;
                                       _appointmentsVal = 'Yes';
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
                                       _appointmentsSelected = value as int;
                                       _appointmentsVal = 'No';
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
                                       _dobSelected = value as int;
                                       _dobVal = 'Yes';
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
                                       _dobSelected = value as int;
                                       _dobVal = 'No';
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
                                       _emailSelected = value as int;
                                       _emailVal = 'Yes';
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
                                       _emailSelected = value as int;
                                       _emailVal = 'No';
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
                                       _recptformtSelected = value as int;
                                       _recptformtVal = 'Yes';
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
                                       _recptformtSelected = value as int;
                                       _recptformtVal = 'No';
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
           SizedBox(height: screenHeight*0.02,),
               
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: feesController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Fees',
                  ),
                 ),
               ),
               SizedBox(height: screenHeight*0.02,),

               Container(width: screenWidth,
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: ElevatedButton(
                    // style: ElevatedButton.styleFrom(
                    //   backgroundColor: custom_color.appcolor,
                    // ),
                      style: ButtonStyle(
                               backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                               shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                       
                               RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(10),
                          
                         
                       ),
                       
                     )
                     
                   ),
                    onPressed: (){
                                 if(prescriptionController.text.isEmpty){
                    NigDocToast().showErrorToast('Enter Prescription Prefix');
                                 }else if(patientprefixController.text.isEmpty){
                    NigDocToast().showErrorToast('Enter Patient Prefix');
                                 }else if(calltokenController.text.isEmpty){
                    NigDocToast().showErrorToast('Enter Call Token');
                                 }else if(visittokenController.text.isEmpty){
                    NigDocToast().showErrorToast('Enter Visit Token');
                                 }else if(lowqualityController.text.isEmpty){
                    NigDocToast().showErrorToast('Enter Low Quality');
                                 }else if(feesController.text.isEmpty){
                    NigDocToast().showErrorToast('Enter Your Fees');
                                 }else{
                    var data={
                      "prescription":prescriptionController.text.toString(),
                       "patient":patientprefixController.text.toString(),
                        "call token":calltokenController.text.toString(),
                         "visit":visittokenController.text.toString(),
                          "low quality":lowqualityController.text.toString(),
                           "fees":feesController.text.toString(),
                   
                   
                   
                    };
                    Helper().isvalidElement(data);
                    print(data);
                                 }
                               
                   
                    }, 
                   child: Text('Update',
                   style: TextStyle(color: Colors.white,
                   fontSize: 20),
                   
                   ),
                   
                   ),
                 ),
               ),
               SizedBox(
                height: screenHeight*0.04,
               )

              ],

            ),
          ),
        ),
      ):Center(child: SpinLoader(),)
     ),
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
      prescriptionController.text = data[0]['bill_prefix'].toString();
      patientprefixController.text = data[0]['patient_prefix'].toString();
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
        isloading = true;
      });
    }
  }

}