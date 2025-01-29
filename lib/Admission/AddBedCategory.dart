import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/Admission/BedCategory.dart';
import 'package:nigdoc/Admission/Room.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../AppWidget/common/Colors.dart' as custom_color;

class AddBedCategory extends StatefulWidget {
  const AddBedCategory({super.key});

  @override
  State<AddBedCategory> createState() => _AddBedCategoryState();
}

class _AddBedCategoryState extends State<AddBedCategory> {
   final LocalStorage storage = new LocalStorage('doctor_store');
  //  TextEditingController totalroomcontroller = TextEditingController();
  //  TextEditingController edittotalroomcontroller = TextEditingController();
   
  var floordropdown;
  var warddropdown;
  List floorList =[];
  List wardList = [];
  var userResponse;
  var accesstoken;
  bool isLoading =false;
  var bed_list;
  var ward;
  List total_bed = [];
  // var selectedBeds;
  Map<int, Set<int>> selectedBeds = {};
  void initState() {
     userResponse = storage.getItem('userResponse');
    accesstoken =  userResponse['access_token'];
    
     init();
     
  }
  init() async {
    // await getDocWardList();
    await getFloorList();

    setState(() {
    
    });

   
  }
  getFloorList() async {
    var List = await PatientApi().getDocFloor(accesstoken);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        floorList = List['list'];
        isLoading = true;
        // filterItems(searchText.text);
      });
    }
  }
      List roomControllers = [];
      List bedControllers = [];
List<Map<String, bool>> bedSelections = List.generate(5, (index) => {'bed1': false, 'bed2': false});
// bool? bedSelections = false;

  @override
 
  Widget build(BuildContext context) {
     double screenHeight = MediaQuery.of(context).size.height;
    double screenWidht = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
       onPopInvoked: (didPop) {
         Navigator.push(
          context, MaterialPageRoute(builder: (context)=>BedCategory())
         );
      },
      child: Scaffold(
         appBar: AppBar(
          title: Text('Add Bed Category',style: TextStyle(color: Colors.white),),
           backgroundColor:custom_color.appcolor,
          leading: IconButton(onPressed: (){
            Navigator.push(
          context, MaterialPageRoute(builder: (context)=> BedCategory(),)
         );
          }, icon: Icon(Icons.arrow_back,
          color: Colors.white,),),
        ),
        body:isLoading ? SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
               
                child: Column(
                  children: [
                    SizedBox(
            width: screenWidht * 0.95,
            child: DropdownButtonFormField(
              menuMaxHeight: 300,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                isExpanded: true,
                hint: Text(
                  'Select Floor',
                ),
                // value:patternDropdownvalue,
                onChanged: (item) async {
                  floordropdown = item.toString();
                  // wardList.clear();
                  // warddropdown.clear();
              
                 
                 setState(() {
                   wardList = [];
                 });
                 await getWardListRoom();
                },
                items: floorList
                    .map(
                        (value) => DropdownMenuItem<String>(
                              value: value["id"].toString(),
                              child: Text(value["floor_name"].toString()),
                            )).toList()

                )),
                  SizedBox(height: screenHeight*0.02,),
                  SizedBox(
            width: screenWidht * 0.95,
            child: wardList.length>0?DropdownButtonFormField(
              menuMaxHeight: 300,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                isExpanded: true,
                hint: Text(
                  'Select Ward',
                ),
                // value:patternDropdownvalue,
                onChanged: (item) async {

                  warddropdown = item;
                 var u=warddropdown.split('&%*');
                 setState(() {
                   roomControllers = [];
                 });
                 await getbedist();
                },
                items: wardList
                    .map(
                        (value) => DropdownMenuItem<String>(
                              value: value['id'].toString(),
                              child: Text(value["ward_name"].toString()),
                            ))
                    .toList()

                ):DropdownButtonFormField(
              menuMaxHeight: 300,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                isExpanded: true,
                hint: Text(
                  'Select Ward',
                ),
                // value:patternDropdownvalue,
                onChanged: (item) async {

                  warddropdown = item;
                 var u=warddropdown.split('&%*');
                
                },
                items: []
                    .map(
                        (value) => DropdownMenuItem(
                              value: value['id'],
                              child: Text(value["ward_name"].toString()),
                            ))
                    .toList()

                )),
                    
                  SizedBox(height: screenHeight*0.02,),      
                  
  roomControllers.length>0? ListView.builder(
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(),
  itemCount: roomControllers.length,
  itemBuilder: (BuildContext context, int roomIndex) {
    //  selectedBeds.putIfAbsent(roomIndex, () => <int>{});
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Room number display
          Row(
            children: [
              Text(
                'Room No ',
                style: TextStyle(fontWeight: FontWeight.bold, color: custom_color.appcolor,fontSize: 18),
              ),
              Text(
                roomControllers[roomIndex]['room_no'].toString(),
                style: TextStyle(fontWeight: FontWeight.bold, color: custom_color.appcolor,fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Beds List
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount:(roomControllers[roomIndex]['bed'].length), 
            itemBuilder: (BuildContext context, int bedIndex) {
              var bed=roomControllers[roomIndex]['bed'][bedIndex];
              //  selectedBeds.putIfAbsent(bedIndex +roomIndex, () => <int>{});
              // int l = int.parse(roomControllers[roomIndex]['bed'].toString());
              // final List<bool> _checkedStates = List.generate(l, (_) => false);
              //  selectedBeds[roomIndex] ??= {};
              // List<bool> isChecked = List<bool>.generate(int.parse(roomControllers[roomIndex]['bed'].toString()), bedIndex => false);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.bed),
                      Text(
                        ' ${bed['bed_name']}',
                        style: TextStyle(fontWeight: FontWeight.bold, color: custom_color.appcolor,fontSize: 16),
                      ),
                    ],
                  ),
                  Checkbox(
                onChanged: (checked) {
                  setState(
                    () {
                      bed['check']=checked;
                     total_bed.add(bed);
                    },
                  );
                  //  setState(() {
                  //                 if (checked!) {
                  //                    bed['check']=false;
                  //                 } else {
                  //                    bed['check']=true;
                  //                 }
                  //                 // print(getSelectedBeds());
                  //               });
                            
                },
                // value: _checkedStates[bedIndex]
                 value: bed['check'],
                ),
          

                 
                ],
              );
            },
          ),
        ],
      ),
    );
  },
):Container(),




