import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/veiw/Nigdocmenubar.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/veiw/PrescriptionPage.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';

class Dash extends StatefulWidget {
  const Dash({super.key});

  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> {

   var bottomNav = 'home';
  final List<String> images = [
    // 'assets/banner1.jpeg',
    // 'assets/banner2.jpeg',
    'assets/banner4.png',
  ];
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height - 50;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: SafeArea(
          child: Drawer(
        elevation: 50,
        child: Nigdocmenubar(),
      )),
       appBar: AppBar(
        //  automaticallyImplyLeading: false,
        //  elevation: 0,
         // backgroundColor: Color.fromARGB(255, 8, 122, 135),
         // backgroundColor: HexColor('#C2DED1'),
         // backgroundColor: Colors.white,
         title: const Text(
           'NigDoctor',
           style: TextStyle(color: Colors.black),
         ),
         // iconTheme: IconThemeData(color: custom_color.app_color1),
         actions: [
           IconButton(
               // onPressed: () {
               //   Helper().appLogoutCall(context, 'logout');
               // },
               onPressed: () {
                 showDialog(
                   context: context,
                   builder: (ctx) => AlertDialog(
                     title: const Text("Logout Alert"),
                     content:
                         const Text("Are you sure you want to Logout?"),
                     actions: <Widget>[
                       TextButton(
                         onPressed: () {
                           Navigator.of(ctx).pop();
                           //  Helper().appLogoutCall(context, 'logout');
                         },
                         child: Container(
                           // color: Colors.green,
                           padding: const EdgeInsets.all(14),
                           child: const Text("No"),
                         ),
                       ),
                       TextButton(
                         onPressed: () {
                           // Navigator.of(ctx).pop();
                           Helper().appLogoutCall(context, 'logout');
                         },
                         child: Container(
                           // color: Colors.green,
                           padding: const EdgeInsets.all(14),
                           child: const Text("Yes"),
                         ),
                       ),
                     ],
                   ),
                 );
               },
               icon: Icon(Icons.logout)),
           // on(onPressed: getAllCustomers, icon: Icon(Icons.category))
         ],
       ),
          body: SingleChildScrollView(
            child: Column(
              children: [
             
                   Container(
              width: screenWidth,
              color: Colors.blueAccent,
              child: Container(
                height: screenHeight * 0.25,
                decoration: BoxDecoration(),
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider.builder(
                    itemCount: images.length,
                    itemBuilder: (context, index, realIdx) {
                      return GestureDetector(
                        child: Center(
                          child: Image(
                            // height: screenHeight * 0.5,
                            image: AssetImage(images[index]),
                            fit: BoxFit.contain,
                          ),
                          // fit: BoxFit.cover, width: 1000)
                        ),
                      );
                    },
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                    )),
              ),
            ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                         child: Row(
                      children: [
                        Text(
                          "Monthly Report",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                      ),
                      Container(
                    height: screenHeight * 0.18,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: screenWidth * 0.40,
                            // height: screenHeight * 0.07,
                            decoration: Helper().ContainerShowdow(0, 'no'),
                            padding: const EdgeInsets.all(10),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: screenWidth * 0.44,
                                    child: Text(
                                      'Patient Count',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                      width: screenWidth * 0.44,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          // Text(
                                          //   '₹',
                                          //   style: TextStyle(
                                          //       color: Colors.amber,
                                          //       fontSize: 22,
                                          //       fontWeight: FontWeight.bold),
                                          // ),
                                          Text(
                                           '0',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: screenWidth * 0.4,
                            height: screenHeight * 0.1,
                            decoration: Helper().ContainerShowdow(0, 'no'),
                            padding: const EdgeInsets.all(10),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: screenWidth * 0.44,
                                    child: Text(
                                      'Prescription Count',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                      width: screenWidth * 0.44,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          // Text(
                                          //   '₹',
                                          //   style: TextStyle(
                                          //       color: Colors.amber,
                                          //       fontSize: 22,
                                          //       fontWeight: FontWeight.bold),
                                          // ),
                                          Text(
                                            '0',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: screenWidth * 0.4,
                            height: screenHeight * 0.1,
                            decoration: Helper().ContainerShowdow(0, 'no'),
                            padding: const EdgeInsets.all(10),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: screenWidth * 0.44,
                                    child: Text(
                                      'Appointment Count',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                      width: screenWidth * 0.44,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          // Text(
                                          //   '₹',
                                          //   style: TextStyle(
                                          //       color: Colors.amber,
                                          //       fontSize: 22,
                                          //       fontWeight: FontWeight.bold),
                                          // ),
                                          Text(
                                            '0',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: screenWidth * 0.4,
                            height: screenHeight * 0.1,
                            decoration: Helper().ContainerShowdow(0, 'no'),
                            padding: const EdgeInsets.all(10),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: screenWidth * 0.44,
                                    child: Text(
                                      'Pending Appointment Count',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                      width: screenWidth * 0.44,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          // Text(
                                          //   '₹',
                                          //   style: TextStyle(
                                          //       color: Colors.amber,
                                          //       fontSize: 22,
                                          //       fontWeight: FontWeight.bold),
                                          // ),
                                          Text(
                                             '0',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                    ],
                  ),
                )
              ],
            ),
          ),

           floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PrescriptionPage()));
            },
            child: Icon(
              Icons.add,
              size: 30,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
              shape: CircularNotchedRectangle(),
              notchMargin: 5,
              child: Container(
                height: screenHeight * 0.07,
                width: screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      splashColor: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Icon(Icons.home,
                                color: bottomNav == 'home'
                                    ?Colors.blue
                                    : Colors.black),
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                                color: bottomNav == 'home'
                                    ?Colors.blue
                                    : Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      onTap: () {
                        this.setState(() {
                          bottomNav = 'home';
                        });
                      },
                    ),


                     InkWell(
                      splashColor: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Icon(Icons.people_alt_outlined,
                                color: bottomNav == 'customer'
                                    ?Colors.blue
                                    : Colors.black),
                          ),
                          Text(
                            'Customer',
                            style: TextStyle(
                                color: bottomNav == 'customer'
                                    ? Colors.blue
                                    : Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      onTap: () {
                        // this.setState(() {
                        //   bottomNav = 'customer';
                        // });
                        // Navigator.push(
                        //         context,
                                
                        //         MaterialPageRoute(
                        //             builder: (context) => const CustomerList()),
                        //       );
                      },
                    ),

                     SizedBox(width: 5,),
                     InkWell(
                      splashColor: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Icon(Icons.production_quantity_limits_rounded,
                                color: bottomNav == 'product'
                                    ? Colors.blue
                                    : Colors.black),
                          ),
                          Text(
                            'Product',
                            style: TextStyle(
                                color: bottomNav == 'product'
                                    ? Colors.blue
                                    : Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      onTap: () {
                        // this.setState(() {
                        //   bottomNav = 'product';
                        // });
                        // Navigator.push(
                        //         context,
                                
                        //         MaterialPageRoute(
                        //             builder: (context) => const Productlist()),
                        //       );
                      },
                    ),
                   
                    InkWell(
                      onTap: () {
                        // this.setState(() {
                        //   bottomNav = 'setting';
                        // });
                        //  Navigator.push(
                        //         context,
                                
                        //         MaterialPageRoute(
                        //             builder: (context) => const SettingView()),
                        //       );
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Icon(
                              Icons.settings,
                              color: bottomNav == 'setting'
                                  ?Colors.blue
                                  : Colors.black,
                            ),
                          ),
                          Text(
                            'Setting',
                            style: TextStyle(
                                color: bottomNav == 'setting'
                                    ? Colors.blue
                                    : Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
    );
  }
}
