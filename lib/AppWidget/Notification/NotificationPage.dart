import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/DashboardApi.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;
import 'package:marquee_widget/marquee_widget.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Common/utils.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    loadNotifications();
    // TODO: implement initState
    super.initState();
  }

  // Box? notifylistBox = Hive.box(StoreBox().NotifyList);
  var notify_data;
  var notificationList = null;
  var notification_topics = [
    {'title': '', 'image': 'assets/n_all.png'},
    {'title': 'Steps', 'image': 'assets/n_step.png'},
    {'title': 'Drink', 'image': 'assets/n_water.png'},
    {'title': 'Diet', 'image': 'assets/n_diet.png'},
    {'title': 'Sleep', 'image': 'assets/n_sleep.png'}
  ];
  String selectedTopic = '';
  bool loading = false;
  List options = ['Enable', 'Disable'];
  var _selectedIndex = 0;
 DateTimeRange dateRange = DateTimeRange(
    start: DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day ),
    end:
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
  );
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: () async {
          await storage.setItem('bottom_index', _selectedIndex);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Dash()),
          );
          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          // appBar: AppBar(title: Text('data')),
          body: SafeArea(
              child: SingleChildScrollView(
                // physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Appbar(),
                renderDatepicker(screenHeight, screenWidth),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Helper().isvalidElement(notificationList)
                    ? renderExpansionTile()
                    : SpinLoader()
              ],
            ),
          )),
        ));
  }

  showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: renderSettingsOption(),
            ));
  }

  Widget renderSettingsOption() {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
        height: screenHeight * 0.125,
        // color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Notification'),
                Container(
                  height: screenHeight * 0.05,
                  width: screenWidth * 0.3,
                  child: DropdownButtonFormField(
                    iconEnabledColor: Colors.white,
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                    ),

                    isExpanded: true,
                    hint: Text(
                      'Enable',
                      style: TextStyle(color: Colors.black),
                    ),

                    // value:' _selectedState[i]',
                    onChanged: (selected_item) async {},
                    items: options.map<DropdownMenuItem<String>>((item) {
                      return new DropdownMenuItem(
                        child: Text(item),
                        value: item.toString(),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            InkWell(
                onTap: () {},
                child: Card(
                    color: custom_color.appcolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Update',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.48),
                      ),
                    )))
          ],
        ));
  }

   Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: custom_color.appcolor,
              onPrimary: Colors.white,
              onSurface: custom_color.appcolor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: custom_color.appcolor,
              ),
            ),
          ),
          child: child!,
        );
      },
      initialDateRange: dateRange,
      firstDate: DateTime(DateTime.now().year - 2),
      lastDate:DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
    );
    setState(() {
      dateRange = newDateRange ?? dateRange;
    });
    // getPendingCollectionList();
    setState(() {});
  }

  renderDatepicker(screenHeight, screenWidth) {
    final start = dateRange.start;
    final end = dateRange.end;

    return Container(
      width: screenWidth,
      height: screenHeight * 0.1,
      color:  custom_color.appcolor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () async {
              await pickDateRange();
             await loadNotifications();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.shade400,
                //     blurRadius: 10.0,
                //     spreadRadius: 1,
                //     // offset: Offset(
                //     //   10,
                //     //   10,
                //     // ),
                //   )
                // ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.date_range_outlined,
                    ),
                    Text(
                      'From: ${start.year}/${start.month}/${start.day}  ',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: custom_color.appcolor),
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await pickDateRange();
              await loadNotifications();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.shade400,
                //     blurRadius: 10.0,
                //     spreadRadius: 1,
                //     // offset: Offset(
                //     //   10,
                //     //   10,
                //     // ),
                //   )
                // ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.date_range_outlined,
                    ),
                    Text(
                      'To: ${end.year}/${end.month}/${end.day}  ',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color:  custom_color.appcolor),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget Appbar() {
    return Container(
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  child: Icon(
                    Icons.arrow_back,
                    color: custom_color.appcolor,
                  ),
                  onTap: () async {
                    await storage.setItem('bottom_index', _selectedIndex);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Dash()),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Notifications',
                    style: TextStyle(
                        color: custom_color.appcolor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.42),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget renderExpansionTile() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.85,
      child: notificationList.length > 0
          ? ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(5.0),
              itemCount: notificationList.length,
              itemBuilder: (BuildContext context, int index) {
                var data = notificationList[index];
                return InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ExpansionTile(
                            leading:
                                // data['title'].toString().toLowerCase()=='drink water reminder'?Image.asset(
                                //   'assets/n_water.png',
                                //   height: 30,
                                //   fit: BoxFit.fill,
                                // ):
                                Image.asset(
                              'assets/log.png',
                              height: 30,
                            ),
                            // CircleAvatar(
                            //   radius: 15.0,
                            //   backgroundImage: AssetImage('assets/logo.png'),
                            //   backgroundColor: Colors.transparent,
                            // ),
                            trailing: Text(
                              getNotificationDuration(data['created_at'])
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 9, fontWeight: FontWeight.bold),
                            ),
                            title: Text(
                              data['title'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            subtitle: Container(
                              width: screenWidth * 0.55,
                              // color: Colors.red,
                              child: Marquee(
                                directionMarguee: DirectionMarguee.oneDirection,
                                child: Text(data['description'] == null
                                    ? ''
                                    : data['description']),
                              ),
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                            children: <Widget>[
                              // data['image'] != null &&
                              //         data['image'].toString().isNotEmpty
                              //     ? Image.network(data['image'])
                              //     : Container()
                              ListTile(
                                title: data['image'] != null &&
                                        data['image'].toString().isNotEmpty
                                    ? Image.network(data['image'])
                                    : Container(),
                                subtitle: data['link'] != null &&
                                        data['link'].toString().isNotEmpty
                                    ? Row(
                                        children: [
                                          TextButton(
                                              onPressed: () async {
                                                String telephoneUrl =
                                                    data["link"];
                                                if (await launch(
                                                    telephoneUrl)) {
                                                  await launch(telephoneUrl);
                                                } else {
                                                  throw "Error occured trying to call that number.";
                                                }
                                              },
                                              child: Text(
                                                'Click Link',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
                                              )),
                                        ],
                                      )
                                    : Container(),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 0.5,
                          )
                        ],
                      ),
                    ));
              },
            )
          : Center(
              child: Text('List is empty'),
            ),
    );
  }

  loadNotifications() async {
     var formatter = DateFormat('yyyy-MM-dd');
    var data = {
      'email': storage.getItem('userResponse')['clinic_profile']['email'],
      'from':formatter.format(dateRange.start),
      'to': formatter.format(dateRange.end),
    };
    var result = await DashboardApi().GetNotification(data);
    setState(() {
      notificationList = result['result'];
    });
  }

  getNotificationDuration(time) {
    var list1 = time.toString().split(' '); //[0]:"2023-06-21"  [1]:"22:00:46"
    var list2 = list1[0].toString().split('-'); //[0]:"2023"  [1]:"06"  [2]:"21"
    var list3 = list1[1].toString().split(':'); //[0]:"22"  [1]:"00"  [2]:"46"
    final DateTime dateOne = DateTime(
        int.parse(list2[0]),
        int.parse(list2[1]),
        int.parse(list2[2]),
        int.parse(list3[0]),
        int.parse(list3[1]),
        int.parse(list3[2]));
    final DateTime dateTwo = DateTime.now();
    final Duration duration = dateTwo.difference(dateOne);
    var interval;
    if (duration.inDays != 0) {
      interval = duration.inDays.toString() + ' day ago';
    } else if (duration.inHours != 0) {
      interval = duration.inHours.toString() + ' hour ago';
    } else if (duration.inMinutes != 0) {
      interval = duration.inMinutes.toString() + ' min ago';
    } else {
      interval = 'Just now';

      //     if(duration.inSeconds == 0)  {
      //   interval = 'Just Now';
      // } else{
      //   interval = duration.inSeconds.toString() + ' sec ago';

      // }
    }
    return interval.toString();
  }
}
