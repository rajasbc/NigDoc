import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:lottie/lottie.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import '../../../Api/url.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import '../../DashboardWidget/Dash.dart';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:signature/signature.dart';
import 'dart:ui'; // Make sure to import dart:ui for Point
import 'dart:math';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import '../../TreatmentWidget/AddTreatment.dart';
import 'package:http/http.dart' as http;

import '../../common/OverlayLoader.dart';

class EditorPrescription extends StatefulWidget {
  const EditorPrescription({super.key});

  @override
  State<EditorPrescription> createState() => _EditorPrescriptionState();
}

class _EditorPrescriptionState extends State<EditorPrescription>
    with SingleTickerProviderStateMixin {
  final LocalStorage storage = new LocalStorage('doctor_store');
  PageController medicinePageController = PageController();
  PageController labPageController = PageController();
  PageController injectionPageController = PageController();

  int medicineActiveIndex = 0;
  int labActiveIndex = 0;
  int injectionActiveIndex = 0;

  late TabController _tabController;
  var accesstoken = null;
  var userResponse = null;
  var PatientList;
  List<String> tabs = ["Treatment", "Medicine", "Lab", "Injection"];
  var activeTab = 'Treatment';
  bool showAutoComplete = true;
  bool isloading = false;
  var selectedPatient;
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5.0,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );
  final List<SignatureController> medicineControllers = List.generate(
    5,
    (_) => SignatureController(penStrokeWidth: 3, penColor: Colors.black),
  );
  final List<SignatureController> labControllers = List.generate(
    5,
    (_) => SignatureController(penStrokeWidth: 3, penColor: Colors.black),
  );
  final List<SignatureController> injectionControllers = List.generate(
    5,
    (_) => SignatureController(penStrokeWidth: 3, penColor: Colors.black),
  );

  final List<int> medicineSignatureCounts = List.filled(5, 0);
  final List<int> labSignatureCounts = List.filled(5, 0);
  final List<int> injectionSignatureCounts = List.filled(5, 0);
  var uploadMedicinePrescriptionList = [];
  var uploadLabPrescriptionList = [];
  var uploadInjectionPrescriptionList = [];
  var mediAndLabNameList = [];
  var treatmentList = null;
  String treatmentDropdownvalue = 'Select Treatment';
  TextEditingController fees = TextEditingController();
  TextEditingController labnameController = TextEditingController();
  TextEditingController pharmacyController = TextEditingController();

  var treatmentName = null;
  var treatmentId = null;
  var selectedTreatmentList = [];
  bool labshowAutoComplete = true;
  var selectedLab;
  bool pharmacyshowAutoComplete = true;
  var selectedPharmacy;
  bool isTablet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final diagonal = sqrt(size.width * size.width + size.height * size.height);
    // current tab  - 1093.3786253409344
    return diagonal > 1000.0;
  }

  @override
  void initState() {
    userResponse = storage.getItem('userResponse');
    accesstoken = userResponse['access_token'];
    selectedPatient = storage.getItem('selectedcustomer');
    _tabController = TabController(length: 3, vsync: this);
    getpatientlist();
    getTreatmentList();
    for (int i = 0; i < medicineControllers.length; i++) {
      medicineControllers[i].onDrawStart = () {
        setState(() {
          medicineSignatureCounts[i] = medicineControllers[i].points.length;
        });
      };
    }
    for (int i = 0; i < labControllers.length; i++) {
      labControllers[i].onDrawStart = () {
        setState(() {
          labSignatureCounts[i] = labControllers[i].points.length;
        });
      };
    }
    for (int i = 0; i < injectionControllers.length; i++) {
      injectionControllers[i].onDrawStart = () {
        setState(() {
          injectionSignatureCounts[i] = injectionControllers[i].points.length;
        });
      };
    }

    medicinePageController.addListener(() {
      int nextIndex = medicinePageController.page?.round() ?? 0;
      if (medicineActiveIndex != nextIndex) {
        setState(() {
          medicineActiveIndex = nextIndex;
        });
      }
    });
    labPageController.addListener(() {
      int nextIndex = labPageController.page?.round() ?? 0;
      if (labActiveIndex != nextIndex) {
        setState(() {
          labActiveIndex = nextIndex;
        });
      }
    });
    injectionPageController.addListener(() {
      int nextIndex = injectionPageController.page?.round() ?? 0;
      if (injectionActiveIndex != nextIndex) {
        setState(() {
          injectionActiveIndex = nextIndex;
        });
      }
    });
    // getInjectionList();
    // TODO: implement initState
    super.initState();
  }

  void dispose() {
    // Dispose all controllers
    for (var controller in medicineControllers) {
      controller.dispose();
    }
    for (var controller in labControllers) {
      controller.dispose();
    }
    for (var controller in injectionControllers) {
      controller.dispose();
    }
    medicinePageController.dispose();
    labPageController.dispose();
    injectionPageController.dispose();
    super.dispose();
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
        PatientList = list['Customer_list'];
        isloading = true;
      });
    }
  }

  getTreatmentList() async {
    var List = await PatientApi().gettreatmentlist(accesstoken);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        treatmentList = List['list'];
      });
      // TreatmentList = List['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
    }
  }

  getMediAndLabNameList(type) async {
    // var type = activeTab == 'Medicine' ? 'medicine' : 'lab';
    var data = {
      "type": type.toString(),
    };
    var List = await PatientApi().getMediAndLabNameList(accesstoken, data);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        mediAndLabNameList = List['list'];
        var values = mediAndLabNameList;
      });
      // TreatmentList = List['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
    }
  }

  totalTreatmentAmount() {
    var total = 0.0;
    for (var element in selectedTreatmentList) {
      total = total + element['fees'];
    }
    return total;
  }

  uploadPrescription(prescription_data, prescriptionImageList) async {
    try {
      await OverlayLoader().showLoader(context);
      var prescription_image_list = prescriptionImageList;
      var headers = {
        'Content-type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accesstoken',
      };
      String uploadUrl = base_url + EditorPrescriptionUpload;
      final uri = Uri.parse(uploadUrl);
      final request = http.MultipartRequest('POST', uri);

      request.fields['prescription_data'] = jsonEncode(prescription_data);

      for (int i = 0; i < prescription_image_list.length; i++) {
        request.files.add(http.MultipartFile.fromBytes(
          'image[$i]',
          prescription_image_list[i]['imageData'],
          filename: prescription_image_list[i]['filename'],
        ));
      }

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var result = json.decode(await response.stream.bytesToString());
        print(result);

        if (result['message'] == 'success') {
          // await showSuccessAnimation(context);
          Fluttertoast.showToast(
            msg: result['sub_message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } else {
        print('Failed to upload images. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading prescription: $e');
      Fluttertoast.showToast(
        msg: 'Uploading prescription failed. Try agin!',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      await OverlayLoader().hideLoader();
      Navigator.push(context, MaterialPageRoute(builder: (context) => Dash()));
      setState(() {
        selectedLab = null;
        selectedPharmacy = null;
        selectedTreatmentList = [];
        selectedPatient = null;
        showAutoComplete = true;

        // labControllers.clear();
        // medicineControllers.clear();
        // injectionControllers.clear();
        for (int i = 0; i < medicineControllers.length; i++) {
          medicineControllers[i].clear();
        }
        for (int i = 0; i < labControllers.length; i++) {
          labControllers[i].clear();
        }
        for (int i = 0; i < injectionControllers.length; i++) {
          injectionControllers[i].clear();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: custom_color.appcolor,
        title: Text(
          'Add Prescription',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dash()));
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: ElevatedButton(
                onPressed: () async {
                  var medicineImageController = medicineControllers;
                  var labImageController = labControllers;
                  var injectionImageController = injectionControllers;
                  final now = DateTime.now();
                  final formatter = DateFormat('dd-MM-yyyy-HH-mm');

                  for (var controller in medicineImageController) {
                    final ui.Image? image = await controller.toImage();
                    final ByteData? byteData =
                        await image?.toByteData(format: ui.ImageByteFormat.png);
                    if (byteData != null) {
                      final Uint8List pngBytes = byteData.buffer.asUint8List();
                      var image_position =
                          medicineImageController.indexOf(controller) + 1;
                      String filename = 'NIG_MEDICINE_${image_position}.png';
                      int index = uploadMedicinePrescriptionList
                          .indexWhere((item) => item['filename'] == filename);

                      if (index != -1) {
                        uploadMedicinePrescriptionList[index]['imageData'] =
                            pngBytes;
                      } else {
                        uploadMedicinePrescriptionList.add({
                          'filename': filename,
                          'imageData': pngBytes,
                        });
                      }
                    }
                  }
                  for (var controller in labImageController) {
                    final ui.Image? image = await controller.toImage();
                    final ByteData? byteData =
                        await image?.toByteData(format: ui.ImageByteFormat.png);
                    if (byteData != null) {
                      final Uint8List pngBytes = byteData.buffer.asUint8List();
                      var image_position =
                          labImageController.indexOf(controller) + 1;
                      String filename = 'NIG_LAB_${image_position}.png';
                      int index = uploadLabPrescriptionList
                          .indexWhere((item) => item['filename'] == filename);

                      if (index != -1) {
                        uploadLabPrescriptionList[index]['imageData'] =
                            pngBytes;
                      } else {
                        uploadLabPrescriptionList.add({
                          'filename': filename,
                          'imageData': pngBytes,
                        });
                      }
                    }
                  }
                  for (var controller in injectionImageController) {
                    final ui.Image? image = await controller.toImage();
                    final ByteData? byteData =
                        await image?.toByteData(format: ui.ImageByteFormat.png);
                    if (byteData != null) {
                      final Uint8List pngBytes = byteData.buffer.asUint8List();
                      var image_position =
                          injectionImageController.indexOf(controller) + 1;
                      String filename = 'NIG_INJECTION_${image_position}.png';
                      int index = uploadInjectionPrescriptionList
                          .indexWhere((item) => item['filename'] == filename);
                      if (index != -1) {
                        uploadInjectionPrescriptionList[index]['imageData'] =
                            pngBytes;
                      } else {
                        uploadInjectionPrescriptionList.add({
                          'filename': filename,
                          'imageData': pngBytes,
                        });
                      }
                    }
                  }
                  var prescriptionImageList = [];
                  prescriptionImageList.addAll(uploadMedicinePrescriptionList);
                  prescriptionImageList.addAll(uploadLabPrescriptionList);
                  prescriptionImageList.addAll(uploadInjectionPrescriptionList);
                  prescriptionImageList =
                      List.from(Set.from(prescriptionImageList));
                  if (selectedPatient == null) {
                    Fluttertoast.showToast(
                        msg: 'Please select patient',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 2,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 15.0);
                  }
                  // else if (prescriptionImageList.length < 1) {
                  //   Fluttertoast.showToast(
                  //       msg: 'At least one prescription is required',
                  //       toastLength: Toast.LENGTH_SHORT,
                  //       gravity: ToastGravity.CENTER,
                  //       timeInSecForIosWeb: 2,
                  //       backgroundColor: Colors.red,
                  //       textColor: Colors.white,
                  //       fontSize: 15.0);
                  //   setState(() {
                  //     activeTab = "Medicine";
                  //   });
                  // } else if (selectedTreatmentList.length < 1) {
                  //   Fluttertoast.showToast(
                  //       msg: 'At least one treatment item is required',
                  //       toastLength: Toast.LENGTH_SHORT,
                  //       gravity: ToastGravity.CENTER,
                  //       timeInSecForIosWeb: 2,
                  //       backgroundColor: Colors.red,
                  //       textColor: Colors.white,
                  //       fontSize: 15.0);
                  //   setState(() {
                  //     activeTab = "Treatment";
                  //   });
                  // } else if (selectedLab == null) {
                  //   Fluttertoast.showToast(
                  //       msg: 'Please select lab',
                  //       toastLength: Toast.LENGTH_SHORT,
                  //       gravity: ToastGravity.CENTER,
                  //       timeInSecForIosWeb: 2,
                  //       backgroundColor: Colors.red,
                  //       textColor: Colors.white,
                  //       fontSize: 15.0);
                  //   setState(() {
                  //     activeTab = "Lab";
                  //   });
                  // } else if (selectedPharmacy == null) {
                  //   Fluttertoast.showToast(
                  //       msg: 'Please select pharmacy',
                  //       toastLength: Toast.LENGTH_SHORT,
                  //       gravity: ToastGravity.CENTER,
                  //       timeInSecForIosWeb: 2,
                  //       backgroundColor: Colors.red,
                  //       textColor: Colors.white,
                  //       fontSize: 15.0);
                  //   setState(() {
                  //     activeTab = "Medicine";
                  //   });
                  // }
                  else {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(DateTime.now());
                    // if (selectedPatient == null ||
                    //     !selectedPatient.containsKey('doctor_id') ||
                    //     selectedPatient['doctor_id'].toString().isEmpty) {
                    //   NigDocToast().showErrorToast("Doctor ID is required");
                    //   return;
                    // }

                    // if (selectedPatient == null ||
                    //     !selectedPatient.containsKey('cid') ||
                    //     selectedPatient['cid'].toString().isEmpty) {
                    //   NigDocToast().showErrorToast("Please select patient.");
                    //   return;
                    // }

                    // if (selectedTreatmentList == null ||
                    //     selectedTreatmentList.isEmpty) {
                    //   NigDocToast().showErrorToast(
                    //       "At least one treatment item is required.");
                    //   return;
                    // }

                    var labID = selectedLab != null
                        ? selectedLab['shop_id'].toString()
                        : '';
                    var pharmacyID = selectedPharmacy != null
                        ? selectedPharmacy['shop_id'].toString()
                        : '';

                    var prescription_data = {
                      "doctor_id": selectedPatient['doctor_id'].toString(),
                      "patient_id": selectedPatient['cid'].toString(),
                      "pharmeasyid": Helper().isvalidElement(selectedPharmacy)
                          ? selectedPharmacy['shop_id'].toString()
                          : '',
                      "labid": labID,
                      "prescription_comment": "",
                      "treatment_item": selectedTreatmentList.length > 0
                          ? selectedTreatmentList
                          : [],
                      "date": formattedDate
                    };

                    await uploadPrescription(
                        prescription_data, prescriptionImageList);
                  }
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                      color: custom_color.appcolor,
                      fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                  // color: Colors.red,
                  height: screenHeight * 0.1,
                  child: Center(
                      child: renderSearchPatient(screenHeight, screenWidth))),
              // SizedBox(
              //   height: screenHeight * 0.01,
              // ),
              Container(
                  // color: Colors.red,
                  height: screenHeight * 0.08,
                  child: renderHeaderTabs(screenHeight, screenWidth)),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Container(
                  // color: Colors.red,
                  // height: screenHeight * 0.08,
                  child: activeTab == 'Treatment'
                      ? renderTreatmentView(screenHeight, screenWidth)
                      : renderPageEditorView(screenHeight, screenWidth)),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     renderFabIcons(screenWidth, screenHeight, medicineActiveIndex),
              //     renderDotNavigation(screenWidth, screenHeight, medicineActiveIndex),
              //   ],
              // ),
              // SizedBox(
              //   height: screenHeight * 0.02,
              // ),
              // Container(
              //     height: screenHeight * 0.62,
              //     child: PageView.builder(
              //         controller: medicinePageController,
              //         itemCount: 5,
              //         scrollDirection: Axis.horizontal,
              //         physics: NeverScrollableScrollPhysics(),
              //         itemBuilder: (context, index) {
              //           return renderMedicineEditor(
              //               screenHeight, screenWidth, index);
              //         })),

              // SizedBox(
              //   height: screenHeight * 0.01,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: custom_color
              //               .appcolor, // Set your desired background color
              //         ),
              //         onPressed: () {},
              //         child: Text(
              //           'Save Prescription',
              //           style: TextStyle(color: Colors.white),
              //         ))
              //   ],
              // ),
            ],
          )),
        ),
      ),
    );
  }

  Widget renderMedicineEditor(double screenHeight, double screenWidth, index) {
    final isTabletDevice = isTablet(context);
    return Container(
      width: screenWidth * 0.9,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Listener(
        onPointerDown: (PointerDownEvent event) {
          // print('pointer size:  ${event.size}');
          // print('pointer radiusMajor:  ${event.radiusMajor}');
          // final isTabletDevice = isTablet(context);

          // if (isTabletDevice) {
          //   // if (event.size < 0.045 && event.radiusMajor < 3.1) {
          //   if (event.size < 0.04 && event.radiusMajor < 3.25) {
          //     medicineControllers[index].disabled = false;
          //   } else {
          //     medicineControllers[index].disabled = true;
          //   }
          // }
          if (activeTab == "Medicine") {
            medicineControllers[index].disabled = false;
            if (event.kind == PointerDeviceKind.stylus) {
              medicineControllers[index].disabled = false;
            } else {
              // medicineControllers[index].disabled = true;
              medicineControllers[index].disabled = true;
            }
          } else if (activeTab == "Lab") {
            labControllers[index].disabled = false;
            if (event.kind == PointerDeviceKind.stylus) {
              labControllers[index].disabled = false;
            } else {
              // medicineControllers[index].disabled = true;
              labControllers[index].disabled = true;
            }
          } else {
            injectionControllers[index].disabled = false;
            if (event.kind == PointerDeviceKind.stylus) {
              injectionControllers[index].disabled = false;
            } else {
              // medicineControllers[index].disabled = true;
              injectionControllers[index].disabled = true;
            }
          }
        },
        child: Center(
          child: Stack(
            children: [
              activeTab == 'Medicine'
                  ? Positioned.fill(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: isTabletDevice
                                      ? screenWidth * 0.35
                                      : screenWidth * 0.4,
                                  child: Text(
                                    'Medicine',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ),
                                Container(
                                  width: isTabletDevice
                                      ? screenWidth * 0.425
                                      : screenWidth * 0.35,
                                  padding: EdgeInsets.only(right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(!isTabletDevice ? 'Mor' : 'Morning',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
                                      Text(
                                          !isTabletDevice ? 'Aft' : 'AfterNoon',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
                                      Text(!isTabletDevice ? 'Eve' : 'Evening',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
                                      Text(!isTabletDevice ? 'Ngt' : 'Night',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Signature(
                  controller: activeTab == 'Medicine'
                      ? medicineControllers[index]
                      : activeTab == 'Lab'
                          ? labControllers[index]
                          : injectionControllers[index],
                  backgroundColor: Colors.transparent,
                  // dynamicPressureSupported: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderSearchPatient(double screenHeight, double screenWidth) {
    return showAutoComplete && selectedPatient == null
        ? Padding(
            padding: EdgeInsets.all(2.0),
            child: renderAutoComplete(screenWidth, screenHeight),
          )
        : Container(
            child: Column(
            children: [
              Card(
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.people, color: custom_color.appcolor),
                      Text(
                        '     ${selectedPatient?['customer_name'].toString()}',
                      ),
                    ],
                  ),
                  subtitle: Text(
                      '             ${selectedPatient?['phone'].toString()}'),
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        selectedPatient = null;
                        showAutoComplete = true;
                      });
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              // ListTile(title: Text('Test name'),
              // trailing: IconButton(onPressed: (){} ,icon: Icon(Icons.add)),),
            ],
          ));
  }

  Widget renderHeaderTabs(double screenHeight, double screenWidth) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Enable horizontal scrolling
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: tabs.map((tab) {
            bool isActive = activeTab == tab;
            return SizedBox(
              width: isActive ? screenWidth * 0.3 : screenWidth * 0.25,
              child: InkWell(
                onTap: () async {
                  print('$tab clicked');
                  setState(() {
                    activeTab = tab;
                    if (activeTab == 'Medicine') {
                      if (labPageController.hasClients)
                        labPageController.jumpToPage(0); // Reset Lab
                      if (injectionPageController.hasClients)
                        injectionPageController
                            .jumpToPage(0); // Reset Injection
                    } else if (activeTab == 'Lab') {
                      if (medicinePageController.hasClients)
                        medicinePageController.jumpToPage(0); // Reset Medicine
                      if (injectionPageController.hasClients)
                        injectionPageController
                            .jumpToPage(0); // Reset Injection
                    } else {
                      if (medicinePageController.hasClients)
                        medicinePageController.jumpToPage(0); // Reset Medicine
                      if (labPageController.hasClients)
                        labPageController.jumpToPage(0); // Reset Lab
                    }
                  });
                  if (tab == 'Lab') {
                    await getMediAndLabNameList('lab');
                  } else if (tab == 'Medicine') {
                    await getMediAndLabNameList('pharmacy');
                  }
                },
                child: Card(
                  color: isActive ? custom_color.appcolor : Colors.grey,
                  elevation: isActive ? 8 : 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      tab,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget renderPageEditorView(double screenHeight, double screenWidth) {
    return Column(
      children: [
        activeTab == 'Lab'
            ? labshowAutoComplete && labnameController.text.isEmpty
                ? renderLablistAutoComplete(screenWidth, screenHeight)
                : renderSelectedLabDetails(screenWidth, screenHeight)
            : pharmacyshowAutoComplete && pharmacyController.text.isEmpty
                ? renderpharmacylistAutoComplete(screenWidth, screenHeight)
                : renderSelectedPharmacyDetails(screenWidth, screenHeight),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // activeTab == 'Medicine'
            //     ? renderFabIcons(screenWidth, screenHeight)
            //     : activeTab == 'Lab'
            //         ? renderFabIcons(screenWidth, screenHeight)
            //         : renderFabIcons(screenWidth, screenHeight),
            // activeTab == 'Medicine'
            //     ? renderDotNavigation(
            //         screenWidth, screenHeight, medicineActiveIndex)
            //     : activeTab == 'Lab'
            //         ? renderDotNavigation(
            //             screenWidth, screenHeight, labActiveIndex)
            //         : renderDotNavigation(
            //             screenWidth, screenHeight, injectionActiveIndex),
            renderFabIcons(screenWidth, screenHeight),
            renderDotNavigation(screenWidth, screenHeight)
          ],
        ),
        // SizedBox(
        //   height: screenHeight * 0.005,
        // ),
        Container(
            height: screenHeight * 0.55,
            child: PageView.builder(
                controller: activeTab == "Medicine"
                    ? medicinePageController
                    : activeTab == "Lab"
                        ? labPageController
                        : injectionPageController,
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return renderMedicineEditor(screenHeight, screenWidth, index);
                })),
        SizedBox(
          height: screenHeight * 0.01,
        ),
      ],
    );
  }

  Widget renderTreatmentView(double screenHeight, double screenWidth) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: screenWidth * 0.70,
                child: Helper().isvalidElement(treatmentList) &&
                        treatmentList.length > 0
                    ? DropdownButtonFormField(
                        menuMaxHeight: 300,

                        decoration: InputDecoration(
                          labelText: 'Treatment',
                          border: OutlineInputBorder(),
                          //icon: Icon(Icons.numbers),
                        ),
                        isExpanded: true,
                        // value: {treatmentDropdownvalue},
                        hint: Text(
                          'Select Treatment',
                        ),
                        // value:patternDropdownvalue,
                        onChanged: (item) async {
                          var data = item.toString().split('&*');
                          setState(() {
                            treatmentDropdownvalue = data[1];
                            fees.text = data[0];
                            treatmentName = data[1];
                            treatmentId = data[2];
                          });
                        },
                        items:
                            treatmentList.map<DropdownMenuItem<String>>((item) {
                          return DropdownMenuItem(
                            child: Text(
                              item['treatment_name'].toString(),
                            ),
                            value: item['fees'].toString() +
                                '&*' +
                                item['treatment_name'].toString() +
                                '&*' +
                                item['id'].toString() +
                                '&*',
                          );
                        }).toList(),
                      )
                    : DropdownButtonFormField(
                        // validator: (value) => validateDrops(value),
                        // isExpanded: true,
                        hint: Text('Select Treatment'),
                        // value:' _selectedState[i]',
                        onChanged: (Pharmacy) {
                          setState(() {});
                        },
                        items: [].map<DropdownMenuItem<String>>((item) {
                          return new DropdownMenuItem(
                            child: new Text(''),
                            value: '',
                          );
                        }).toList(),
                      ),
              ),
              SizedBox(width: screenWidth * 0.03),
              Container(
                width: 40, // Adjust size as needed
                height: 40, // Same as width for a perfect circle
                decoration: BoxDecoration(
                  color:
                      custom_color.appcolor, // Background color for the circle
                  shape: BoxShape.circle, // Makes the container circular
                ),
                child: IconButton(
                  onPressed: () {
                    var tre = 'treatment1';
                    storage.setItem('tre', tre);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddTretment(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 24, // Adjust icon size as needed
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: screenWidth * 0.4,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Fees',
                      border: OutlineInputBorder(),
                      // icon: Icon(Icons.numbers),
                    ),
                    controller: fees,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                SizedBox(
                    width: screenWidth * 0.48,
                    child: ElevatedButton(
                      child: Text(
                        "ADD TREATMENT",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              custom_color.appcolor),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ))),
                      onPressed: () async {
                        if (selectedPatient == null || selectedPatient == '') {
                          Fluttertoast.showToast(
                              msg: 'Please select Patient',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 15.0);
                        } else if (treatmentDropdownvalue == '' ||
                            treatmentDropdownvalue == 'Select Treatment') {
                          Fluttertoast.showToast(
                              msg: 'Please select treatment',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 15.0);
                        } else if (fees.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'Please enter Fees',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 15.0);
                        } else {
                          setState(() {
                            isloading = true;
                          });
                          var data = {
                            'treatment_id': treatmentId.toString(),
                            "treatment_name": treatmentName.toString().trim(),
                            "consult_fees": fees.text.toString(),
                            "description": ""
                          };
                          // print(data);
                          // print(data);
                          print(treatmentList);
                          var selected_treatment_data =
                              treatmentList.firstWhere(
                            (treatment) =>
                                treatment['treatment_name'].toString().trim() ==
                                treatmentName.toString().trim(),
                            orElse: () => null, // Return null if not found
                          );
                          print(selected_treatment_data);
                          if (selected_treatment_data != null) {
                            if (selectedTreatmentList.length > 0) {
                              for (var element in selectedTreatmentList) {
                                if (element['id'].toString() ==
                                    treatmentId.toString()) {
                                  Fluttertoast.showToast(
                                      msg: 'This Treatment Already Added',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 15.0);
                                } else {
                                  setState(() {
                                    selectedTreatmentList
                                        .add(selected_treatment_data);
                                    treatmentDropdownvalue = 'Select Treatment';
                                    fees.text = '';
                                    treatmentList = null;
                                  });
                                  await getTreatmentList();
                                }
                              }
                            } else {
                              setState(() {
                                selectedTreatmentList
                                    .add(selected_treatment_data);
                                treatmentDropdownvalue = 'Select Treatment';
                                fees.text = '';
                                treatmentList = null;
                              });
                              await getTreatmentList();
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Treatment not in your list',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 15.0);
                          }

                          if (treatmentList.length > 0) {
                            // int i = 0;
                            // for (var checkitem in treatmentList) {
                            //   if (checkitem['treatmentname'] ==
                            //       data['treatmentname']) {
                            //     Fluttertoast.showToast(
                            //         msg: 'This Treatment Already Added',
                            //         toastLength: Toast.LENGTH_SHORT,
                            //         gravity: ToastGravity.CENTER,
                            //         timeInSecForIosWeb: 2,
                            //         backgroundColor: Colors.red,
                            //         textColor: Colors.white,
                            //         fontSize: 15.0);

                            //     print('already added');
                            //     return;
                            //   } else {
                            //     i++;

                            //     if (treatmentList.length == i) {
                            //       this.setState(() {
                            //         treatmentList.add(data);
                            //         print(treatmentList);
                            //       });
                            //       totalCalcution();
                            //       print(treatmentList);
                            //       gettreatmentlist();

                            //       setState(() {
                            //         TreatmentList = null;
                            //         treatmentDropdownvalue = 'null';
                            //         fees.clear();
                            //       });
                            //       setState(() {
                            //         gettreatmentlist();
                            //       });
                            //       return;
                            //     }
                            //   }
                            // }
                          } else {
                            // setState(() {
                            //   treatmentList.add(data);

                            //   print(treatmentList);
                            // });
                            // totalCalcution();
                            // print(treatmentList);
                            // gettreatmentlist();

                            // setState(() {
                            //   TreatmentList = null;
                            //   treatmentDropdownvalue = 'null';
                            //   fees.clear();
                            // });
                            // setState(() {
                            //   gettreatmentlist();
                            // });
                            // return;
                          }
                          setState(() {
                            isloading = false;
                          });
                        }
                      },
                    )

                    // TextFormField(
                    //   decoration:  InputDecoration(
                    //     labelText: 'Clinic Notes',
                    //     border: OutlineInputBorder(),
                    //     //icon: Icon(Icons.numbers),
                    //   ),
                    //   // controller: addressController,
                    // ),
                    ),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Helper().isvalidElement(selectedTreatmentList) &&
                  selectedTreatmentList.length > 0
              ? Container(
                  width: screenWidth,
                  child: Text(
                    '  Treatment List :',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                )
              : Container(),
          // isloading
          // ? Container(
          //     height: screenHeight * 0.4,
          //     child: Text('isLoading'),
          //   )
          // :
          Container(
              padding: EdgeInsets.all(5),
              height: screenHeight * 0.4,
              width: screenWidth,
              child: Helper().isvalidElement(treatmentList)
                  ? ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: selectedTreatmentList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final data = selectedTreatmentList[index];
                        return Container(
                            child: Column(
                          children: [
                            Card(
                              child: ListTile(
                                title: Text(
                                  '${data['treatment_name'].toString()}',
                                ),
                                subtitle:
                                    Text('${"₹ " + data['fees'].toString()}'),
                                trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedTreatmentList.remove(data);
                                      // totalCalcution();
                                    });
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            // ListTile(title: Text('Test name'),
                            // trailing: IconButton(onPressed: (){} ,icon: Icon(Icons.add)),),
                            // Divider(
                            //   height: 0.1,
                            // )
                          ],
                        ));
                      })
                  : Container()),
          SizedBox(
            height: screenHeight * 0.008,
          ),
          Container(
            width: screenWidth,
            decoration: BoxDecoration(
              color: custom_color.appcolor, // Background color
              borderRadius: BorderRadius.circular(5), // Adjust radius as needed
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Total Treatment Amount : ₹ ${totalTreatmentAmount()}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget renderFabIcons(screenWidth, screenHeight) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: screenWidth * 0.08,
            height: screenHeight * 0.038,
            child: FloatingActionButton(
              backgroundColor: custom_color.appcolor,
              heroTag: 'undo',
              onPressed: () {
                if (activeTab == 'Medicine') {
                  medicineControllers[medicineActiveIndex].undo();
                } else if (activeTab == 'Lab') {
                  labControllers[labActiveIndex].undo();
                } else {
                  injectionControllers[injectionActiveIndex].undo();
                }
              },
              tooltip: 'Undo',
              child: Icon(
                Icons.undo,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.02),
          SizedBox(
            width: screenWidth * 0.08,
            height: screenHeight * 0.038,
            child: FloatingActionButton(
              backgroundColor: custom_color.appcolor,
              heroTag: 'redo',
              onPressed: () {
                if (activeTab == 'Medicine') {
                  medicineControllers[medicineActiveIndex].redo();
                } else if (activeTab == 'Lab') {
                  labControllers[labActiveIndex].redo();
                } else {
                  injectionControllers[injectionActiveIndex].redo();
                }
              },
              tooltip: 'Redo',
              child: Icon(
                Icons.redo,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.02),
          SizedBox(
            width: screenWidth * 0.08,
            height: screenHeight * 0.038,
            child: FloatingActionButton(
              backgroundColor: custom_color.appcolor,
              heroTag: 'clear',
              onPressed: () {
                if (activeTab == 'Medicine') {
                  medicineControllers[medicineActiveIndex].clear();
                } else if (activeTab == 'Lab') {
                  labControllers[labActiveIndex].clear();
                } else {
                  injectionControllers[injectionActiveIndex].clear();
                }
              },
              tooltip: 'Clear',
              child: Icon(
                Icons.clear,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget renderDotNavigation(screenWidth, screenHeight) {
    var checkIndex = activeTab == 'Medicine'
        ? medicineActiveIndex
        : activeTab == 'Lab'
            ? labActiveIndex
            : injectionActiveIndex;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            // if (activeTab == 'Medicine') {
            //   medicinePageController.animateToPage(
            //     index,
            //     duration: Duration(milliseconds: 300),
            //     curve: Curves.easeInOut,
            //   );
            // } else if (activeTab == 'Lab') {
            //   labPageController.animateToPage(
            //     index,
            //     duration: Duration(milliseconds: 300),
            //     curve: Curves.easeInOut,
            //   );
            // } else {
            //   injectionPageController.animateToPage(
            //     index,
            //     duration: Duration(milliseconds: 300),
            //     curve: Curves.easeInOut,
            //   );
            // }
            int targetIndex = index; // Target index to jump to
            if (activeTab == 'Medicine') {
              if (targetIndex < medicineControllers.length) {
                medicinePageController.jumpToPage(targetIndex);
                setState(() {
                  medicineActiveIndex = targetIndex;
                });
              }
            } else if (activeTab == 'Lab') {
              if (targetIndex < labControllers.length) {
                labPageController.jumpToPage(targetIndex);
                setState(() {
                  labActiveIndex = targetIndex;
                });
              }
            } else {
              if (targetIndex < injectionControllers.length) {
                injectionPageController.jumpToPage(targetIndex);
                setState(() {
                  injectionActiveIndex = targetIndex;
                });
              }
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              width: checkIndex == index
                  ? screenWidth * 0.058
                  : screenWidth * 0.045,
              height: checkIndex == index
                  ? screenHeight * 0.058
                  : screenHeight * 0.045,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    checkIndex == index ? custom_color.appcolor : Colors.grey,
              ),
              alignment:
                  Alignment.center, // Center the text inside the container
              child: Text(
                "${index + 1}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: checkIndex == index ? 14 : 12, // Adjust font size
                  fontWeight: FontWeight.bold, // Make the text bold
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  renderAutoComplete(screenWidth, screenHeight) {
    return Autocomplete<List>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<List>.empty();
        }
        if (textEditingValue.text.length < 1) {
          return const Iterable<List>.empty();
        } else {
          var matches = [];
          matches.addAll(PatientList);
          matches.retainWhere((s) {
            return s['customer_name']
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
          setState(() {});
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
            decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.search,
                color: custom_color.appcolor,
              ),
              hintText: 'Search Patient Name',

              // suffixIcon: const Icon(Icons.search,color: custom_color.appcolor,),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: custom_color.appcolor,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: custom_color.appcolor,
                  width: 1.0,
                ),
              ),
            ),

            // decoration:  InputDecoration(
            //     border: OutlineInputBorder(),
            //     // prefix: Icon(Icons.search),
            //     prefixIcon: Icon(Icons.search),
            //     hintText: ' Search Patient Name'),
            onFieldSubmitted: (String value) {
              onFieldSubmitted();
            });
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<List> onSelected, Iterable<List> options) {
        return options.toList()[0].isNotEmpty
            ? Align(
                alignment: Alignment.topLeft,
                child: Material(
                  child: SizedBox(
                    width: screenWidth * 0.9,
                    // height: screenHeight * 0.8,
                    // color:Colors.transparent,
                    // color: Colors.white,
                    child: Card(
                      color: Colors.transparent,
                      elevation: 30,
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(5.0),
                              itemCount: options.toList()[0].length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                final option =
                                    options.toList()[0].elementAt(index);
                                return GestureDetector(
                                  onTap: () {
                                    storage.setItem('selectedPatient',
                                        options.toList()[0][index]);
                                    setState(() {
                                      showAutoComplete = false;
                                      selectedPatient =
                                          options.toList()[0][index];
                                    });
                                  },
                                  child: Card(
                                    // color: Colors.grey,
                                    color: custom_color.appcolor,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15.0, bottom: 8, top: 8),
                                          child: Text(
                                            '${options.toList()[0][index]['customer_name'].toString()} , ${options.toList()[0][index]['phone'].toString()}',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Align(
                alignment: Alignment.topLeft,
                child: Material(
                  child: Container(
                    width: screenWidth * 0.88,
                    color: Colors.grey.shade400,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(5.0),
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              // setState(() {
                              //   selectedPatient = options.toList()[0][index];
                              //   showAutoComplete = false;
                              // });
                            },
                            child: Card(
                              color: custom_color.appcolor,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 8.0, bottom: 8.0, left: 15),
                                child: Text(
                                  'Search List Empty',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ));
                      },
                    ),
                  ),
                ),
              );
      },
    );
  }

  renderSelectedPharmacyDetails(screenWidth, screenHeight) {
    return SizedBox(
      width: screenWidth,
      child: TextFormField(
        decoration: InputDecoration(
          suffixIcon: InkWell(
              child: Icon(
                Icons.clear,
                color: Colors.red,
              ),
              onTap: () {
                setState(() {
                  // table_list.clear();
                  // medicineController.clear();
                  // medicineshowAutoComplete = true;
                  pharmacyController.clear();
                  //  pharmacyshowAutoComplete =false;
                  selectedPharmacy = null;
                  pharmacyshowAutoComplete = true;
                });
              }),
          labelText: 'Pharmacy Name',
          border: OutlineInputBorder(),
          // icon: Icon(Icons.numbers),
        ),
        controller: pharmacyController,
        onChanged: (text) {
          setState(() {
            // table_list.clear();
            // medicineController.clear();
            // medicineshowAutoComplete = false;
            selectedPharmacy = null;
            // getMedicineList();

            pharmacyController.text.isEmpty
                ? pharmacyshowAutoComplete = true
                : pharmacyshowAutoComplete = false;
          });
        },
        // keyboardType: TextInputType.numberWithOptions(decimal: true),
      ),
    );
  }

  renderSelectedLabDetails(screenWidth, screenHeight) {
    return SizedBox(
      // width: 180,
      child: TextFormField(
        decoration: InputDecoration(
          suffixIcon: InkWell(
            child: Icon(
              Icons.clear,
              color: Colors.red,
            ),
            onTap: () {
              setState(() {
                selectedLab = null;
                // testList.clear();
                // testnameController.clear();
                labshowAutoComplete = true;
                labnameController.clear();
                // testshowAutoComplete = true;
              });
            },
          ),
          labelText: 'Lab Name',
          border: OutlineInputBorder(),
          // icon: Icon(Icons.numbers),
        ),
        controller: labnameController,
        onChanged: (text) {
          setState(() {
            selectedLab = null;
            // testList.clear();
            // testnameController.clear();

            labnameController.text.isEmpty
                ? labshowAutoComplete = true
                : labshowAutoComplete = false;
            // testshowAutoComplete = true;
            // labnameController.text.isEmpty? SelectedLab='':labshowAutoComplete=false;
            // TestList=null;
            // getLabtestNameList();
          });
        },
        // keyboardType: TextInputType.numberWithOptions(decimal: true),
      ),
    );
  }

  renderLablistAutoComplete(screenWidth, screenHeight) {
    return Autocomplete<List>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return Iterable<List>.empty();
        }
        if (textEditingValue.text.length < 1) {
          return Iterable<List>.empty();
        } else {
          var matches = [];
          matches.addAll(mediAndLabNameList);
          matches.retainWhere((s) {
            return s['pharmacy_name']
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
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                // prefix: Icon(Icons.search),
                suffixIcon: Icon(
                  Icons.search,
                  color: custom_color.appcolor,
                ),
                hintText: ' Search Lab Name'),
            onFieldSubmitted: (String value) {
              onFieldSubmitted();
            });
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<List> onSelected, Iterable<List> options) {
        return options.toList()[0].isNotEmpty
            ? Align(
                alignment: Alignment.topLeft,
                child: Material(
                  child: Container(
                    width: screenWidth * 0.95,
                    // height: screenHeight * 0.4,
                    color: Colors.white,
                    child: ListView.builder(
                      padding: EdgeInsets.all(5.0),
                      shrinkWrap: true,
                      itemCount: options.toList()[0].length,
                      itemBuilder: (BuildContext context, int index) {
                        final option = options.toList()[0].elementAt(index);

                        return GestureDetector(
                          onTap: () {
                            //  storage.setItem(
                            //     'selectedPatient', options.toList()[0][index]);
                            setState(() {
                              labshowAutoComplete = false;
                              // testshowAutoComplete = true;
                              selectedLab = options.toList()[0][index];
                              labnameController.text = Helper().isvalidElement(
                                      selectedLab['pharmacy_name'])
                                  ? selectedLab['pharmacy_name']
                                  : '';
                              // getLabtestNameList();
                              // getLabtestNameList();
                            });
                          },
                          child: Card(
                            // color: Colors.grey,
                            color: custom_color.appcolor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 8.0, bottom: 8.0, left: 15),
                                  child: Text(
                                      '${options.toList()[0][index]['pharmacy_name'].toString()} ',
                                      style: TextStyle(color: Colors.white)),
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
              )
            : Align(
                alignment: Alignment.topCenter,
                child: Material(
                  child: Container(
                    width: screenWidth * 0.9,
                    color: Colors.blue.shade100,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(5.0),
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              // setState(() {
                              //   selectedPatient = options.toList()[0][index];
                              //   showAutoComplete = false;
                              // });
                            },
                            child: Card(
                              color: custom_color.appcolor,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Search List Empty',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ));
                      },
                    ),
                  ),
                ),
              );
      },
    );
  }

  renderpharmacylistAutoComplete(screenWidth, screenHeight) {
    return Autocomplete<List>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return Iterable<List>.empty();
        }
        if (textEditingValue.text.length < 1) {
          return Iterable<List>.empty();
        } else {
          var matches = [];
          matches.addAll(mediAndLabNameList);
          matches.retainWhere((s) {
            return s['pharmacy_name']
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
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                // prefix: Icon(Icons.search),
                suffixIcon: Icon(
                  Icons.search,
                  color: custom_color.appcolor,
                ),
                hintText: ' Search pharmacy Name'),
            onFieldSubmitted: (String value) {
              onFieldSubmitted();
            });
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<List> onSelected, Iterable<List> options) {
        return options.toList()[0].isNotEmpty
            ? Align(
                alignment: Alignment.topLeft,
                child: Material(
                  child: Container(
                    width: screenWidth * 0.95,
                    // height: screenHeight * 0.4,
                    color: Colors.white,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(5.0),
                      itemCount: options.toList()[0].length,
                      itemBuilder: (BuildContext context, int index) {
                        final option = options.toList()[0].elementAt(index);

                        return GestureDetector(
                          onTap: () {
                            //  storage.setItem(
                            //     'selectedPatient', options.toList()[0][index]);
                            setState(() {
                              pharmacyshowAutoComplete = false;
                              // testshowAutoComplete = true;
                              selectedPharmacy = options.toList()[0][index];
                              // medicineshowAutoComplete = true;
                              // getMedicineList();
                              pharmacyController.text = Helper().isvalidElement(
                                      selectedPharmacy['pharmacy_name'])
                                  ? selectedPharmacy['pharmacy_name']
                                  : '';
                              // getLabtestNameList();
                            });
                          },
                          child: Card(
                            // color: Colors.grey,
                            color: custom_color.appcolor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 15.0, top: 8.0, bottom: 8.0),
                                  child: Text(
                                      '${options.toList()[0][index]['pharmacy_name'].toString()} ',
                                      style: TextStyle(color: Colors.white)),
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
              )
            : Align(
                alignment: Alignment.topCenter,
                child: Material(
                  child: Container(
                    width: screenWidth * 0.9,
                    color: Colors.blue.shade100,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(5.0),
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              // setState(() {
                              //   selectedPatient = options.toList()[0][index];
                              //   showAutoComplete = false;
                              // });
                            },
                            child: const Card(
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text('Search List Empty'),
                              ),
                            ));
                      },
                    ),
                  ),
                ),
              );
      },
    );
  }

  showSuccessAnimation(context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });

        return Dialog(
          backgroundColor: Colors.transparent,
          child: Lottie.asset(
            'assets/json/success.json',
            width: screenWidth * 0.5,
            height: screenHeight * 0.5,
            repeat: false, // Play animation only once
          ),
        );
      },
    );
  }
}
