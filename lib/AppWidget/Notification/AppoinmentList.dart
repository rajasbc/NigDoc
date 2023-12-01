import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/Common/utils.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/DashboardApi.dart';
import 'package:nigdoc/AppWidget/VideoCall/api_call.dart';
import 'package:nigdoc/AppWidget/VideoCall/meeting_screen.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;

class AppointmentList extends StatefulWidget {
  const AppointmentList({super.key});

  @override
  State<AppointmentList> createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  final LocalStorage storage = new LocalStorage('doctor_store');
  final GlobalKey slide = GlobalKey();

  var appoinmentList = null;
  late DateTime date;
  var date1 = DateTime.now();

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day - 7),
    end:
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
  );
  var tab_items = ['Active', 'Fixed', 'Cancel'];
  var active_tab = 'Active';
  var isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() async {
    await getAppoinmentList();
    //   WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   ShowCaseWidget.of(context).startShowCase([slide]);
    // });
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp){
    //   ShowCaseWidget.of(context).startShowCase([slide]);
    // });
  }

  getAppoinmentList() async {
    var formatter = new DateFormat('yyyy-MM-dd');
    var data = {
      'clinic_type':storage.getItem('userResponse')['clinic_type'].toString().toLowerCase(),
      'doctor_id': storage.getItem('userResponse')['clinic_type'] == "Admin"
          ? storage.getItem('userResponse')['clinic_profile']['uid'].toString()
          : storage.getItem('userResponse')['clinic_profile']['id'].toString(),
      'shop_id': storage.getItem('userResponse')['clinic_type'] == "Admin"
          ? storage.getItem('userResponse')['clinic_profile']['id'].toString()
          : storage
              .getItem('userResponse')['clinic_profile']['shop_id']
              .toString(),
      'type': active_tab,
      'from': formatter.format(dateRange.start),
      'to': formatter.format(dateRange.end),
    };
    var result = await DashboardApi().eachDoctorAppoinmentList(data);
    setState(() {
      appoinmentList = result['result'];
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
            'Appointments',
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
        //   title: Text('Appoinments'),
        //   backgroundColor:custom_color.appcolor ,
        // ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Helper().isvalidElement(appoinmentList)
                    ? Column(
                        children: [
                          renderDatePicker(),
                          renderTabs(),
                          isLoading
                              ? Container(
                                  height: screenHeight * 0.75,
                                  child: Center(child: const SpinLoader()))
                              : renderAppoinmentsList(),
                        ],
                      )
                    : Container(
                        height: screenHeight * 0.85,
                        child: Center(child: const SpinLoader())))),
      ),
    );
  }

  Widget renderAppoinmentsList() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return appoinmentList.length > 0
        ? Container(
            height: screenHeight * 0.75,
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(5.0),
              itemCount: appoinmentList.length,
              itemBuilder: (
                BuildContext context,
                int index,
              ) {
                // index ==0 ?listitems(index):nonlistitems(index);

                var data = appoinmentList[index];
                var demo = date1;
                var formatter = new DateFormat('yyyy-MM-dd');
                var currentDate = formatter.format(demo);
                return
                    // Slidable(
                    //     // Specify a key if the Slidable is dismissible.
                    //     key: const ValueKey(0),
                    //     endActionPane: ActionPane(
                    //       motion: const StretchMotion(),
                    //       // dismissible: DismissiblePane(onDismissed: () {}),
                    //       children: [
                    //         SlidableAction(
                    //           // An action can be bigger than the others.
                    //           flex: 1,
                    //           onPressed: (e) async {
                    //             await appointmentApprove_Cancel(data, "Fixed");
                    //             await getAppoinmentList();
                    //             setState(() {
                    //               active_tab = "Active";
                    //               isLoading = false;
                    //             });
                    //             // var formatter = new DateFormat('yyyy-MM-dd');
                    //             // getAppoinmentList(formatter.format(dateRange.start),
                    //             //     formatter.format(dateRange.end));
                    //           },
                    //           backgroundColor: Color(0xFF7BC043),
                    //           foregroundColor: Colors.white,
                    //           // icon: Icons.archive,
                    //           label: 'Accept',
                    //         ),
                    //         SlidableAction(
                    //           flex: 1,
                    //           onPressed: (e) async {
                    //             setState(() {
                    //               active_tab = "Cancel";
                    //               isLoading = true;
                    //             });
                    //             await appointmentApprove_Cancel(data, "Cancel");
                    //             await getAppoinmentList();
                    //             setState(() {
                    //               active_tab = "Cancel";
                    //               isLoading = false;
                    //             });
                    //           },
                    //           backgroundColor: Color(0xFF0392CF),
                    //           foregroundColor: Colors.white,
                    //           // icon: Icons.save,
                    //           label: 'Cancel',
                    //         ),
                    //       ],
                    //     ),
                    // child:
                    Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                          // offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    // elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              data[
                                                              'patient_name']
                                                          .toString()
                                                          .length >
                                                      12
                                                  ? data['patient_name']
                                                          .toString()
                                                          .substring(0, 12) +
                                                      '...'
                                                  : data['patient_name']
                                                      .toString(),
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(data['phone'],
                                                style: TextStyle(
                                                  fontSize: 14,
                                                )),
                                            Text('Age: ' + data['age'],
                                                style: TextStyle(
                                                  fontSize: 14,
                                                )),
                                            active_tab == "Fixed" &&
                                                    data['appointment_link'] !=
                                                        '' &&
                                                    currentDate ==
                                                        data[
                                                            'appointment_date'] &&
                                                    data['tkn_status']
                                                            .toString()
                                                            .toLowerCase() ==
                                                        'video'
                                                ? InkWell(
                                                    onTap: () {
                                                      String meetingId = data[
                                                              'appointment_link']
                                                          .toString();
                                                      var re = RegExp(
                                                          "\\w{4}\\-\\w{4}\\-\\w{4}");
                                                      // check meeting id is not null or invaild
                                                      // if meeting id is vaild then navigate to MeetingScreen with meetingId,token
                                                      if (meetingId
                                                              .isNotEmpty &&
                                                          re.hasMatch(
                                                              meetingId)) {
                                                        // _meetingIdController.clear();
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                MeetingScreen(
                                                              meetingId:
                                                                  meetingId,
                                                              token: token,
                                                            ),
                                                          ),
                                                        );
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                          content: Text(
                                                              "Please enter valid meeting id"),
                                                        ));
                                                      }
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.videocam,
                                                            color: custom_color
                                                                .appcolor,
                                                            size: 30),
                                                      ],
                                                    ))
                                                : active_tab == "Fixed" &&
                                                        data['phone'] != "" &&
                                                        currentDate ==
                                                            data[
                                                                'appointment_date'] &&
                                                        data['tkn_status']
                                                                .toString()
                                                                .toLowerCase() ==
                                                            'call'
                                                    ? InkWell(
                                                        onTap: ()async {
                                                                  String telephoneUrl =
                                                  "tel:${data["phone"]}";
                                              if (await launch(telephoneUrl)) {
                                                await launch(telephoneUrl);
                                              } else {
                                                throw "Error occured trying to call that number.";
                                              }
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.call,
                                                                color:
                                                                    custom_color
                                                                        .appcolor,
                                                                size: 30),
                                                          ],
                                                        ))
                                                    : Text('')
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              data['appointment_date']
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(data['appointment_time'],
                                                style: TextStyle(
                                                  fontSize: 12,
                                                )),
                                            Text(data['tkn_status'].toString(),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                )),
                                            // Text(data['status'],
                                            //     style: TextStyle(
                                            //       fontSize: 14,
                                            //     )),
                                          ],
                                        ),
                                      ),
                                       Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [Text('Doctor Name: '),
                                                Text(data['doctor_name'].toString(),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                           
                                           
                                            Text(data['status'],
                                                style: TextStyle(
                                                  fontSize: 14,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              active_tab == "Active"
                                  ? Container(
                                      child: PopupMenuButton(
                                        // elevation: 10,
                                        // icon: Icon(Icons.add),
                                        onSelected: (item) async {
                                          print(item);
                                          if (item == 'accept') {
                                            await appointmentApprove_Cancel(
                                                data, "Fixed");
                                            await getAppoinmentList();
                                            setState(() {
                                              active_tab = "Active";
                                              isLoading = false;
                                            });
                                          } else if (item == 'cancel') {
                                            setState(() {
                                              active_tab = "Cancel";
                                              isLoading = true;
                                            });
                                            await appointmentApprove_Cancel(
                                                data, "Cancel");
                                            await getAppoinmentList();
                                            setState(() {
                                              active_tab = "Cancel";
                                              isLoading = false;
                                            });
                                          }
                                        },
                                        itemBuilder: (context) {
                                          return <PopupMenuEntry<String>>[
                                            PopupMenuItem(
                                                value: "accept",
                                                child: Text('Accept')),
                                            const PopupMenuItem(
                                                value: "cancel",
                                                child: Text('Cancel')),
                                            //  PopupMenuItem(
                                            // child: Text('Delete'), value: "delete"),
                                          ];
                                        },
                                      ),
                                    )
                                  : Container(),
                            ],
                          )),
                    ),
                  ),
                );
                // );
              },
            ),
          )
        : Container(
            height: screenHeight * 0.85,
            child: Center(child: Text('No Appoinments')));
  }

  Widget renderDatePicker() {
    final start = dateRange.start;
    final end = dateRange.end;
    double screenwidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        height: screenHeight * 0.07,
        width: screenwidth * 0.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: screenwidth * 0.45,
              child: Row(
                children: [
                  Container(
                    width: screenwidth * 0.10,
                    child: Text('From:'),
                  ),
                  Container(
                      // width: screenwidth * 0.30,
                      child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            custom_color.appcolor)),
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await pickDateRange();
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: Text(
                      '${start.year}/${start.month}/${start.day}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ))
                ],
              ),
            ),
            Container(
              width: screenwidth * 0.45,
              child: Row(
                children: [
                  Container(
                    width: screenwidth * 0.07,
                    child: Text('To:'),
                  ),
                  Container(
                    // width: screenwidth * 0.30,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              custom_color.appcolor)),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await pickDateRange();
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Text('${end.year}/${end.month}/${end.day}',
                          style: TextStyle(color: Colors.white)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget renderTabs() {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.06,
      width: screenwidth * 0.95,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: tab_items.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              setState(() {
                active_tab = tab_items[index];
                isLoading = true;
              });
              await getAppoinmentList();
              setState(() {
                isLoading = false;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: new Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: custom_color.appcolor,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: active_tab == tab_items[index]
                        ? custom_color.appcolor
                        : Colors.white),
                width: screenwidth * 0.30,
                child: new Text(
                  tab_items[index],
                  style: TextStyle(
                      color: active_tab == tab_items[index]
                          ? Colors.white
                          : custom_color.appcolor,
                      fontSize: 16),
                ),
                alignment: Alignment.center,
              ),
            ),
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: custom_color.appcolor, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: custom_color.appcolor, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    setState(() {
      dateRange = newDateRange ?? dateRange;
    });
    await getAppoinmentList();
  }

  appointmentApprove_Cancel(data, type) async {
    if (type == "Fixed"&&data['tkn_status'].toString().toLowerCase()=='video') {
      await createMeeting().then((meetingId) async {
        var details = {
          "id": data['appointment_id'].toString(),
          "patient_id": data['patient_id'].toString(),
          'doctor_id': storage.getItem('userResponse')['clinic_type'] == "Admin"
              ? storage
                  .getItem('userResponse')['clinic_profile']['uid']
                  .toString()
              : storage
                  .getItem('userResponse')['clinic_profile']['id']
                  .toString(),
          'shop_id': storage.getItem('userResponse')['clinic_type'] == "Admin"
              ? storage
                  .getItem('userResponse')['clinic_profile']['id']
                  .toString()
              : storage
                  .getItem('userResponse')['clinic_profile']['shop_id']
                  .toString(),
          "type": type,
          "link": meetingId
        };
        print(details);
        var result = await DashboardApi().appointmnetFixbyDoctor(details);
        print(result);
        NigDocToast()
            .showSuccessToast("Appointment ${result['message']} successfully");
      });
    } else {
      var details = {
        "id": data['appointment_id'].toString(),
        "patient_id": data['patient_id'].toString(),
        'doctor_id': storage.getItem('userResponse')['clinic_type'] == "Admin"
            ? storage
                .getItem('userResponse')['clinic_profile']['uid']
                .toString()
            : storage
                .getItem('userResponse')['clinic_profile']['id']
                .toString(),
        'shop_id': storage.getItem('userResponse')['clinic_type'] == "Admin"
            ? storage.getItem('userResponse')['clinic_profile']['id'].toString()
            : storage
                .getItem('userResponse')['clinic_profile']['shop_id']
                .toString(),
        "type": type,
        "link": ''
      };
      var result = await DashboardApi().appointmnetFixbyDoctor(details);
      NigDocToast()
          .showSuccessToast("Appointment ${result['message']} successfully");
    }
  }

  listitems(int index) {
    var data = appoinmentList[index];
    var demo = date1;
    var formatter = new DateFormat('yyyy-MM-dd');
    var currentDate = formatter.format(demo);
    return Slidable(
        // Specify a key if the Slidable is dismissible.
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          // dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            SlidableAction(
              // An action can be bigger than the others.
              flex: 1,
              onPressed: (e) async {
                await appointmentApprove_Cancel(data, "Fixed");
                await getAppoinmentList();
                setState(() {
                  active_tab = "Active";
                  isLoading = false;
                });
                // var formatter = new DateFormat('yyyy-MM-dd');
                // getAppoinmentList(formatter.format(dateRange.start),
                //     formatter.format(dateRange.end));
              },
              backgroundColor: Color(0xFF7BC043),
              foregroundColor: Colors.white,
              // icon: Icons.archive,
              label: 'Accept',
            ),
            SlidableAction(
              flex: 1,
              onPressed: (e) async {
                setState(() {
                  active_tab = "Cancel";
                  isLoading = true;
                });
                await appointmentApprove_Cancel(data, "Cancel");
                await getAppoinmentList();
                setState(() {
                  active_tab = "Cancel";
                  isLoading = false;
                });
              },
              backgroundColor: Color(0xFF0392CF),
              foregroundColor: Colors.white,
              // icon: Icons.save,
              label: 'Cancel',
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
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
                  // offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            // elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data['patient_name'].toString().length > 12
                                    ? data['patient_name']
                                            .toString()
                                            .substring(0, 12) +
                                        '...'
                                    : data['patient_name'].toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Text(data['phone'],
                                  style: TextStyle(
                                    fontSize: 14,
                                  )),
                              Text('Age: ' + data['age'],
                                  style: TextStyle(
                                    fontSize: 14,
                                  )),
                              active_tab == "Fixed" &&
                                      data['appointment_link'] != '' &&
                                      currentDate == data['appointment_date']
                                  ? Showcase(
                                      key: slide,
                                      description: 'slide to accept or cancel',
                                      title: "<- slide the tab",
                                      child: InkWell(
                                          onTap: () {
                                            String meetingId =
                                                data['appointment_link'];
                                            var re = RegExp(
                                                "\\w{4}\\-\\w{4}\\-\\w{4}");
                                            // check meeting id is not null or invaild
                                            // if meeting id is vaild then navigate to MeetingScreen with meetingId,token
                                            if (meetingId.isNotEmpty &&
                                                re.hasMatch(meetingId)) {
                                              // _meetingIdController.clear();
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MeetingScreen(
                                                    meetingId: meetingId,
                                                    token: token,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Please enter valid meeting id"),
                                              ));
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              Icon(Icons.videocam,
                                                  color: custom_color.appcolor,
                                                  size: 30),
                                            ],
                                          )),
                                    )
                                  : Showcase(
                                      key: slide,
                                      description: 'slide to accept or cancel',
                                      title: "<- slide the tab",
                                      child: Text(''))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data['appointment_date'].toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Text(data['appointment_time'],
                                  style: TextStyle(
                                    fontSize: 12,
                                  )),
                              Text(data['tkn_status'].toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                  )),
                              Text(data['status'],
                                  style: TextStyle(
                                    fontSize: 14,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ));
  }

  nonlistitems(int index) {
    var data = appoinmentList[index];
    var demo = date1;
    var formatter = new DateFormat('yyyy-MM-dd');
    var currentDate = formatter.format(demo);
    return Slidable(
        // Specify a key if the Slidable is dismissible.
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          // dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            SlidableAction(
              // An action can be bigger than the others.
              flex: 1,
              onPressed: (e) async {
                await appointmentApprove_Cancel(data, "Fixed");
                await getAppoinmentList();
                setState(() {
                  active_tab = "Active";
                  isLoading = false;
                });
                // var formatter = new DateFormat('yyyy-MM-dd');
                // getAppoinmentList(formatter.format(dateRange.start),
                //     formatter.format(dateRange.end));
              },
              backgroundColor: Color(0xFF7BC043),
              foregroundColor: Colors.white,
              // icon: Icons.archive,
              label: 'Accept',
            ),
            SlidableAction(
              flex: 1,
              onPressed: (e) async {
                setState(() {
                  active_tab = "Cancel";
                  isLoading = true;
                });
                await appointmentApprove_Cancel(data, "Cancel");
                await getAppoinmentList();
                setState(() {
                  active_tab = "Cancel";
                  isLoading = false;
                });
              },
              backgroundColor: Color(0xFF0392CF),
              foregroundColor: Colors.white,
              // icon: Icons.save,
              label: 'Cancel',
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
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
                  // offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            // elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data['patient_name'].toString().length > 12
                                    ? data['patient_name']
                                            .toString()
                                            .substring(0, 12) +
                                        '...'
                                    : data['patient_name'].toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Text(data['phone'],
                                  style: TextStyle(
                                    fontSize: 14,
                                  )),
                              Text('Age: ' + data['age'],
                                  style: TextStyle(
                                    fontSize: 14,
                                  )),
                              active_tab == "Fixed" &&
                                      data['appointment_link'] != '' &&
                                      currentDate == data['appointment_date']
                                  ? InkWell(
                                      onTap: () {
                                        String meetingId =
                                            data['appointment_link'];
                                        var re =
                                            RegExp("\\w{4}\\-\\w{4}\\-\\w{4}");
                                        // check meeting id is not null or invaild
                                        // if meeting id is vaild then navigate to MeetingScreen with meetingId,token
                                        if (meetingId.isNotEmpty &&
                                            re.hasMatch(meetingId)) {
                                          // _meetingIdController.clear();
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MeetingScreen(
                                                meetingId: meetingId,
                                                token: token,
                                              ),
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                "Please enter valid meeting id"),
                                          ));
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.videocam,
                                              color: custom_color.appcolor,
                                              size: 30),
                                        ],
                                      ))
                                  : Text('')
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data['appointment_date'].toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Text(data['appointment_time'],
                                  style: TextStyle(
                                    fontSize: 12,
                                  )),
                              Text(data['tkn_status'].toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                  )),
                              Text(data['status'],
                                  style: TextStyle(
                                    fontSize: 14,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ));
  }
}
