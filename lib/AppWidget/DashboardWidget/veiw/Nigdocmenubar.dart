import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/BillingWidget/View/Cancelledbill.dart';
import 'package:nigdoc/AppWidget/BillingWidget/View/Collections.dart';
import 'package:nigdoc/AppWidget/BillingWidget/View/Paidbill.dart';
import 'package:nigdoc/AppWidget/BillingWidget/View/Pendingbilllist.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
// import 'package:nigdoc/AppWidget/DashboardWidget/veiw/Dashboardpage.dart';
import 'package:nigdoc/AppWidget/DoctorWidget/veiw/DoctorList.dart';
import 'package:nigdoc/AppWidget/LabLink/LabList.dart';
import 'package:nigdoc/AppWidget/Medicine/MedicineList.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/veiw/Patients.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/veiw/Prescription.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/veiw/PrescriptionPage.dart';
import 'package:nigdoc/AppWidget/PharmacyLink/PharmacyList.dart';
import 'package:nigdoc/AppWidget/Shop/View/ClinicConfiguration.dart';
import 'package:nigdoc/AppWidget/Shop/View/ClinicProfile.dart';
import 'package:nigdoc/AppWidget/StaffWidget/veiw/StaffList.dart';
// import 'package:nigdoc/AppWidget/StaffWidget/StaffList.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/veiw/Addprescription.dart';
import 'package:nigdoc/AppWidget/TestList/TestList.dart';
import 'package:nigdoc/AppWidget/TreatmentWidget/treatment.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';

class Nigdocmenubar extends StatefulWidget {
  const Nigdocmenubar({super.key});

  @override
  State<Nigdocmenubar> createState() => _NigdocmenubarState();
}

