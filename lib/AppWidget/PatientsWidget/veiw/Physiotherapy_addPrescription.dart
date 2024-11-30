import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/AppWidget/common/Colors.dart' as CustomColors;
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/Colors.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;
import 'package:flutter_svg/flutter_svg.dart';

class PhysiotherapyAddprescription extends StatefulWidget {
  const PhysiotherapyAddprescription({super.key});

  @override
  State<PhysiotherapyAddprescription> createState() =>
      _PhysiotherapyAddprescriptionState();
}

class _PhysiotherapyAddprescriptionState
    extends State<PhysiotherapyAddprescription> {
  final LocalStorage storage = new LocalStorage('doctor_store');
  TextEditingController patientnameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobilenumberController = TextEditingController();
  TextEditingController referedbyController = TextEditingController();

  TextEditingController chiefcomolaintsController = TextEditingController();
  TextEditingController observationController = TextEditingController();
  TextEditingController palpationController = TextEditingController();
  TextEditingController specialtestController = TextEditingController();
  var accesstoken;
  var selectedPatient;
  bool showAutoComplete = true;
  var PatientList;
  bool isloading = false;
  bool patient = true;
  bool bodyChart = false;
  Map<String, Color> partColors = {
    'head': Colors.black,
    'face': Colors.black,
    'neck': Colors.black,
    'shoulder-left': Colors.black,
    'shoulder-right': Colors.black,
    'arm-left': Colors.black,
    'forearm-left': Colors.black,
    'arm-right': Colors.black,
    'forearm-right': Colors.black,
    'chest-left': Colors.black,
    'chest-right': Colors.black,
    'belly-left': Colors.black,
    'ribs-left': Colors.black,
    'belly-right': Colors.black,
    'belly': Colors.black,
    'ribs-right': Colors.black,
    'thigh-left': Colors.black,
    'innerthigh-left': Colors.black,
    'feet-left': Colors.black,
    'calf-left': Colors.black,
    'knee-left': Colors.black,
    'thigh-right': Colors.black,
    'genitalia': Colors.black,
    'innerthigh-right': Colors.black,
    'right-feet': Colors.black,
    'calf-right': Colors.black,
    'knee-right': Colors.black,
    'elbow-right': Colors.black,
    'hand-right': Colors.black,
    'elbow-left': Colors.black,
    'hands-left': Colors.black,
    'armback-left': Colors.black,
    'leg-left': Colors.black,
    'buttock': Colors.black,
    'loin': Colors.black,
    'column': Colors.black,
    'head-back': Colors.black,
    'nape': Colors.black,
    'armback-right': Colors.black,
    'leg-right': Colors.black,
    'back-right': Colors.black,
    'clavicule-right': Colors.black,
    'back-left': Colors.black,
    'clavicule-left': Colors.black,
  };

  @override
  void initState() {
    super.initState();
    accesstoken = storage.getItem('userResponse')['access_token'];
    selectedPatient = storage.getItem('selectedcustomer');
    method();
    getpatientlist();
  }

  method() {
    showAutoComplete = Helper().isvalidElement(selectedPatient) ? false : true;
  }

  void onPartTapped(String partId) {
    setState(() {
      // Toggle between two colors (Black and Red as an example)
      partColors[partId] =
          partColors[partId] == Colors.black ? Colors.red : Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height - 50;
    double screenWidth = MediaQuery.of(context).size.width;
    return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Dash()));
          storage.deleteItem('selectedcustomer');
          selectedPatient = null;
          showAutoComplete = true;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: appcolor,
            title: Text(
              'Add Prescription',
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Dash()));
                  storage.deleteItem('selectedcustomer');
                  selectedPatient = null;
                  showAutoComplete = true;
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          ),
          body: isloading
              ? Container(
                  width: screenWidth,
                  child: Column(children: [
                    SizedBox(
                      height: 1,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                            child: Column(children: [
                      showAutoComplete
                          ? Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Card(
                                  child: renderAutoComplete(
                                      screenWidth, screenHeight)),
                            )
                          : Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                  child: Column(
                                children: [
                                  Card(
                                    child: ListTile(
                                      title: Row(
                                        children: [
                                          Icon(Icons.people,
                                              color: custom_color.appcolor),
                                          Text(
                                            '     ${selectedPatient['customer_name'].toString()}',
                                          ),
                                        ],
                                      ),
                                      subtitle: Text(
                                          '             ${selectedPatient['phone'].toString()}'),
                                      trailing: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedPatient = null;
                                            showAutoComplete = true;
                                            patientnameController.clear();
                                            ageController.clear();
                                            genderController.clear();
                                            occupationController.clear();
                                            addressController.clear();
                                            mobilenumberController.clear();
                                            referedbyController.clear();
                                          });
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                            ),
                      SizedBox(height: 10),
                      patient
                          ? Container(
                              child: patientwidget(),
                            )
                          : Container(),
                      // SizedBox(height: 10),
                      bodyChart
                          ? Container(
                              child: bodychart(),
                            )
                          : Container(),
                    ])))
                  ]))
              : SpinLoader(),
        ));
  }

  bodychart() {
    double screenHeight = MediaQuery.of(context).size.height - 50;
    double screenWidth = MediaQuery.of(context).size.width;
    String head = '''
        <svg viewBox="0 0 68.587668 92.604164">
        <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['head'])};" d="m 11.671635,6.3585449 -0.0482,-2.59085 4.20648,-2.46806 4.42769,2.95361 -0.0405,1.94408 0.24197,-3.34467 -2.03129,-2.31103004 -2.84508,-0.51629 -2.20423,0.52915 -1.9363,2.63077004 z" id="head"/>
        </svg>
    ''';
    String face = '''
        <svg viewBox="0 0 68.587668 92.604164">
        <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['face'])};" d="m 19.748825,6.7034949 0.0203,-2.20747 -3.96689,-2.7637 -3.74099,2.23559 -0.006,2.63528 -0.60741,0.0403 0.27408,1.82447 0.97635,0.33932 0.44244,2.1802901 1.82222,2.06556 2.03518,-0.0607 1.79223,-1.94408 0.35957,-2.2406601 0.97616,-0.33932 0.25159,-1.78416 z" id="face" />
        </svg>
    ''';
    String neck = '''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" id="neck" style="opacity:1; fill: ${colorToHex(partColors['neck'])};" d="m 13.304665,11.910505 1.64975,2.35202 0.74426,2.62159 -1.73486,-1.38354 -0.86649,-2.97104 z m 5.08047,0 -1.64975,2.35202 -0.74538,2.62234 1.73486,-1.38354 0.86649,-2.97104 z"/>
        </svg>
    ''';
    String shoulderleft = '''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" id="shoulder-left" style="opacity:1; fill: ${colorToHex(partColors['shoulder-left'])};" d="m 19.047795,13.248365 3.55748,1.97916 0.72653,-0.35074 z m -0.107,0.43288 -0.37119,1.73073 2.1846,0.53561 1.40116,-0.49436 z m 3.98151,1.97595 0.75814,-0.41 2.40806,1.66799 1.17364,1.50707 0.62662,1.5626 -0.0464,3.70194 -1.3284,-1.72153 0.0407,-2.59376 -0.48842,-0.50049 c 0,0 -3.09778,-3.19058 -3.14371,-3.21401 z m -0.2409,0.10873 c -0.001,0.0525 3.32987,3.54733 3.32987,3.54733 l 0.10067,3.10396 -1.15426,-1.97782 -2.22547,-0.94804 -1.56576,-2.88481 z"/>
        </svg>
    ''';
    String shoulderright = '''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" id="shoulder-right" style="opacity:1; fill: ${colorToHex(partColors['shoulder-right'])};" d="m 12.624785,13.248365 -3.5574599,1.97916 -0.72653,-0.35074 z m 0.107,0.43288 0.37119,1.73073 -2.18459,0.53561 -1.4011499,-0.49436 z m -3.9814899,1.97595 -0.75814,-0.41 -2.40806,1.66799 -1.17364,1.50707 -0.62662,1.56259 0.0464,3.70195 1.3284,-1.72153 -0.0407,-2.59376 0.48843,-0.5005 c 0,0 3.09777,-3.19057 3.1437,-3.214 z m 0.2409,0.10873 c 0.002,0.0525 -3.32987,3.54733 -3.32987,3.54733 l -0.10067,3.10396 1.15426,-1.97782 2.22547,-0.94804 1.5657499,-2.88481 z"/>
        </svg>
    ''';
    String armleft = '''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" id="arm-left" style="opacity:1; fill: ${colorToHex(partColors['arm-left'])};" d="m 27.621665,30.814715 -0.33838,1.70499 -1.81932,-2.54418 -0.6629,-1.26895 z m -2.85271,-2.6096 c -0.0259,-0.0144 -0.0536,-0.0254 -0.0824,-0.0324 l -1.48333,-4.95503 1.00456,-2.08428 1.65511,1.74532 2.23034,6.67667 0.0415,0.93739 c -1.06528,-0.84215 -2.18962,-1.60679 -3.36434,-2.28803 z m 1.6945,-5.75654 1.64893,6.43421 -0.36469,-4.92266 z"/>
        </svg>
    ''';
    String forearmleft = '''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" id="forearm-left" style="opacity:1; fill: ${colorToHex(partColors['forearm-left'])};" d="m 26.955425,32.969125 1.30083,10.28927 -1.10778,0.01 -1.89387,-7.99609 0.19174,-4.53719 z m 1.21978,-1.94971 -0.58729,2.58635 1.11876,9.15614 0.55849,-0.21663 0.2304,-6.77018 z"/>
        </svg>
    ''';
    String armright = '''
        <svg width="20%" height="50%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" id="arm-right" style="opacity:1; fill: ${colorToHex(partColors['arm-right'])};" d="m 4.0746451,30.814715 0.33838,1.70499 1.81931,-2.54418 0.66289,-1.26895 z m 2.8527,-2.6096 c 0.0259,-0.0144 0.0536,-0.0254 0.0824,-0.0324 l 1.48332,-4.95503 -1.00455,-2.08428 -1.65509,1.74532 -2.23034,6.67667 -0.0415,0.93739 c 1.06528,-0.84215 2.18961,-1.60679 3.36433,-2.28803 z m -1.6945,-5.75654 -1.64891,6.43421 0.36468,-4.92266 z"/>
        </svg>
    ''';
    String forearmright = '''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" id="forearm-right" style="opacity:1; fill: ${colorToHex(partColors['forearm-right'])};" d="m 4.5752651,32.969125 -1.30083,10.28927 1.10778,0.01 1.89387,-7.99609 -0.19174,-4.53719 z m -1.21978,-1.94971 0.58728,2.58635 -1.11875,9.15614 -0.55849,-0.21663 -0.2304,-6.77018 z"/>
        </svg>
    ''';
    String chestleft = '''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['chest-left'])};" d="m 20.337455,17.085495 1.72942,3.09103 1.89346,0.94785 -1.15295,0.90662 -0.90604,2.63773 -2.09968,0.86537 -3.34524,-1.655 0.83425,-6.50527 z" id="chest-left" />
        </svg>
    ''';
    String chestright = '''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['chest-right'])};" d="m 11.351215,17.085495 -1.7294199,3.09103 -1.89346,0.94785 1.15295,0.90662 0.90586,2.63773 2.0996699,0.86537 3.34636,-1.655 -0.83462,-6.50527 z" id="chest-right" />
        </svg>
    ''';
    String bellyleft = '''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['belly-left'])};" d="m 19.641935,34.707615 1.81341,-1.36479 0.15748,1.83347 1.28642,2.37338 -1.98044,2.73652 -1.03109,0.16554 -0.37026,-3.88816 z" id="belly-left" />
        </svg>
    ''';
    String ribsleft = '''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" id="ribs-left" style="opacity:1; fill: ${colorToHex(partColors['ribs-left'])};" d="m 19.288925,26.151995 -3.11202,-1.40604 0.0937,2.27965 2.80119,1.43603 z m 1.93471,1.66849 -1.29355,0.7212 0.14997,-1.70898 z m -1.05303,-1.63718 2.47968,-1.03241 -0.9336,2.52093 z m 1.53164,1.73729 -1.69005,1.03372 -0.28871,2.0678 1.64975,-1.07533 z m -2.91143,1.10421 -0.0622,1.62387 -2.30308,-0.49961 -0.12448,-2.21722 z m -0.1556,2.4045 0.0311,1.99844 -2.20953,0.59391 -0.0311,-3.1227 z m 2.65459,-0.98535 -1.48383,1.03372 -0.20622,2.10905 1.64862,-1.32355 z"/>
        </svg>
    ''';
    String bellyright = '''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['belly-right'])};" d="m 12.045985,34.707615 -1.81341,-1.36479 -0.15748,1.83347 -1.2856799,2.37432 1.9804499,2.73595 1.03109,0.16554 0.37119,-3.88721 z" id="belly-right" />
        </svg>
    ''';
    String belly = '''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" id="belly" style="opacity:1; fill: ${colorToHex(partColors['belly'])};" d="m 15.636055,44.919735 -0.60647,-5.91209 -0.015,-3.84879 -2.18479,-1.07533 -0.24746,7.03017 z m 0.41581,-5.7e-4 0.60628,-5.91209 0.0154,-3.84915 2.18404,-1.07515 0.24746,7.03017 z"/>
        </svg>
    ''';
    String ribsright  = '''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" id="ribs-right" style="opacity:1; fill: ${colorToHex(partColors['ribs-right'])};" d="m 12.399365,26.152365 3.11202,-1.40603 -0.0937,2.27965 -2.80138,1.4364 z m -1.93508,1.6685 1.29355,0.72139 -0.14997,-1.70899 z m 1.05303,-1.637 -2.4793099,-1.03259 0.93361,2.52148 z m -1.5316399,1.73729 1.6900499,1.03372 0.28871,2.06743 -1.64881,-1.07515 z m 2.9114199,1.10421 0.0623,1.62387 2.30327,-0.49961 0.12448,-2.21703 z m 0.15561,2.40432 -0.0309,1.99844 2.20973,0.59353 0.0311,-3.1227 z m -2.6546,-0.98516 1.48384,1.0339 0.20622,2.10905 -1.64975,-1.32355 z"/>
        </svg>
    ''';
    String thighleft ='''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" id="thigh-left" style="opacity:1; fill: ${colorToHex(partColors['thigh-left'])};" d="m 23.419015,50.399125 -0.15504,4.75091 -2.40263,6.60949 0.7362,1.90021 2.36401,-8.34435 z m -0.58154,-11.60825 -0.15485,4.00722 1.31793,7.93154 0.61977,-6.40308 z m -0.38731,5.12268 -2.75152,6.07258 -0.62015,4.87425 1.16232,6.85771 2.51886,-6.98144 0.15504,-7.18764 z"/>
        </svg>
    ''';
    String innerthighleft ='''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" id="innerthigh-left" style="opacity:1; fill: ${colorToHex(partColors['innerthigh-left'])};" d="m 22.063225,39.369605 v 4.21363 l -2.94574,5.82511 -1.86027,5.78349 0.19365,-4.0072 z m -3.24944,13.42596 -0.0649,0.15467 -1.21294,2.90207 0.78325,7.18803 1.23619,-0.66122 -1.0714,-6.69272 z"/>
        </svg>
    ''';
    String feetleft ='''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['feet-left'])};" d="m 17.255895,87.868445 0.1243,3.45228 0.28983,1.20638 h 0.87136 l 0.24897,-0.83181 0.29058,-0.0416 -0.0624,0.83181 1.09914,-0.33332 0.29058,-0.16629 1.24444,-0.27033 0.0416,-0.97748 -1.20319,-2.03743 -0.82974,-1.0399 -2.03294,-0.83181 z" id="feet-left" />
        </svg>
    ''';
    String calfleft ='''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" id="calf-left" style="opacity:1; fill: ${colorToHex(partColors['calf-left'])};" d="m 18.251375,70.441125 0.29058,0.91486 0.6224,3.8681 0.0829,5.15733 -0.87136,5.03304 0.0412,-6.44714 -0.91242,-2.57848 -0.12561,-2.82837 z m 1.9915,2.32915 -0.20753,7.73637 -1.65949,6.23904 1.80478,-0.853 3.00816,-10.83583 -1.03727,-6.82095 z"/>
        </svg>
    ''';
    String kneeleft ='''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" id="knee-left" style="opacity:1; fill: ${colorToHex(partColors['knee-left'])};" d="m 21.404635,64.784375 0.1243,1.12295 -0.87118,1.08171 -0.29058,1.70599 -0.58116,0.24933 -0.49774,-2.57866 -0.33182,-0.91486 0.29058,-0.58247 z m -3.85853,0.0832 0.6224,1.74685 1.3273,2.57867 -0.33182,2.37095 -0.95423,-2.66209 -0.78738,-1.49734 z m 4.97811,-2.37039 -0.95423,5.11609 0.62241,-0.33295 0.49773,1.66381 z"/>
        </svg>
    ''';
    String thighright ='''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" id="thigh-right" style="opacity:1; fill: ${colorToHex(partColors['thigh-right'])};" d="m 8.2694651,50.399125 0.15504,4.75053 2.4026299,6.60968 -0.73638,1.90021 -2.3640099,-8.34435 z m 0.58117,-11.60768 0.15503,4.00684 -1.31754,7.93154 -0.61978,-6.40308 z m 0.38769,5.1223 2.7515099,6.07239 0.61997,4.87425 -1.16232,6.85771 -2.5190499,-6.98163 -0.15504,-7.18801 z"/>
        </svg>
    ''';
    String genitalia ='''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" id="genitalia" style="opacity:1; fill: ${colorToHex(partColors['genitalia'])};" d="m 14.404465,45.040075 0.0221,-0.0277 -0.14866,-0.37945 -3.10172,-3.40449 -0.23283,-0.0825 2.05918,5.32009 z m -1.17263,2.01833 1.27705,3.29948 0.42631,-4.04862 -0.25196,-0.64303 z m 4.05219,-2.01795 -0.0221,-0.0281 0.14867,-0.37926 3.10171,-3.40449 0.23246,-0.0825 -2.05843,5.3199 z m 1.17263,2.01795 -1.27706,3.29948 -0.42631,-4.04843 0.25197,-0.64303 z"/>
        </svg>
    ''';
    String innerthighright ='''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" id="innerthigh-right" style="opacity:1; fill: ${colorToHex(partColors['innerthigh-right'])};" d="m 9.6258251,39.369415 v 4.21363 l 2.9451699,5.8253 1.86028,5.78349 -0.19366,-4.0072 z m 3.2488699,13.42559 0.0647,0.15485 1.21294,2.90207 -0.78307,7.18803 -1.23618,-0.66102 1.0714,-6.69273 z"/>
        </svg>
    ''';
    String rightfeet ='''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['right-feet'])};" d="m 14.433335,87.868265 -0.12448,3.45228 -0.29058,1.20637 h -0.87118 l -0.24877,-0.83181 -0.29059,-0.0416 0.0623,0.83181 -1.09934,-0.33333 -0.29058,-0.16629 -1.2448,-0.27033 -0.0412,-0.97747 1.2031899,-2.03781 0.82975,-1.04009 2.03294,-0.83181 z" id="right-feet" />
        </svg>
    ''';
    String calfright ='''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" id="calf-right" style="opacity:1; fill: ${colorToHex(partColors['calf-right'])};" d="m 13.437675,70.440945 -0.29058,0.91486 -0.62241,3.86828 -0.0829,5.15733 0.87174,5.03304 -0.0418,-6.44714 0.91298,-2.57848 0.1243,-2.82837 z m -1.99151,2.32914 0.20735,7.73637 1.65968,6.23904 -1.80497,-0.85299 -3.0079799,-10.83584 1.03728,-6.82095 z"/>
        </svg>
    ''';
    String kneeright ='''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" id="knee-right" style="opacity:1; fill: ${colorToHex(partColors['knee-right'])};" d="m 10.284405,64.784375 -0.12448,1.12295 0.87118,1.08171 0.29058,1.70599 0.58116,0.24933 0.49774,-2.57866 0.33182,-0.91486 -0.29058,-0.58247 z m 3.85854,0.0832 -0.62241,1.74685 -1.32767,2.57867 0.33182,2.37095 0.95423,-2.66209 0.78832,-1.4964 z m -4.9786799,-2.37058 0.9542299,5.11609 -0.6223999,-0.33313 -0.49793,1.6638 z"/>
        </svg>
    ''';
    String elbowright ='''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['elbow-right'])};" d="m 3.2054751,27.370125 0.005,3.09419 -0.57959,1.91184 -0.54539,-2.41185 z" id="elbow-right" />
        </svg>
    ''';
    String handright ='''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['hand-right'])};" d="m 4.3904451,43.563145 -1.5198,0.0506 -0.76631,-0.67112 -1.21261996,2.15767 -0.86245,3.32873 0.49386,0.22113 0.59814996,-2.20238 0.50016,0.25356 -0.35639,2.49422 0.62382,0.24345 0.41402,-2.49194 0.55839,0.17851 -0.2262,2.76603 0.76938,0.32268 0.25788,-2.86764 0.4578,-0.0181 0.16611,2.65239 0.65997,0.2633 0.0712,-4.56643 0.34158,-0.19428 1.35316,1.68367 0.32832,-0.34354 -0.72644,-2.0551 z" id="hand-right" />
        </svg>
    ''';
    String elbowleft ='''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['elbow-left'])};" d="m 28.325215,27.370125 -0.005,3.09419 0.57959,1.91184 0.54538,-2.41185 z" id="elbow-left" />
        </svg>
    ''';
    String handsleft ='''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['hands-left'])};" d="m 27.140245,43.563145 1.5198,0.0506 0.76631,-0.67111 1.21262,2.15766 0.86245,3.32873 -0.49386,0.22113 -0.59815,-2.20238 -0.50016,0.25356 0.35639,2.49422 -0.62382,0.24345 -0.41402,-2.49194 -0.55839,0.17851 0.2262,2.76603 -0.76938,0.32268 -0.25788,-2.86764 -0.4578,-0.0181 -0.16611,2.6524 -0.65997,0.26329 -0.0712,-4.56643 -0.34158,-0.19428 -1.35316,1.68368 -0.32832,-0.34355 0.72644,-2.0551 z" id="hands-left" />
        </svg>
    ''';


    String armbackleft ='''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" id="armback-left" style="opacity:1; fill: ${colorToHex(partColors['armback-left'])};" d="m 43.185645,27.069445 0.4297,-1.4164 1.30458,-1.68577 -1.39393,-2.96155 -2.28367,0.92162 -1.83567,1.7467 -0.53524,1.78673 0.27068,4.30806 z m -2.46869,15.35539 -1.5182,0.0863 -0.78184,-0.65295 -1.16168,2.1855 -0.78414,3.34805 0.49892,0.20949 0.54632,-2.2158 0.50597,0.24175 -0.29779,2.5019 0.62936,0.22875 0.35546,-2.50096 0.56242,0.16536 -0.16126,2.77057 0.77674,0.30455 0.19056,-2.87291 0.45724,-0.0289 0.22827,2.64778 0.66597,0.24774 -0.0359,-4.56685 0.33693,-0.20224 1.39227,1.65147 0.32017,-0.35115 -0.77444,-2.03749 z m -0.97726,-0.17765 -1.43509,-0.746 -0.30622,-7.00985 c 0,0 0.64359,-2.77938 0.63694,-3.06274 l 0.6093,-1.21924 3.62552,-2.56583 -0.68276,1.9919 0.41561,4.74788 -1.80402,7.69727 z"/>
        </svg>
    ''';
    String legleft ='''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" id="leg-left" style="opacity:1; fill: ${colorToHex(partColors['leg-left'])};" d="m 51.176145,64.073985 -1.20605,3.01461 0.70738,0.26558 0.89754,3.51771 -0.55801,-4.01191 z m -5.08496,-3.15003 0.63355,1.8609 0.16813,2.03261 0.61314,1.93117 -0.90585,-0.0851 -0.28534,2.15982 z m 4.3014,6.58834 1.27664,4.99697 -0.28984,3.02284 -0.67869,10.06546 -1.66325,0.63506 -3.50399,-11.96959 1.24985,-7.17525 z m 0.54053,20.8287 0.85194,1.3581 0.37189,0.79238 -0.15588,1.21774 -0.76984,0.74446 -1.51185,0.12543 -1.1299,-0.29192 -0.24225,-0.95894 0.80765,-1.30405 -0.22562,-0.85987 0.29679,-0.84153 -0.0194,-1.81524 1.53568,-0.54817 z m -1.19598,0.4675 0.15943,1.25776 -0.6023,0.97431 m -0.54436,0.29544 1.06474,0.40084 1.55326,-0.65137 m -4.19331,-39.53466 4.55099,-2.03879 0.63802,0.23079 0.0353,1.80672 0.075,4.64669 -1.97837,6.04282 0.47612,1.41403 -1.42812,3.29446 -1.76611,-0.30111 -0.50079,-2.11605 -0.1695,-1.75674 -2.42102,-8.15763 -0.34279,-3.64687 z"/>
        </svg>
    ''';
    String buttock ='''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['buttock'])};" d="m 44.742845,39.689035 5.48374,1.86457 2.27386,1.3378 2.74195,-1.74412 4.51804,-1.28077 0.90009,2.29721 0.675,3.4346 -0.81272,5.02838 -2.82636,0.16819 -4.11256,-1.67581 -1.00814,0.39118 -0.95849,-0.39888 -4.44053,1.94411 -2.77023,-0.51478 -0.95181,-6.15325 0.36754,-2.7864 z" id="buttock" />
        </svg>
    ''';
    String loin ='''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['loin'])};" d="m 51.818445,37.309575 0.14418,2.97292 1.15984,-0.0241 0.048,-2.96488 2.80867,-0.81981 2.34029,-0.7541 1.34121,3.73319 -4.77886,1.36455 -2.33301,1.2158 -2.37536,-1.2333 -5.45663,-1.37716 1.51961,-3.95743 z" id="loin" />
        </svg>
    ''';
    String column ='''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['column'])};" d="m 51.733705,14.788555 0.53876,25.33066 0.48967,-0.0297 0.65658,-25.3387 -0.28147,-0.84188 -1.25059,-4.9e-4 z" id="column" />
        </svg>
    ''';
    String headback ='''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['head-back'])};" d="m 48.157455,6.3585449 0.44208,-0.14964 0.16111,0.16427 1.48163,4.0475101 2.32401,1.45118 2.39971,-1.52387 0.97577,-3.6896901 0.52752,-0.55908 0.23367,0.0981 0.24198,-3.34467 -2.03129,-2.31103004 -2.84509,-0.51629 -2.20422,0.52915 -1.93631,2.63077004 z" id="head-back" />
        </svg>
    ''';
    String nape ='''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['nape'])};" d="m 52.369695,12.105075 -2.35767,-1.55045 -1.47119,-3.9514301 -0.60741,0.0403 0.27409,1.82447 0.97635,0.33932 0.7613,2.2157201 0.33017,1.06849 0.0895,2.14894 1.16448,0.008 0.10563,-0.70833 0.54716,-0.0606 z m 1.01793,1.47595 0.23768,0.64982 1.38107,-0.004 0.01,-2.38784 0.25971,-0.79061 0.57215,-2.1698001 0.76359,-0.41018 0.25158,-1.78416 -0.62859,0.0193 -1.08488,3.8998101 -2.39725,1.46684 0.2768,1.48507 z" id="nape" />
        </svg>
    ''';
    String armbackright ='''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" id="armback-right" style="opacity:1; fill: ${colorToHex(partColors['armback-right'])};" d="m 61.657445,27.250625 -0.32785,-1.05121 -1.27383,-2.05489 1.38708,-2.96476 2.28579,0.91634 1.83971,1.74245 0.53937,1.78549 -0.26073,4.30868 z m 2.64394,15.3417 1.51839,0.0828 0.78033,-0.65476 1.16673,2.18281 0.79187,3.34623 -0.49843,0.21064 -0.55144,-2.21453 -0.50541,0.24292 0.30356,2.5012 -0.62882,0.23021 -0.36124,-2.50014 -0.56203,0.16666 0.16765,2.77019 -0.77603,0.30634 -0.19719,-2.87245 -0.45732,-0.0278 -0.22215,2.64829 -0.66539,0.24928 0.0254,-4.56692 -0.3374,-0.20146 -1.38845,1.65469 -0.32098,-0.35041 0.76973,-2.03928 z m 0.97685,-0.1799 1.43335,-0.74932 0.29002,-7.01054 c 0,0 -0.65,-2.77789 -0.64401,-3.06126 l -0.61212,-1.21783 -3.98124,-2.57566 1.0222,1.93525 -0.38967,4.82212 1.8218,7.69308 z"/>
        </svg>
    ''';
    String legright ='''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" id="leg-right" style="opacity:1; fill: ${colorToHex(partColors['leg-right'])};" d="m 54.019305,64.073985 1.20605,3.01461 -0.70737,0.26558 -0.89755,3.51771 0.55802,-4.01191 z m 5.08496,-3.15003 -0.63355,1.8609 -0.16813,2.03261 -0.61313,1.93117 0.90584,-0.0851 0.28534,2.15982 z m -4.3014,6.58834 -1.27664,4.99697 0.28984,3.02284 0.67869,10.06546 1.66325,0.63506 3.504,-11.96959 -1.24986,-7.17525 z m -0.54053,20.8287 -0.85194,1.3581 -0.37189,0.79238 0.15589,1.21774 0.76983,0.74446 1.51186,0.12543 1.12989,-0.29192 0.24225,-0.95894 -0.80765,-1.30405 0.22563,-0.85987 -0.29679,-0.84153 0.0194,-1.81524 -1.53568,-0.54817 z m 1.19598,0.4675 -0.15943,1.25776 0.6023,0.97431 m 0.54436,0.29544 -1.06474,0.40084 -1.55326,-0.65137 m 3.56525,-39.90247 -3.97962,-1.70224 -0.56389,0.27131 -0.0528,1.79746 -0.075,4.64669 1.97837,6.04282 -0.47612,1.41403 1.42813,3.29446 1.7661,-0.30111 0.50079,-2.11605 0.1695,-1.75674 2.42102,-8.15763 0.009,-3.68308 z"/>
        </svg>
    ''';
    String backright ='''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['back-right'])};" d="m 62.863315,16.685695 1.57473,1.56518 0.81404,2.06904 0.0384,2.52859 -1.48921,-1.23926 -2.76223,-1.15539 -1.84691,3.4342 -1.13679,5.49715 -0.0767,5.8593 -4.07066,1.10938 0.10355,-7.94098 1.94107,-4.90021 5.04395,-8.19335 z" id="back-right" />
        </svg>
    ''';
    String claviculeright ='''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['clavicule-right'])};" d="m 55.439085,14.728535 -0.063,-2.62463 0.71441,1.15181 4.37994,1.49796 -4.97857,8.36746 -1.83043,5.08189 0.21949,-13.55362 z" id="clavicule-right" />
        </svg>
    ''';
    String backleft ='''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['back-left'])};" d="m 42.200945,16.586495 -1.57473,1.56517 -0.81404,2.06905 -0.38603,2.52859 1.83679,-1.23927 2.76223,-1.15538 1.84691,3.4342 1.13679,5.49715 0.0767,5.8593 4.07066,1.10938 -0.10355,-7.94098 -1.94107,-4.90022 -5.04395,-8.19334 z" id="back-left" />
        </svg>
    ''';
    String claaviculeleft ='''
        <svg width="20%" height="20%" viewBox="0 0 68.587668 92.604164">
        <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['clavicule-left'])};" d="m 49.625175,14.629325 0.063,-2.62462 -0.71441,1.15181 -4.37994,1.49796 4.97857,8.36746 1.83043,5.08188 -0.21949,-13.55362 z" id="clavicule-left" />
      </svg>
    ''';
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(right: 11, left: 11),
          
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Chief Complaints',
              border: OutlineInputBorder(),
            ),
            maxLines: 2,
            controller: chiefcomolaintsController,
            onChanged: (text) {
              setState(() {});
            },
          ),
        ),
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.only(right: 11, left: 11),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'On Observation',
              border: OutlineInputBorder(),
            ),
            controller: observationController,
            onChanged: (text) {
              setState(() {});
            },
          ),
        ),
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.only(right: 11, left: 11),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'On Palpation',
              border: OutlineInputBorder(),
            ),
            controller: palpationController,
            onChanged: (text) {
              setState(() {});
            },
          ),
        ),
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.only(right: 280),
          child: Text(
            'On Examination:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.only(right: 11, left: 11),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Special Test',
              border: OutlineInputBorder(),
            ),
            controller: specialtestController,
            onChanged: (text) {
              setState(() {});
            },
          ),
        ),
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.only(right: 300),
          child: Text(
            'Body chart:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        Container(
          color: Colors.yellow,
            width: screenWidth,
            height: screenHeight * 0.70,
            // color: Colors.blueGrey,
            child: Stack(children: [

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('head'),
                  child: SvgPicture.string(
                    head,
                    height: 500,
                    semanticsLabel: 'Interactive Head',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('face'),
                  child: SvgPicture.string(
                    face,
                    height: 500,
                    semanticsLabel: 'Interactive Face',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('neck'),
                  child: SvgPicture.string(
                    neck,
                    height: 500,
                    semanticsLabel: 'Interactive neck',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('shoulder-left'),
                  child: SvgPicture.string(
                    shoulderleft,
                    height: 500,
                    semanticsLabel: 'Interactive shoulderleft',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('shoulder-right'),
                  child: SvgPicture.string(
                    shoulderright,
                    height: 500,
                    semanticsLabel: 'Interactive shoulderright',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('arm-left'),
                  child: SvgPicture.string(
                    armleft,
                    height: 500,
                    semanticsLabel: 'Interactive armleft',
                  ),
                ),
              ),
              
              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('forearm-left'),
                  child: SvgPicture.string(
                    forearmleft,
                    height: 500,
                    semanticsLabel: 'Interactive forearmleft',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('arm-right'),
                  child: SvgPicture.string(
                    armright,
                    height: 500,
                    semanticsLabel: 'Interactive armright',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('forearm-right'),
                  child: SvgPicture.string(
                    forearmright,
                    height: 500,
                    semanticsLabel: 'Interactive forearmright',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('chest-left'),
                  child: SvgPicture.string(
                    chestleft,
                    height: 500,
                    semanticsLabel: 'Interactive chestleft',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('chest-right'),
                  child: SvgPicture.string(
                    chestright,
                    height: 500,
                    semanticsLabel: 'Interactive chestright',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('belly-left'),
                  child: SvgPicture.string(
                    bellyleft,
                    height: 500,
                    semanticsLabel: 'Interactive bellyleft',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('ribs-left'),
                  child: SvgPicture.string(
                    ribsleft,
                    height: 500,
                    semanticsLabel: 'Interactive ribsleft',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('belly-right'),
                  child: SvgPicture.string(
                    bellyright,
                    height: 500,
                    semanticsLabel: 'Interactive bellyright',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('belly'),
                  child: SvgPicture.string(
                    belly,
                    height: 500,
                    semanticsLabel: 'Interactive belly',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('ribs-right'),
                  child: SvgPicture.string(
                    ribsright,
                    height: 500,
                    semanticsLabel: 'Interactive ribsright',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('thigh-left'),
                  child: SvgPicture.string(
                    thighleft,
                    height: 500,
                    semanticsLabel: 'Interactive thighleft',
                  ),
                ),
              ),

              Positioned(
              top: 20,
              left: 20,
              child: GestureDetector(
                onTap: () => onPartTapped('innerthigh-left'),
                child: SvgPicture.string(
                  innerthighleft,
                  height: 500,
                  semanticsLabel: 'Interactive innerthighleft',
                ),
              ),
            ),
            Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('feet-left'),
                  child: SvgPicture.string(
                    feetleft,
                    height: 500,
                    semanticsLabel: 'Interactive feetleft',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('calf-left'),
                  child: SvgPicture.string(
                    calfleft,
                    height: 500,
                    semanticsLabel: 'Interactive calfleft',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('knee-left'),
                  child: SvgPicture.string(
                    kneeleft,
                    height: 500,
                    semanticsLabel: 'Interactive kneeleft',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('thigh-right'),
                  child: SvgPicture.string(
                    thighright,
                    height: 500,
                    semanticsLabel: 'Interactive thighright',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('genitalia'),
                  child: SvgPicture.string(
                    genitalia,
                    height: 500,
                    semanticsLabel: 'Interactive genitalia',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('innerthigh-right'),
                  child: SvgPicture.string(
                    innerthighright,
                    height: 500,
                    semanticsLabel: 'Interactive innerthighright',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('right-feet'),
                  child: SvgPicture.string(
                    rightfeet,
                    height: 500,
                    semanticsLabel: 'Interactive rightfeet',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('calf-right'),
                  child: SvgPicture.string(
                    calfright,
                    height: 500,
                    semanticsLabel: 'Interactive calfright',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('knee-right'),
                  child: SvgPicture.string(
                    kneeright,
                    height: 500,
                    semanticsLabel: 'Interactive kneeright',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('elbow-right'),
                  child: SvgPicture.string(
                    elbowright,
                    height: 500,
                    semanticsLabel: 'Interactive elbowright',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('hand-right'),
                  child: SvgPicture.string(
                    handright,
                    height: 500,
                    semanticsLabel: 'Interactive handright',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('elbow-left'),
                  child: SvgPicture.string(
                    elbowleft,
                    height: 500,
                    semanticsLabel: 'Interactive elbowleft',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('hands-left'),
                  child: SvgPicture.string(
                    handsleft,
                    height: 500,
                    semanticsLabel: 'Interactive handsleft',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('armback-left'),
                  child: SvgPicture.string(
                    armbackleft,
                    height: 500,
                    semanticsLabel: 'Interactive armbackleft',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('leg-left'),
                  child: SvgPicture.string(
                    legleft,
                    height: 500,
                    semanticsLabel: 'Interactive legleft',
                  ),
                ),
              ),
              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('buttock'),
                  child: SvgPicture.string(
                    buttock,
                    height: 500,
                    semanticsLabel: 'Interactive innerthbuttockbuttockighright',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('loin'),
                  child: SvgPicture.string(
                    loin,
                    height: 500,
                    semanticsLabel: 'Interactive loin',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('column'),
                  child: SvgPicture.string(
                    column,
                    height: 500,
                    semanticsLabel: 'Interactive column',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('head-back'),
                  child: SvgPicture.string(
                    headback,
                    height: 500,
                    semanticsLabel: 'Interactive headback',
                  ),
                ),
              ),
              
              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('nape'),
                  child: SvgPicture.string(
                    nape,
                    height: 500,
                    semanticsLabel: 'Interactive nape',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('armback-right'),
                  child: SvgPicture.string(
                    armbackright,
                    height: 500,
                    semanticsLabel: 'Interactive armbackright',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('leg-right'),
                  child: SvgPicture.string(
                    legright,
                    height: 500,
                    semanticsLabel: 'Interactive legright',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('back-right'),
                  child: SvgPicture.string(
                    backright,
                    height: 500,
                    semanticsLabel: 'Interactive backright',
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('clavicule-right'),
                  child: SvgPicture.string(
                    claviculeright,
                    height: 500,
                    semanticsLabel: 'Interactive claviculeright',
                  ),
                ),
              ),
              
              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('back-left'),
                  child: SvgPicture.string(
                    backleft,
                    height: 500,
                    semanticsLabel: 'Interactive backleft',
                  ),
                ),
              ),
              
              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => onPartTapped('clavicule-left'),
                  child: SvgPicture.string(
                    claaviculeleft,
                    height: 500,
                    semanticsLabel: 'Interactive claaviculeleft',
                  ),
                ),
              ),
            ])

//           child: SvgPicture.string(
//             '''
// <svg width="259.22897" height="350" viewBox="0 0 68.587668 92.604164">
//   <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['head'])};" d="m 11.671635,6.3585449 -0.0482,-2.59085 4.20648,-2.46806 4.42769,2.95361 -0.0405,1.94408 0.24197,-3.34467 -2.03129,-2.31103004 -2.84508,-0.51629 -2.20423,0.52915 -1.9363,2.63077004 z" id="head"/>
//         <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['face'])};" d="m 19.748825,6.7034949 0.0203,-2.20747 -3.96689,-2.7637 -3.74099,2.23559 -0.006,2.63528 -0.60741,0.0403 0.27408,1.82447 0.97635,0.33932 0.44244,2.1802901 1.82222,2.06556 2.03518,-0.0607 1.79223,-1.94408 0.35957,-2.2406601 0.97616,-0.33932 0.25159,-1.78416 z" id="face" />
//         <path class="clickable" id="neck" style="opacity:1; fill: ${colorToHex(partColors['neck'])};" d="m 13.304665,11.910505 1.64975,2.35202 0.74426,2.62159 -1.73486,-1.38354 -0.86649,-2.97104 z m 5.08047,0 -1.64975,2.35202 -0.74538,2.62234 1.73486,-1.38354 0.86649,-2.97104 z"/>
//         <path class="clickable" id="shoulder-left" style="opacity:1; fill: ${colorToHex(partColors['shoulder-left'])};" d="m 19.047795,13.248365 3.55748,1.97916 0.72653,-0.35074 z m -0.107,0.43288 -0.37119,1.73073 2.1846,0.53561 1.40116,-0.49436 z m 3.98151,1.97595 0.75814,-0.41 2.40806,1.66799 1.17364,1.50707 0.62662,1.5626 -0.0464,3.70194 -1.3284,-1.72153 0.0407,-2.59376 -0.48842,-0.50049 c 0,0 -3.09778,-3.19058 -3.14371,-3.21401 z m -0.2409,0.10873 c -0.001,0.0525 3.32987,3.54733 3.32987,3.54733 l 0.10067,3.10396 -1.15426,-1.97782 -2.22547,-0.94804 -1.56576,-2.88481 z"/>
//         <path class="clickable" id="shoulder-right" style="opacity:1; fill: ${colorToHex(partColors['shoulder-right'])};" d="m 12.624785,13.248365 -3.5574599,1.97916 -0.72653,-0.35074 z m 0.107,0.43288 0.37119,1.73073 -2.18459,0.53561 -1.4011499,-0.49436 z m -3.9814899,1.97595 -0.75814,-0.41 -2.40806,1.66799 -1.17364,1.50707 -0.62662,1.56259 0.0464,3.70195 1.3284,-1.72153 -0.0407,-2.59376 0.48843,-0.5005 c 0,0 3.09777,-3.19057 3.1437,-3.214 z m 0.2409,0.10873 c 0.002,0.0525 -3.32987,3.54733 -3.32987,3.54733 l -0.10067,3.10396 1.15426,-1.97782 2.22547,-0.94804 1.5657499,-2.88481 z"/>
//         <path class="clickable" id="arm-left" style="opacity:1; fill: ${colorToHex(partColors['arm-left'])};" d="m 27.621665,30.814715 -0.33838,1.70499 -1.81932,-2.54418 -0.6629,-1.26895 z m -2.85271,-2.6096 c -0.0259,-0.0144 -0.0536,-0.0254 -0.0824,-0.0324 l -1.48333,-4.95503 1.00456,-2.08428 1.65511,1.74532 2.23034,6.67667 0.0415,0.93739 c -1.06528,-0.84215 -2.18962,-1.60679 -3.36434,-2.28803 z m 1.6945,-5.75654 1.64893,6.43421 -0.36469,-4.92266 z"/>
//         <path class="clickable" id="forearm-left" style="opacity:1; fill: ${colorToHex(partColors['forearm-left'])};" d="m 26.955425,32.969125 1.30083,10.28927 -1.10778,0.01 -1.89387,-7.99609 0.19174,-4.53719 z m 1.21978,-1.94971 -0.58729,2.58635 1.11876,9.15614 0.55849,-0.21663 0.2304,-6.77018 z"/>
//         <path class="clickable" id="arm-right" style="opacity:1; fill: ${colorToHex(partColors['arm-right'])};" d="m 4.0746451,30.814715 0.33838,1.70499 1.81931,-2.54418 0.66289,-1.26895 z m 2.8527,-2.6096 c 0.0259,-0.0144 0.0536,-0.0254 0.0824,-0.0324 l 1.48332,-4.95503 -1.00455,-2.08428 -1.65509,1.74532 -2.23034,6.67667 -0.0415,0.93739 c 1.06528,-0.84215 2.18961,-1.60679 3.36433,-2.28803 z m -1.6945,-5.75654 -1.64891,6.43421 0.36468,-4.92266 z"/>
//         <path class="clickable" id="forearm-right" style="opacity:1; fill: ${colorToHex(partColors['forearm-right'])};" d="m 4.5752651,32.969125 -1.30083,10.28927 1.10778,0.01 1.89387,-7.99609 -0.19174,-4.53719 z m -1.21978,-1.94971 0.58728,2.58635 -1.11875,9.15614 -0.55849,-0.21663 -0.2304,-6.77018 z"/>
//         <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['chest-left'])};" d="m 20.337455,17.085495 1.72942,3.09103 1.89346,0.94785 -1.15295,0.90662 -0.90604,2.63773 -2.09968,0.86537 -3.34524,-1.655 0.83425,-6.50527 z" id="chest-left" />
//         <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['chest-right'])};" d="m 11.351215,17.085495 -1.7294199,3.09103 -1.89346,0.94785 1.15295,0.90662 0.90586,2.63773 2.0996699,0.86537 3.34636,-1.655 -0.83462,-6.50527 z" id="chest-right" />
//         <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['belly-left'])};" d="m 19.641935,34.707615 1.81341,-1.36479 0.15748,1.83347 1.28642,2.37338 -1.98044,2.73652 -1.03109,0.16554 -0.37026,-3.88816 z" id="belly-left" />
//         <path class="clickable" id="ribs-left" style="opacity:1; fill: ${colorToHex(partColors['ribs-left'])};" d="m 19.288925,26.151995 -3.11202,-1.40604 0.0937,2.27965 2.80119,1.43603 z m 1.93471,1.66849 -1.29355,0.7212 0.14997,-1.70898 z m -1.05303,-1.63718 2.47968,-1.03241 -0.9336,2.52093 z m 1.53164,1.73729 -1.69005,1.03372 -0.28871,2.0678 1.64975,-1.07533 z m -2.91143,1.10421 -0.0622,1.62387 -2.30308,-0.49961 -0.12448,-2.21722 z m -0.1556,2.4045 0.0311,1.99844 -2.20953,0.59391 -0.0311,-3.1227 z m 2.65459,-0.98535 -1.48383,1.03372 -0.20622,2.10905 1.64862,-1.32355 z"/>
//         <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['belly-right'])};" d="m 12.045985,34.707615 -1.81341,-1.36479 -0.15748,1.83347 -1.2856799,2.37432 1.9804499,2.73595 1.03109,0.16554 0.37119,-3.88721 z" id="belly-right" />
//         <path class="clickable" id="belly" style="opacity:1; fill: ${colorToHex(partColors['belly'])};" d="m 15.636055,44.919735 -0.60647,-5.91209 -0.015,-3.84879 -2.18479,-1.07533 -0.24746,7.03017 z m 0.41581,-5.7e-4 0.60628,-5.91209 0.0154,-3.84915 2.18404,-1.07515 0.24746,7.03017 z"/>
//         <path class="clickable" id="ribs-right" style="opacity:1; fill: ${colorToHex(partColors['ribs-right'])};" d="m 12.399365,26.152365 3.11202,-1.40603 -0.0937,2.27965 -2.80138,1.4364 z m -1.93508,1.6685 1.29355,0.72139 -0.14997,-1.70899 z m 1.05303,-1.637 -2.4793099,-1.03259 0.93361,2.52148 z m -1.5316399,1.73729 1.6900499,1.03372 0.28871,2.06743 -1.64881,-1.07515 z m 2.9114199,1.10421 0.0623,1.62387 2.30327,-0.49961 0.12448,-2.21703 z m 0.15561,2.40432 -0.0309,1.99844 2.20973,0.59353 0.0311,-3.1227 z m -2.6546,-0.98516 1.48384,1.0339 0.20622,2.10905 -1.64975,-1.32355 z"/>
//         <path class="clickable" id="thigh-left" style="opacity:1; fill: ${colorToHex(partColors['thigh-left'])};" d="m 23.419015,50.399125 -0.15504,4.75091 -2.40263,6.60949 0.7362,1.90021 2.36401,-8.34435 z m -0.58154,-11.60825 -0.15485,4.00722 1.31793,7.93154 0.61977,-6.40308 z m -0.38731,5.12268 -2.75152,6.07258 -0.62015,4.87425 1.16232,6.85771 2.51886,-6.98144 0.15504,-7.18764 z"/>
//         <path class="clickable" id="innerthigh-left" style="opacity:1; fill: ${colorToHex(partColors['innerthigh-left'])};" d="m 22.063225,39.369605 v 4.21363 l -2.94574,5.82511 -1.86027,5.78349 0.19365,-4.0072 z m -3.24944,13.42596 -0.0649,0.15467 -1.21294,2.90207 0.78325,7.18803 1.23619,-0.66122 -1.0714,-6.69272 z"/>
//         <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['feet-left'])};" d="m 17.255895,87.868445 0.1243,3.45228 0.28983,1.20638 h 0.87136 l 0.24897,-0.83181 0.29058,-0.0416 -0.0624,0.83181 1.09914,-0.33332 0.29058,-0.16629 1.24444,-0.27033 0.0416,-0.97748 -1.20319,-2.03743 -0.82974,-1.0399 -2.03294,-0.83181 z" id="feet-left" />
//         <path class="clickable" id="calf-left" style="opacity:1; fill: ${colorToHex(partColors['calf-left'])};" d="m 18.251375,70.441125 0.29058,0.91486 0.6224,3.8681 0.0829,5.15733 -0.87136,5.03304 0.0412,-6.44714 -0.91242,-2.57848 -0.12561,-2.82837 z m 1.9915,2.32915 -0.20753,7.73637 -1.65949,6.23904 1.80478,-0.853 3.00816,-10.83583 -1.03727,-6.82095 z"/>
//         <path class="clickable" id="knee-left" style="opacity:1; fill: ${colorToHex(partColors['knee-left'])};" d="m 21.404635,64.784375 0.1243,1.12295 -0.87118,1.08171 -0.29058,1.70599 -0.58116,0.24933 -0.49774,-2.57866 -0.33182,-0.91486 0.29058,-0.58247 z m -3.85853,0.0832 0.6224,1.74685 1.3273,2.57867 -0.33182,2.37095 -0.95423,-2.66209 -0.78738,-1.49734 z m 4.97811,-2.37039 -0.95423,5.11609 0.62241,-0.33295 0.49773,1.66381 z"/>
//         <path class="clickable" id="thigh-right" style="opacity:1; fill: ${colorToHex(partColors['thigh-right'])};" d="m 8.2694651,50.399125 0.15504,4.75053 2.4026299,6.60968 -0.73638,1.90021 -2.3640099,-8.34435 z m 0.58117,-11.60768 0.15503,4.00684 -1.31754,7.93154 -0.61978,-6.40308 z m 0.38769,5.1223 2.7515099,6.07239 0.61997,4.87425 -1.16232,6.85771 -2.5190499,-6.98163 -0.15504,-7.18801 z"/>
//         <path class="clickable" id="genitalia" style="opacity:1; fill: ${colorToHex(partColors['genitalia'])};" d="m 14.404465,45.040075 0.0221,-0.0277 -0.14866,-0.37945 -3.10172,-3.40449 -0.23283,-0.0825 2.05918,5.32009 z m -1.17263,2.01833 1.27705,3.29948 0.42631,-4.04862 -0.25196,-0.64303 z m 4.05219,-2.01795 -0.0221,-0.0281 0.14867,-0.37926 3.10171,-3.40449 0.23246,-0.0825 -2.05843,5.3199 z m 1.17263,2.01795 -1.27706,3.29948 -0.42631,-4.04843 0.25197,-0.64303 z"/>
//         <path class="clickable" id="innerthigh-right" style="opacity:1; fill: ${colorToHex(partColors['innerthigh-right'])};" d="m 9.6258251,39.369415 v 4.21363 l 2.9451699,5.8253 1.86028,5.78349 -0.19366,-4.0072 z m 3.2488699,13.42559 0.0647,0.15485 1.21294,2.90207 -0.78307,7.18803 -1.23618,-0.66102 1.0714,-6.69273 z"/>
//         <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['right-feet'])};" d="m 14.433335,87.868265 -0.12448,3.45228 -0.29058,1.20637 h -0.87118 l -0.24877,-0.83181 -0.29059,-0.0416 0.0623,0.83181 -1.09934,-0.33333 -0.29058,-0.16629 -1.2448,-0.27033 -0.0412,-0.97747 1.2031899,-2.03781 0.82975,-1.04009 2.03294,-0.83181 z" id="right-feet" />
//         <path class="clickable" id="calf-right" style="opacity:1; fill: ${colorToHex(partColors['calf-right'])};" d="m 13.437675,70.440945 -0.29058,0.91486 -0.62241,3.86828 -0.0829,5.15733 0.87174,5.03304 -0.0418,-6.44714 0.91298,-2.57848 0.1243,-2.82837 z m -1.99151,2.32914 0.20735,7.73637 1.65968,6.23904 -1.80497,-0.85299 -3.0079799,-10.83584 1.03728,-6.82095 z"/>
//         <path class="clickable" id="knee-right" style="opacity:1; fill: ${colorToHex(partColors['knee-right'])};" d="m 10.284405,64.784375 -0.12448,1.12295 0.87118,1.08171 0.29058,1.70599 0.58116,0.24933 0.49774,-2.57866 0.33182,-0.91486 -0.29058,-0.58247 z m 3.85854,0.0832 -0.62241,1.74685 -1.32767,2.57867 0.33182,2.37095 0.95423,-2.66209 0.78832,-1.4964 z m -4.9786799,-2.37058 0.9542299,5.11609 -0.6223999,-0.33313 -0.49793,1.6638 z"/>
//         <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['elbow-right'])};" d="m 3.2054751,27.370125 0.005,3.09419 -0.57959,1.91184 -0.54539,-2.41185 z" id="elbow-right" />
//         <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['hand-right'])};" d="m 4.3904451,43.563145 -1.5198,0.0506 -0.76631,-0.67112 -1.21261996,2.15767 -0.86245,3.32873 0.49386,0.22113 0.59814996,-2.20238 0.50016,0.25356 -0.35639,2.49422 0.62382,0.24345 0.41402,-2.49194 0.55839,0.17851 -0.2262,2.76603 0.76938,0.32268 0.25788,-2.86764 0.4578,-0.0181 0.16611,2.65239 0.65997,0.2633 0.0712,-4.56643 0.34158,-0.19428 1.35316,1.68367 0.32832,-0.34354 -0.72644,-2.0551 z" id="hand-right" />
//         <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['elbow-left'])};" d="m 28.325215,27.370125 -0.005,3.09419 0.57959,1.91184 0.54538,-2.41185 z" id="elbow-left" />
//         <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['hands-left'])};" d="m 27.140245,43.563145 1.5198,0.0506 0.76631,-0.67111 1.21262,2.15766 0.86245,3.32873 -0.49386,0.22113 -0.59815,-2.20238 -0.50016,0.25356 0.35639,2.49422 -0.62382,0.24345 -0.41402,-2.49194 -0.55839,0.17851 0.2262,2.76603 -0.76938,0.32268 -0.25788,-2.86764 -0.4578,-0.0181 -0.16611,2.6524 -0.65997,0.26329 -0.0712,-4.56643 -0.34158,-0.19428 -1.35316,1.68368 -0.32832,-0.34355 0.72644,-2.0551 z" id="hands-left" />

//         <path class="clickable" id="armback-left" style="opacity:1; fill: ${colorToHex(partColors['armback-left'])};" d="m 43.185645,27.069445 0.4297,-1.4164 1.30458,-1.68577 -1.39393,-2.96155 -2.28367,0.92162 -1.83567,1.7467 -0.53524,1.78673 0.27068,4.30806 z m -2.46869,15.35539 -1.5182,0.0863 -0.78184,-0.65295 -1.16168,2.1855 -0.78414,3.34805 0.49892,0.20949 0.54632,-2.2158 0.50597,0.24175 -0.29779,2.5019 0.62936,0.22875 0.35546,-2.50096 0.56242,0.16536 -0.16126,2.77057 0.77674,0.30455 0.19056,-2.87291 0.45724,-0.0289 0.22827,2.64778 0.66597,0.24774 -0.0359,-4.56685 0.33693,-0.20224 1.39227,1.65147 0.32017,-0.35115 -0.77444,-2.03749 z m -0.97726,-0.17765 -1.43509,-0.746 -0.30622,-7.00985 c 0,0 0.64359,-2.77938 0.63694,-3.06274 l 0.6093,-1.21924 3.62552,-2.56583 -0.68276,1.9919 0.41561,4.74788 -1.80402,7.69727 z"/>
//         <path class="clickable" id="leg-left" style="opacity:1; fill: ${colorToHex(partColors['leg-left'])};" d="m 51.176145,64.073985 -1.20605,3.01461 0.70738,0.26558 0.89754,3.51771 -0.55801,-4.01191 z m -5.08496,-3.15003 0.63355,1.8609 0.16813,2.03261 0.61314,1.93117 -0.90585,-0.0851 -0.28534,2.15982 z m 4.3014,6.58834 1.27664,4.99697 -0.28984,3.02284 -0.67869,10.06546 -1.66325,0.63506 -3.50399,-11.96959 1.24985,-7.17525 z m 0.54053,20.8287 0.85194,1.3581 0.37189,0.79238 -0.15588,1.21774 -0.76984,0.74446 -1.51185,0.12543 -1.1299,-0.29192 -0.24225,-0.95894 0.80765,-1.30405 -0.22562,-0.85987 0.29679,-0.84153 -0.0194,-1.81524 1.53568,-0.54817 z m -1.19598,0.4675 0.15943,1.25776 -0.6023,0.97431 m -0.54436,0.29544 1.06474,0.40084 1.55326,-0.65137 m -4.19331,-39.53466 4.55099,-2.03879 0.63802,0.23079 0.0353,1.80672 0.075,4.64669 -1.97837,6.04282 0.47612,1.41403 -1.42812,3.29446 -1.76611,-0.30111 -0.50079,-2.11605 -0.1695,-1.75674 -2.42102,-8.15763 -0.34279,-3.64687 z"/>
//         <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['buttock'])};" d="m 44.742845,39.689035 5.48374,1.86457 2.27386,1.3378 2.74195,-1.74412 4.51804,-1.28077 0.90009,2.29721 0.675,3.4346 -0.81272,5.02838 -2.82636,0.16819 -4.11256,-1.67581 -1.00814,0.39118 -0.95849,-0.39888 -4.44053,1.94411 -2.77023,-0.51478 -0.95181,-6.15325 0.36754,-2.7864 z" id="buttock" />
//         <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['loin'])};" d="m 51.818445,37.309575 0.14418,2.97292 1.15984,-0.0241 0.048,-2.96488 2.80867,-0.81981 2.34029,-0.7541 1.34121,3.73319 -4.77886,1.36455 -2.33301,1.2158 -2.37536,-1.2333 -5.45663,-1.37716 1.51961,-3.95743 z" id="loin" />
//         <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['column'])};" d="m 51.733705,14.788555 0.53876,25.33066 0.48967,-0.0297 0.65658,-25.3387 -0.28147,-0.84188 -1.25059,-4.9e-4 z" id="column" />
//         <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['head-back'])};" d="m 48.157455,6.3585449 0.44208,-0.14964 0.16111,0.16427 1.48163,4.0475101 2.32401,1.45118 2.39971,-1.52387 0.97577,-3.6896901 0.52752,-0.55908 0.23367,0.0981 0.24198,-3.34467 -2.03129,-2.31103004 -2.84509,-0.51629 -2.20422,0.52915 -1.93631,2.63077004 z" id="head-back" />
//         <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['nape'])};" d="m 52.369695,12.105075 -2.35767,-1.55045 -1.47119,-3.9514301 -0.60741,0.0403 0.27409,1.82447 0.97635,0.33932 0.7613,2.2157201 0.33017,1.06849 0.0895,2.14894 1.16448,0.008 0.10563,-0.70833 0.54716,-0.0606 z m 1.01793,1.47595 0.23768,0.64982 1.38107,-0.004 0.01,-2.38784 0.25971,-0.79061 0.57215,-2.1698001 0.76359,-0.41018 0.25158,-1.78416 -0.62859,0.0193 -1.08488,3.8998101 -2.39725,1.46684 0.2768,1.48507 z" id="nape" />
//         <path class="clickable" id="armback-right" style="opacity:1; fill: ${colorToHex(partColors['armback-right'])};" d="m 61.657445,27.250625 -0.32785,-1.05121 -1.27383,-2.05489 1.38708,-2.96476 2.28579,0.91634 1.83971,1.74245 0.53937,1.78549 -0.26073,4.30868 z m 2.64394,15.3417 1.51839,0.0828 0.78033,-0.65476 1.16673,2.18281 0.79187,3.34623 -0.49843,0.21064 -0.55144,-2.21453 -0.50541,0.24292 0.30356,2.5012 -0.62882,0.23021 -0.36124,-2.50014 -0.56203,0.16666 0.16765,2.77019 -0.77603,0.30634 -0.19719,-2.87245 -0.45732,-0.0278 -0.22215,2.64829 -0.66539,0.24928 0.0254,-4.56692 -0.3374,-0.20146 -1.38845,1.65469 -0.32098,-0.35041 0.76973,-2.03928 z m 0.97685,-0.1799 1.43335,-0.74932 0.29002,-7.01054 c 0,0 -0.65,-2.77789 -0.64401,-3.06126 l -0.61212,-1.21783 -3.98124,-2.57566 1.0222,1.93525 -0.38967,4.82212 1.8218,7.69308 z"/>
//         <path class="clickable" id="leg-right" style="opacity:1; fill: ${colorToHex(partColors['leg-right'])};" d="m 54.019305,64.073985 1.20605,3.01461 -0.70737,0.26558 -0.89755,3.51771 0.55802,-4.01191 z m 5.08496,-3.15003 -0.63355,1.8609 -0.16813,2.03261 -0.61313,1.93117 0.90584,-0.0851 0.28534,2.15982 z m -4.3014,6.58834 -1.27664,4.99697 0.28984,3.02284 0.67869,10.06546 1.66325,0.63506 3.504,-11.96959 -1.24986,-7.17525 z m -0.54053,20.8287 -0.85194,1.3581 -0.37189,0.79238 0.15589,1.21774 0.76983,0.74446 1.51186,0.12543 1.12989,-0.29192 0.24225,-0.95894 -0.80765,-1.30405 0.22563,-0.85987 -0.29679,-0.84153 0.0194,-1.81524 -1.53568,-0.54817 z m 1.19598,0.4675 -0.15943,1.25776 0.6023,0.97431 m 0.54436,0.29544 -1.06474,0.40084 -1.55326,-0.65137 m 3.56525,-39.90247 -3.97962,-1.70224 -0.56389,0.27131 -0.0528,1.79746 -0.075,4.64669 1.97837,6.04282 -0.47612,1.41403 1.42813,3.29446 1.7661,-0.30111 0.50079,-2.11605 0.1695,-1.75674 2.42102,-8.15763 0.009,-3.68308 z"/>
//         <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['back-right'])};" d="m 62.863315,16.685695 1.57473,1.56518 0.81404,2.06904 0.0384,2.52859 -1.48921,-1.23926 -2.76223,-1.15539 -1.84691,3.4342 -1.13679,5.49715 -0.0767,5.8593 -4.07066,1.10938 0.10355,-7.94098 1.94107,-4.90021 5.04395,-8.19335 z" id="back-right" />
//         <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['clavicule-right'])};" d="m 55.439085,14.728535 -0.063,-2.62463 0.71441,1.15181 4.37994,1.49796 -4.97857,8.36746 -1.83043,5.08189 0.21949,-13.55362 z" id="clavicule-right" />
//         <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['back-left'])};" d="m 42.200945,16.586495 -1.57473,1.56517 -0.81404,2.06905 -0.38603,2.52859 1.83679,-1.23927 2.76223,-1.15538 1.84691,3.4342 1.13679,5.49715 0.0767,5.8593 4.07066,1.10938 -0.10355,-7.94098 -1.94107,-4.90022 -5.04395,-8.19334 z" id="back-left" />
//         <path class="clickable" style="opacity:1; fill: ${colorToHex(partColors['clavicule-left'])};" d="m 49.625175,14.629325 0.063,-2.62462 -0.71441,1.15181 -4.37994,1.49796 4.97857,8.36746 1.83043,5.08188 -0.21949,-13.55362 z" id="clavicule-left" />
// </svg>
//             ''',
//             height: 250,
//             allowDrawingOutsideViewBox: true,
//           ),

            ),
        SizedBox(height: 20),
        Container(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: FloatingActionButton(
                    backgroundColor: custom_color.appcolor,
                    foregroundColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        patient = true;
                        bodyChart = false;
                      });
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
              SizedBox(width: 250),
              Container(
                child: FloatingActionButton(
                  backgroundColor: custom_color.appcolor,
                  foregroundColor: Colors.white,
                  onPressed: () {},
                  child: Icon(Icons.arrow_forward),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  patientwidget() {
    return Column(children: [
      Container(
        padding: EdgeInsets.only(right: 11, left: 11),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Patient Name',
            border: OutlineInputBorder(),
            // icon: Icon(Icons.numbers),
          ),
          keyboardType: TextInputType.none,
          controller: patientnameController,
          // focusNode: doseFocusNode,
          onChanged: (text) {
            setState(() {});
          },
        ),
      ),
      SizedBox(height: 15),
      Container(
        padding: EdgeInsets.only(right: 11, left: 11),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Age',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.none,
          controller: ageController,
          onChanged: (text) {
            setState(() {});
          },
        ),
      ),
      SizedBox(height: 15),
      Container(
        padding: EdgeInsets.only(right: 11, left: 11),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Gender',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.none,
          controller: genderController,
          onChanged: (text) {
            setState(() {});
          },
        ),
      ),
      SizedBox(height: 15),
      Container(
        padding: EdgeInsets.only(right: 11, left: 11),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Occupation',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.none,
          controller: occupationController,
          onChanged: (text) {
            setState(() {});
          },
        ),
      ),
      SizedBox(height: 15),
      Container(
        padding: EdgeInsets.only(right: 11, left: 11),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Address',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.none,
          controller: addressController,
          onChanged: (text) {
            setState(() {});
          },
        ),
      ),
      SizedBox(height: 15),
      Container(
        padding: EdgeInsets.only(right: 11, left: 11),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Mobile Number',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.none,
          controller: mobilenumberController,
          onChanged: (text) {
            setState(() {});
          },
        ),
      ),
      SizedBox(height: 15),
      Container(
        padding: EdgeInsets.only(right: 11, left: 11),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Refered By',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.none,
          controller: referedbyController,
          onChanged: (text) {
            setState(() {});
          },
        ),
      ),
      SizedBox(height: 20),
      Container(
        padding: EdgeInsets.only(left: 290),
        child: FloatingActionButton(
          backgroundColor: custom_color.appcolor,
          foregroundColor: Colors.white,
          onPressed: () {
            if (selectedPatient == null || selectedPatient == '') {
              Fluttertoast.showToast(
                  msg: 'Please select Patient',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 2,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 15.0);
            } else {
              setState(() {
                patient = false;
                bodyChart = true;
              });
            }
          },
          child: Icon(Icons.arrow_forward),
        ),
      ),
    ]);
  }

  renderAutoComplete(screenWidth, screenHeight) {
    return Autocomplete<List>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<List>.empty();
        } else if (textEditingValue.text.length < 3) {
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
                    width: screenWidth * 0.70,
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
                                      patientnameController.text =
                                          selectedPatient['customer_name'];
                                      ageController.text =
                                          selectedPatient['age'];
                                      genderController.text =
                                          selectedPatient['gender'];
                                      occupationController.text =
                                          selectedPatient['occupation'];
                                      addressController.text =
                                          selectedPatient['address'];
                                      mobilenumberController.text =
                                          selectedPatient['phone'];
                                      // referedbyController.text =selectedPatient['']
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
                                          padding: EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text(
                                                '${options.toList()[0][index]['customer_name'].toString()} , ${options.toList()[0][index]['phone'].toString()}',
                                                style: TextStyle(
                                                    color: Colors.white)),
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
                alignment: Alignment.topCenter,
                child: Material(
                  child: Container(
                    width: screenWidth * 0.5,
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

  getpatientlist() async {
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

  String colorToHex(Color? color) {
    if (color == null) return '#000000';
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }
}