SizedBox(height: screenHeight*0.02,),
                 ElevatedButton( 
                     
                     style: ButtonStyle(
                         backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                         shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                          
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          
                                        )
                                        
                                      ),
                    child:Text('Submit',
                    style: TextStyle(fontSize: 20,color: Colors.white),),
                    onPressed: (() async{
                      //   var bedValues = bedControllers.map((controller) => controller.text).toList();
                      //   var roomValues = roomControllers.map((controller) => controller.text).toList();
                      // if(totalroomcontroller.text.isEmpty){
                      //     NigDocToast().showErrorToast('Please Enter Room Name');
                                      
                       
                      //   }else{
                          var items={
                              
                              "floor_id":floordropdown,
                              "ward_id":warddropdown,
                              "bed_no":total_bed,
                              "room_id":"",
                             
                
                          };
                          print(items);
                          var list = await PatientApi()
                                     .AddBedCategory(accesstoken, items);
                                 if (list['message'] ==
                                     "Bed Category Add successfully") {
                                   NigDocToast().showSuccessToast(
                                       'Added successfully');
                                   Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                           builder: (context) => BedCategory()));
                                 } else {
                                   NigDocToast()
                                       .showErrorToast('Please TryAgain later');
                                 }
                        
                  
                    }),),
                 
                  ],
                ),
              ),
            ),
          )
          ):SpinLoader(),
      ));
  }
  getWardListRoom()async{
    // warddropdown.isEmpty();
    var data = {
      "floor_id":floordropdown.toString(),
    };

      var List = await PatientApi().getWardListRoom(accesstoken, data);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        //  MediAndLabNameList = List['list'];
        wardList = List['list'];
      
        isLoading=true;
       
      });
     
    }
    

  }
Future<void> getbedist() async {
  var data = {
    "ward_id": warddropdown.toString(),
  };

  try {
    
    bed_list = await PatientApi().getBedCategoryRoomList(accesstoken, data);

    // Check for session expiration
    if (Helper().isvalidElement(bed_list) &&
        Helper().isvalidElement(bed_list['status']) &&
        bed_list['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expired');
      return;
    }

  
    roomControllers = bed_list['list'];

    setState(() {
 
      isLoading = true;
    });
  } catch (e) {
   
 
  }
}

}