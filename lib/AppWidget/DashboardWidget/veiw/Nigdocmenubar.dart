import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/veiw/Dashboardpage.dart';
import 'package:nigdoc/AppWidget/DoctorWidget/veiw/DoctorList.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/veiw/Patients.dart';
import 'package:nigdoc/AppWidget/StaffWidget/veiw/StaffList.dart';
// import 'package:nigdoc/AppWidget/StaffWidget/StaffList.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/veiw/Addprescription.dart';

class Nigdocmenubar extends StatefulWidget {
  const Nigdocmenubar({super.key});

  @override
  State<Nigdocmenubar> createState() => _NigdocmenubarState();
}

class _NigdocmenubarState extends State<Nigdocmenubar> {
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
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: screenHeight * 0.92,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('Dashboard'),
                          leading: Icon(Icons.menu),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Dashboardpage(),
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
                              title: Text('Patient History'),
                              leading: Icon(Icons.history),
                              onTap: () {},
                            ),
                            ListTile(
                              title: Text('Pharmacy Wise Prescription'),
                              leading: Icon(Icons.local_pharmacy_outlined),
                              onTap: () {},
                            ),
                            ListTile(
                              title: Text('Doctor Wise'),
                              leading: Icon(Icons.medical_information_outlined),
                              onTap: () {},
                            ),
                          ],
                        ),
                        ExpansionTile(
                          title: Text('Appointments'),
                          leading: Icon(Icons.note_alt_sharp),
                          children: [
                            ListTile(
                              title: Text('Appointment List'),
                              leading: Icon(Icons.list),
                              onTap: () {},
                            ),
                            ListTile(
                              title: Text('Working Hours'),
                              leading: Icon(Icons.watch_later),
                              onTap: () {},
                            ),
                          ],
                        ),
                        ExpansionTile(
                          title: Text('Discharge Summary'),
                          leading: Icon(Icons.summarize),
                          children: [
                            ListTile(
                              title: Text('Summary'),
                              leading: Icon(Icons.notes_rounded),
                              onTap: () {},
                            ),
                          ],
                        ),
                        ExpansionTile(
                          title: Text('Billing'),
                          leading: Icon(Icons.blinds_closed),
                          children: [
                            ListTile(
                              title: Text('Collections'),
                              leading: Icon(Icons.collections),
                              onTap: () {},
                            ),
                            ListTile(
                              title: Text('Register Report'),
                              leading: Icon(Icons.report),
                              onTap: () {},
                            ),
                          ],
                        ),
                        ListTile(
                          title: Text('Treatment'),
                          leading: Icon(Icons.local_hospital_outlined),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Text('Medicine'),
                          leading: Icon(Icons.medical_information_outlined),
                          onTap: () {},
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
                              onTap: () {},
                            ),
                            ListTile(
                              title: Text('Lab Link'),
                              leading: Icon(Icons.medical_information_sharp),
                              onTap: () {},
                            ),
                            ListTile(
                              title: Text('Clinic Profile'),
                              leading: Icon(Icons.home),
                              onTap: () {},
                            ),
                            ListTile(
                              title: Text('Clinic Configuration'),
                              leading: Icon(Icons.confirmation_number_sharp),
                              onTap: () {},
                            ),
                            ListTile(
                              title: Text('Report Configuration'),
                              leading: Icon(Icons.confirmation_number_sharp),
                              onTap: () {},
                            ),
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
                            ListTile(
                              title: Text('Pharmacy Wise Report'),
                              leading: Icon(Icons.report_outlined),
                              onTap: () {},
                            ),
                            ListTile(
                              title: Text('Compagin'),
                              leading: Icon(Icons.chat_bubble_outline),
                              onTap: () {},
                            ),
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
