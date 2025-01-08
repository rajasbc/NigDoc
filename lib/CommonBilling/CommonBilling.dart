import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/BillingWidget/Api.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/veiw/Dashboardpage.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:nigdoc/Collections/Collections.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;


class CommonbillingList extends StatefulWidget {
  const CommonbillingList({super.key});

  @override
  State<CommonbillingList> createState() => _CommonbillingListState();
}

class _CommonbillingListState extends State<CommonbillingList> {
  final LocalStorage storage = new LocalStorage('doctor_store');
  final DateFormate = "yyyy-MM-dd";
  TextEditingController fromdateInputController = TextEditingController();
  TextEditingController todateInputController = TextEditingController();
  TextEditingController searchText = TextEditingController();

  DateTime currentDate = DateTime.now();
  Future<void> selectDate(BuildContext context, data) async {
    var checkfield = data;
    // print(data);
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: custom_color.appcolor,
                onPrimary: Colors.white, // <-- SEE HERE
                onSurface: custom_color.appcolor, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: custom_color.appcolor, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        initialDate: currentDate,
        firstDate: DateTime(DateTime.now().year-1, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));


    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
    if (checkfield == "from") {
      // var formatter = new DateFormat('dd-MM-yyyy');
      fromdateInputController.text =
          DateFormat(DateFormate).format(pickedDate!);

      // fromdateInputController.text = pickedDate.toString().split(' ')[0];
      getCommonBillingList();
    } else {
      todateInputController.text = DateFormat(DateFormate).format(pickedDate!);
      // todateInputController.text = pickedDate.toString().split(' ')[0];
      getCommonBillingList();
    }
  }
  var list = 0;
  var accesstoken;
  bool isLoading = false;
  var CommonList;
  List Common_List = [];
  var searchList;

  void initState() {
    super.initState();
    accesstoken = storage.getItem('userResponse')['access_token'];
    fromdateInputController.text = Helper().getCurrentDate();
    todateInputController.text = Helper().getCurrentDate();
    getCommonBillingList();
setState(() {
  isLoading = true;
});
    // print('ddd');
  }

  @override
  Widget build(BuildContext context) {
    // final paidstart = paiddateRange.start;
    // final paidend = paiddateRange.end;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenwidht = MediaQuery.of(context).size.width;
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
        appBar: AppBar(
          title: Text(
            'Common Billing List',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: custom_color.appcolor,
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
        // appBar: AppBar(
        //   title: Text('Paid Bill List'),
        //     backgroundColor: Customcolor.appcolor,
        // ),
        body: isLoading
            ? Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: screenwidht,
                        height: screenHeight * 0.06,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: screenwidht * 0.45,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'From',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  labelText: 'From',
                                  suffixIcon: Icon(
                                    Icons.date_range,
                                    color: custom_color.appcolor,
                                  ),
                                ),
                                controller: fromdateInputController,
                                readOnly: true,
                                onTap: () async {
                                  selectDate(context, 'from');
                                },
                              ),
                            ),
                            Container(
                              width: screenwidht * 0.45,
                              child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'To',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    labelText: 'To',
                                    suffixIcon: Icon(
                                      Icons.date_range,
                                      color: custom_color.appcolor,
                                    ),
                                  ),
                                  controller: todateInputController,
                                  readOnly: true,
                                  onTap: () async {
                                    selectDate(context, 'to');
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 3,
                    ),
                    Center(child: 
                      Container(
                        height: screenHeight * 0.06,
                        width: screenwidht*0.95,
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
                              width: screenwidht * 0.65,
                              child: TextField(
                                controller: searchText,
                                onChanged: (text) {
                                  print(text);
                            filterItems(text);
                                  this.setState(() {});
                                 
                                },
                                decoration: new InputDecoration(
                                  filled: true,
                                  border: InputBorder.none,
                                  fillColor: Colors.white,
                                  hintText: 'Search Name/Mobile List Here...',
                                ),
                              ),
                            ),
                            searchText.text.isNotEmpty
                                ? Container(
                                    width: screenwidht * 0.06,
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
                                width: screenwidht * 0.18,
                                height: screenHeight,
                                child: Icon(Icons.search,
                                    color: custom_color.appcolor,)),
                          ],
                        ),
                      ),),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            // height: screenHeight * 0.7596,
                            child: Helper().isvalidElement(Common_List) &&
                                    Common_List.length > 0
                                ?
                                ListView.builder(
                                    itemCount: Common_List.length,
                                    // itemCount: 10,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var data = Common_List[index];
                                      list=index+1;
                                      return Center(
                                        child: Container(
                                          color: index % 2 == 0
                                              ? Color.fromARGB(
                                                  255, 238, 242, 250)
                                              : Colors.white,
                                          width: screenwidht,
                                          // height: screenHeight * 0.20,
                                          // width: screenWidth * 0.90,
                                          // decoration:
                                          //     BoxDecoration(border: Border.all(color: Colors.grey)),
                                          child: Row(
                                            children: [
                                              Text(' $list. '),
                                              Container(
                                                 width: screenwidht*0.83,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Column(
                                                    children: [
                                                      
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.all(1.0),
                                                        child: Row(
                                                          // mainAxisAlignment:
                                                          //     MainAxisAlignment
                                                          //         .spaceBetween,
                                                          children: [
                                                            Container(
                                                              width: screenwidht * 0.47,
                                                              child: Row(
                                                                children: [
                                                                    Icon(
                                                                    Icons
                                                                        .calendar_month,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            98,
                                                                            96,
                                                                            96),
                                                                  ),
                                                                  Text(
                                                                      '${data['date'].toString().substring(0, 10)}')
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                      'Customer Id : '),
                                                                  Text(
                                                                      '${data['cus_id'].toString()}')
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        //  width: screenwidht * 0.47,
                                                        child: Row(
                                                          children: [
                                                           Text(
                                                                'Name : '),
                                                            Text(
                                                                '${data['customer_name'].toString()}')
                                                          ],
                                                        ),
                                                      ),
                                                    
                                                      Row(
                                                        // mainAxisAlignment:
                                                        //     MainAxisAlignment
                                                        //         .spaceBetween,
                                                        children: [
                                                          Container(
                                                            width: screenwidht * 0.47,
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  'Mobile No : ',
                                                                  // style: TextStyle(
                                                                  //     fontWeight:
                                                                  //         FontWeight.bold,color: Color.fromARGB(255, 54, 50, 50)),
                                                                ),
                                                                Text(
                                                                    '${data['phone'].toString()}')
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  'Age : ',
                                                                  // style: TextStyle(
                                                                  //     fontWeight:
                                                                  //         FontWeight.bold,color: Color.fromARGB(255, 54, 50, 50)),
                                                                ),
                                                                Text(
                                                                    // '${data['discount'].toString()}'
                                                                    '${data['age'].toString()}'
                                                                    )
                                                              ],
                                                            ),
                                                          ),
                                                        
                                                        ],
                                                      ),
                                                       Padding(
                                                        padding:
                                                            const EdgeInsets.all(0.0),
                                                        child: Row(
                                                          // mainAxisAlignment:
                                                          //     MainAxisAlignment
                                                          //         .spaceBetween,
                                                          children: [
                                                            Container(
                                                              width: screenwidht * 0.47,
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    'Total Amt : ',
                                                                    // style: TextStyle(
                                                                    //     fontWeight:
                                                                    //         FontWeight.bold,color: Color.fromARGB(255, 54, 50, 50)),
                                                                  ),
                                                                  Text(
                                                                      '${data['total'].toString()}')
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    'Bal Amt : ',
                                                                    // style: TextStyle(
                                                                    //     fontWeight:
                                                                    //         FontWeight.bold,color: Color.fromARGB(255, 54, 50, 50)),
                                                                  ),
                                                                  Text(
                                                                      // '${data['discount'].toString()}'
                                                                      '${data['balance'].toString()}'
                                                                      )
                                                                ],
                                                              ),
                                                            ),
                                                           
                                                          ],
                                                        ),
                                                      ),
                                                       Container(
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    'Paid Amt :',
                                                                    // style: TextStyle(
                                                                    //     fontWeight:
                                                                    //         FontWeight.bold,color: Color.fromARGB(255, 54, 50, 50)),
                                                                  ),
                                                                  Text(
                                                                      '${data['advance'].toString()}')
                                                                ],
                                                              ),
                                                            )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                                : Center(
                                    child: Text('No Data Found'),
                                  )
                            // :
                            // Text('Nodata'),
                            ),
                      ),
                    )
                  ],
                ),
              )
            : SpinLoader(),
      ),
    );
  }

  getCommonBillingList() async {
    // var formatter = new DateFormat('yyyy-mm-dd');
    var formatter = new DateFormat('yyyy-MM-dd');
    var data = {
      "from_date": fromdateInputController.text.toString(),
      "to_date": todateInputController.text.toString(),
      
    };

   var Common_List = await PatientApi().getCommonBillingList(accesstoken, data);
    if (Helper().isvalidElement(Common_List) &&
        Helper().isvalidElement(Common_List['status']) &&
        Common_List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      CommonList = Common_List['list'];
       filterItems(searchText.text);
      //  storage.setItem('diagnosisList', diagnosisList);
      this.setState(() {
        isLoading = true;
        
      });
    }
  }
  void filterItems(String text) {
    // setState(() {
    if (text.isEmpty) {
      setState(() {
        Common_List = CommonList;
      });
    } 
    else if (text.length >= 3) {
      setState(() {
        Common_List = CommonList.where((item) =>
            item['customer_name']
                .toString()
                .toLowerCase()
                .contains(text.toLowerCase()) ||
            item['phone']
                .toString()
                .toLowerCase()
                .contains(text.toLowerCase())
                ).toList();
      });
    }
  }
}