class _NigdocmenubarState extends State<Nigdocmenubar> {
  final LocalStorage storage = new LocalStorage('doctor_store');
  var userResponse = null;
  @override
  void initState() {
    this.setState(() {
      userResponse = storage.getItem('userResponse');
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            // Container(
            //   height: screenHeight * 0.30,
            // ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                  height: screenHeight * 0.95,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: screenHeight * 0.25,
                          child: UserAccountsDrawerHeader(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 8, 122, 135)),
                            accountName: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${Helper().isvalidElement(userResponse) ? userResponse['clinic_profile']['name'].toString().toUpperCase() : ''}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      'Clinic ID: ${Helper().isvalidElement(userResponse) ? userResponse['clinic_profile']['id'].toString().toUpperCase() : ''}'),
                                ],
                              ),
                            ),
                            accountEmail: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '${Helper().isvalidElement(userResponse) && Helper().isvalidElement(userResponse['clinic_profile']) && Helper().isvalidElement(userResponse['clinic_profile']['email']) ? userResponse['clinic_profile']['email'] : ''}'),
                                Text(
                                    '${Helper().isvalidElement(userResponse) && Helper().isvalidElement(userResponse['clinic_profile']) && Helper().isvalidElement(userResponse['clinic_profile']['mobile_no']) ? userResponse['clinic_profile']['mobile_no'] : ''}'),
                                Text(
                                    '${Helper().isvalidElement(userResponse) && Helper().isvalidElement(userResponse['clinic_profile']) && Helper().isvalidElement(userResponse['clinic_profile']['city']) ? userResponse['clinic_profile']['city'] : ''}'),
                              ],
                            ),
                            currentAccountPicture: CircleAvatar(
                              radius: 56,
                              backgroundImage: NetworkImage(
                                "${Helper().isvalidElement(userResponse) && Helper().isvalidElement(userResponse["clinic_logo"]) ? userResponse["clinic_logo"] : ''}",
                              ),
                              backgroundColor: Colors.white,
                            ),
                            otherAccountsPictures: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Text(
                                    '${userResponse['clinic_profile']['name'][0].toString().toUpperCase()}'),
                              )
                            ],
                          ),
                        ),
                        ListTile(
                          title: Text('Dashboard'),
                          leading: Icon(Icons.menu),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Dash(),
                                ));
                          },
                        ),
                        ExpansionTile(
                          title: Text('Patients'),
                          leading: Icon(Icons.person),
                          children: [
                            ListTile(
                              title: Text('Patients'),
                              leading: Icon(Icons.people),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Patients(),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Add Prescription'),
                              leading: Icon(Icons.notes),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddPrescription(),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Prescription'),
                              leading: Icon(Icons.note_add_sharp),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Prescription(),
                                    ));
                              },
                            ),
                            // ListTile(
                            //   title: Text('Patient History'),
                            //   leading: Icon(Icons.history),
                            //   onTap: () {},
                            // ),
                            // ListTile(
                            //   title: Text('Pharmacy Wise Prescription'),
                            //   leading: Icon(Icons.local_pharmacy_outlined),
                            //   onTap: () {},
                            // ),
                            // ListTile(
                            //   title: Text('Doctor Wise'),
                            //   leading: Icon(Icons.medical_information_outlined),
                            //   onTap: () {},
                            // ),
                          ],
                        ),
                        // ExpansionTile(
                        //   title: Text('Appointments'),
                        //   leading: Icon(Icons.note_alt_sharp),
                        //   children: [
                        //     ListTile(
                        //       title: Text('Appointment List'),
                        //       leading: Icon(Icons.list),
                        //       onTap: () {},
                        //     ),
                        //     ListTile(
                        //       title: Text('Working Hours'),
                        //       leading: Icon(Icons.watch_later),
                        //       onTap: () {},
                        //     ),
                        //   ],
                        // ),
                        // ExpansionTile(
                        //   title: Text('Discharge Summary'),
                        //   leading: Icon(Icons.summarize),
                        //   children: [
                        //     ListTile(
                        //       title: Text('Summary'),
                        //       leading: Icon(Icons.notes_rounded),
                        //       onTap: () {},
                        //     ),
                        //   ],
                        // ),










                        // ExpansionTile(
                        //   title: Text('Billing'),
                        //   leading: Icon(Icons.blinds_closed),
                        //   children: [
                        //     ExpansionTile(
                        //       title: Text('Collections'),
                        //       leading: Icon(Icons.blinds_closed),
                        //       children: [
                        //         ListTile(
                        //           title: Text('Pending Bill List'),
                        //           leading: Icon(Icons.pending),
                        //           onTap: () {
                        //             Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                   builder: (context) =>
                        //                       Pendingbilllist(),
                        //                 ));
                        //           },
                        //         ),
                        //         ListTile(
                        //           title: Text('Paid Bill List'),
                        //           leading: Icon(Icons.paid),
                        //           onTap: () {
                        //              Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                   builder: (context) =>
                        //                       paidbilllist(),
                        //                 ));
                        //           },
                        //         ),
                        //         ListTile(
                        //           title: Text('Cancelled Bill List'),
                        //           leading: Icon(Icons.cancel_outlined),
                        //           onTap: () {
                        //              Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                   builder: (context) =>
                        //                       Cancelledbill(),
                        //                 ));
                        //           },
                        //         ),
                        //       ],
                        //     ),
                        //     // ListTile(
                        //     //   title: Text('Collections'),
                        //     //   leading: Icon(Icons.collections),
                        //     //   onTap: () {
                        //     //     Navigator.push(
                        //     //         context,
                        //     //         MaterialPageRoute(
                        //     //           builder: (context) => Collections(),
                        //     //         ));
                        //     //   },
                        //     // ),
                        //     ListTile(
                        //       title: Text('Register Report'),
                        //       leading: Icon(Icons.report),
                        //       onTap: () {},
                        //     ),
                        //   ],
                        // ),






                        
                        ListTile(
                          title: Text('Treatment'),
                          leading: Icon(Icons.local_hospital_outlined),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: ((context) => TreatmentList())));
                          },
                        ),
                        ListTile(
                          title: Text('Medicine'),
                          leading: Icon(Icons.medical_information_outlined),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> MedicineList()));
                          },
                        ),
                        ListTile(
                          title: Text('TestReport'),
                          leading: Icon(Icons.medical_information_outlined),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> TestList()));
                          },
                        ),
                        ListTile(
                          title: Text('Prescription'),
                          leading: Icon(Icons.note_add_sharp),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PrescriptionPage(),
                                ));
                          },
                        ),
                        ExpansionTile(
                          title: Text('Settings'),
                          leading: Icon(Icons.settings),
                          children: [
                            ListTile(
                              title: Text('Doctor'),
                              leading: Icon(Icons.person),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DoctorList(),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Pharmacy Link'),
                              leading: Icon(Icons.local_pharmacy),
                              onTap: () {
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>PharmacyList()));


                              },
                            ),
                            ListTile(
                              title: Text('Lab Link'),
                              leading: Icon(Icons.medical_information_sharp),
                              onTap: () {
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>LabList()));
                              },
                            ),
                            ListTile(
                              title: Text('Clinic Profile'),
                              leading: Icon(Icons.home),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ClinicProfile(),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Clinic Configuration'),
                              leading: Icon(Icons.confirmation_number_sharp),
                              onTap: () {
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>ClinicConfig()));
                              },
                            ),
                            // ListTile(
                            //   title: Text('Report Configuration'),
                            //   leading: Icon(Icons.confirmation_number_sharp),
                            //   onTap: () {},
                            // ),
                            ListTile(
                              title: Text('Staff'),
                              leading: Icon(Icons.people_alt),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StaffList(),
                                    ));
                              },
                            ),
                            // ListTile(
                            //   title: Text('Pharmacy Wise Report'),
                            //   leading: Icon(Icons.report_outlined),
                            //   onTap: () {},
                            // ),
                            // ListTile(
                            //   title: Text('Compagin'),
                            //   leading: Icon(Icons.chat_bubble_outline),
                            //   onTap: () {},
                            // ),
                          ],
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}



