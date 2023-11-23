import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/StaffWidget/Api.dart';
import 'package:nigdoc/AppWidget/StaffWidget/veiw/AddUser.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../../AppWidget/common/Colors.dart'as custom_color;

class StaffList extends StatefulWidget {
  const StaffList({super.key});

  @override
  State<StaffList> createState() => _StaffListState();
}

class _StaffListState extends State<StaffList> {
  final LocalStorage storage = new LocalStorage('doctor_store');
  bool isloading = false;
  var Stafflist;
  var accesstoken;
  @override
  void initState() {
    accesstoken = storage.getItem('userResponse')['access_token'];

    getStafflist();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Dash()),
        );
        return true;
      },
      child: Scaffold(
         appBar: AppBar(title: Text('User List',
              style: TextStyle(color: Colors.white),),
              backgroundColor:custom_color.appcolor,
              leading: IconButton(onPressed: (){
                Navigator.push(
              context, MaterialPageRoute(builder: (context)=> Dash(),)
             );
              }, icon: Icon(Icons.arrow_back,
              color: Colors.white,),),
            
              ),
        // appBar: AppBar(
        //   title: Text('User List'),
        //   backgroundColor: custom_color.appcolor,
        //   // actions: [
        //   //   Padding(
        //   //     padding: const EdgeInsets.all(8.0),
        //   //     child: TextButton(
        //   //         onPressed: () {
        //   //           Navigator.push(
        //   //               context,
        //   //               MaterialPageRoute(
        //   //                 builder: (context) => AddUser(),
        //   //               ));
        //   //         },
        //   //         child: Text(
        //   //           "Add User",
        //   //           style: TextStyle(
        //   //               color: Colors.white,
        //   //               fontSize: 12,
        //   //               fontWeight: FontWeight.bold),
        //   //         ),
        //   //         style: ButtonStyle(
        //   //             backgroundColor:
        //   //                 MaterialStateProperty.all<Color>(Colors.green),
        //   //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //   //                 RoundedRectangleBorder(
        //   //                     borderRadius: BorderRadius.circular(18.0),
        //   //                     side: BorderSide(color: Colors.green))))),
        //   //   ),
        //   // ],
        // ),
        body:isloading? Container(
          
          
            child: Helper().isvalidElement(Stafflist) &&
                              Stafflist.length > 0? 
                              ListView.builder(
              itemCount: Stafflist.length,
              itemBuilder: (BuildContext context, int index) {
                var data = Stafflist[index];
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: index % 2 == 0
                          ? custom_color.lightcolor
                          : Colors.white,
                      width: screenWidth,
                      // height: screenHeight * 0.20,
                      // width: screenWidth * 0.90,
                      // decoration:
                      //     BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: screenWidth * 0.55,
                                    child: Row(
                                      children: [
                                        Text(
                                          'Name :',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text("${data['name'].toString().toUpperCase()}")
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          'Phone :',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text('${data['contact_no'].toString()}')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: screenWidth * 0.55,
                                    child: Row(
                                      children: [
                                        Text(
                                          'Email :',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text('${data['email'].toString()}')
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          'userlevel :',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text('${data['user_type'].toString()}')
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }):Center(child: Text('No Data Found')),
        ):Center(child: SpinLoader(),),
      ),
    );
  }

  getStafflist()async{
    

    Stafflist = await api().getstafflist(accesstoken);
    if (Helper().isvalidElement(Stafflist) &&
        Helper().isvalidElement(Stafflist['status']) &&
        Stafflist['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      Stafflist = Stafflist['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
      this.setState(() {
        isloading = true;
      });
    }
  }
}
