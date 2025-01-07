import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/Admission/Room.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../AppWidget/common/Colors.dart' as custom_color;

class Editroom extends StatefulWidget {
  const Editroom({super.key});

  @override
  State<Editroom> createState() => _EditroomState();
}

class _EditroomState extends State<Editroom> {
   final LocalStorage storage = new LocalStorage('doctor_store');
   TextEditingController edittotalroomcontroller = TextEditingController();
  var floordropdown;
  var warddropdown;
  List floorList =[];
  List wardList = [];
  var userResponse;
  var accesstoken;
  bool isLoading =false;
  var floor_name;
  var ward_name;
  var id;
  var bed_list;
  void initState() {
     userResponse = storage.getItem('userResponse');
    accesstoken =  userResponse['access_token'];
    
     init();
     
  }
  init() async {
    // await getDocWardList();
    await getFloorList();
    var items = storage.getItem('edit_room');
    id = items['id'].toString();

    floordropdown = items['floor_id'].toString();
    warddropdown = items['ward_id'].toString();
    floor_name = items['floor_name'].toString();
    ward_name = items['ward_name'].toString();
    await getbedist();
    // edittotalroomcontroller.text = bed_list[0]['total_room'].toString();
    //  id = items['id'].toString();
    // await getbedist();
    setState(() {
      // isLoading = true;
    // id = items['id'].toString();

    // floordropdown = items['floor_id'].toString();
    // warddropdown = items['ward_id'].toString();
    // floor_name = items['floor_name'].toString();
    // ward_name = items['ward_name'].toString();
    // getbedist();
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
      // List roomControllers = [];
      // List bedControllers = [];
      List<TextEditingController> roomControllers = [];
      List<TextEditingController> bedControllers = [];
      List room_details_id = [];
      
Future<void> getbedist() async {
  var data = {
    "id": id.toString(),
  };

  try {
    
    bed_list = await PatientApi().getEditRoomList(accesstoken, data);

    // Check for session expiration
    if (Helper().isvalidElement(bed_list) &&
        Helper().isvalidElement(bed_list['status']) &&
        bed_list['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expired');
      return;
    }

  
    bed_list = bed_list['list'];

    setState(() {
    
      edittotalroomcontroller.text = bed_list[0]['total_room'].toString();

   
      final int initialCount = int.tryParse(edittotalroomcontroller.text) ?? 0;

      updateRoomControllers(bed_list);

      isLoading = true;
    });
  } catch (e) {
   
 
  }
}
  // getbedist() async {
   
  //   var data = {
  //     "id": id.toString(),
  //   };
 
  //   bed_list = await PatientApi().getEditRoomList(accesstoken, data);
  //   if (Helper().isvalidElement(bed_list) &&
  //       Helper().isvalidElement(bed_list['status']) &&
  //       bed_list['status'] == 'Token is Expired') {
  //     Helper().appLogoutCall(context, 'Session expeired');
  //   } else {
  //     bed_list = bed_list['list'];
  //     this.setState(() {
  //       edittotalroomcontroller.text=bed_list[0]['total_room'].toString();
  //         final int initialCount = int.tryParse(edittotalroomcontroller.text) ?? 0;
  //   //       updateRoomControllers(initialCount);
  //   //   edittotalroomcontroller.addListener(() {
  //   //   final int? count = int.tryParse(edittotalroomcontroller.text);
  //   //   if (count != null && count > 0) {
  //   //     updateRoomControllers(count);
  //   //   } else {
  //   //     updateRoomControllers(0);
  //   //   }
  //   // });
  //   roomControllers = bed_list;
  //   updateRoomControllers(data);
  //   // roomControllers=bed_list['room_no'];
  //   // bedControllers=bed_list['bed'];
  //       isLoading = true;
  //     });
  //   }
  // }

  @override
 
//  void updateRoomControllers(int count) {
//   setState(() {
 
//     if (roomControllers.length < count) {
//       for (int i = roomControllers.length; i < count; i++) {
//         roomControllers.add(TextEditingController());
//         bedControllers.add(TextEditingController());
//       }
//     } else if (roomControllers.length > count) {
//       roomControllers.removeRange(count, roomControllers.length);
//       bedControllers.removeRange(count, bedControllers.length);
//     }
//   });
// }
void updateRoomControllers(data,) {
  setState(() {
   
    while (roomControllers.length < data.length) {
      roomControllers.add(TextEditingController());
    }
    while (roomControllers.length > data.length) {
      roomControllers.removeLast().dispose(); 
    }

    while (bedControllers.length < data.length) {
      bedControllers.add(TextEditingController());
    }
    while (bedControllers.length > data.length) {
      bedControllers.removeLast().dispose(); 
    }
    while (room_details_id.length < data.length) {
      room_details_id.add(TextEditingController());
    }
    while (room_details_id.length > data.length) {
      room_details_id.removeLast().dispose();
    }
    
    for (int i = 0; i < data.length; i++) {
      roomControllers[i].text = data[i]["room_no"].toString(); 
      bedControllers[i].text = data[i]["bed"].toString();
      room_details_id[i]= data[i]["id"].toString();  
    }
    // if (roomControllers.length < count) {
    //   for (int i = roomControllers.length; i < count; i++) {
    //     roomControllers.add(TextEditingController());
    //     bedControllers.add(TextEditingController());
    //   }
    // } else if (roomControllers.length > count) {
    //   roomControllers.removeRange(count, roomControllers.length);
    //   bedControllers.removeRange(count, bedControllers.length);
    // }
  });
}
  Widget build(BuildContext context) {
     double screenHeight = MediaQuery.of(context).size.height;
    double screenWidht = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
       onPopInvoked: (didPop) {
         Navigator.push(
          context, MaterialPageRoute(builder: (context)=>RoomList())
         );
      },
      child:  Scaffold(
         appBar: AppBar(
          title: Text('Edit Room',style: TextStyle(color: Colors.white),),
           backgroundColor:custom_color.appcolor,
          leading: IconButton(onPressed: (){
            Navigator.push(
          context, MaterialPageRoute(builder: (context)=> RoomList(),)
         );
          }, icon: Icon(Icons.arrow_back,
          color: Colors.white,),),
        ),
        body: isLoading ? SafeArea(
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
                  // 'Select Floor',
                  '${floor_name}'
                ),
                // value:patternDropdownvalue,
                onChanged: (item) async {
                  floordropdown = item.toString();
                  // getWardListRoom();
                  setState(() {
                   wardList = [];
                 });
                 await getWardListRoom();
                },
                items: floorList
                    .map<DropdownMenuItem<String>>(
                        (value) => DropdownMenuItem<String>(
                              value: value["id"].toString(),
                              child: Text(value["floor_name"].toString()),
                              
                            ),)
                    .toList()

                )
                ),
                  SizedBox(height: screenHeight*0.02,),
                  SizedBox(
            width: screenWidht * 0.95,
            child:wardList.length>0? DropdownButtonFormField(
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
                  // 'Select Ward',
                  '${ward_name}'
                ),
                // value:patternDropdownvalue,
                onChanged: (item) async {
                  warddropdown = item.toString();
                 
                },
                items: wardList
                    .map<DropdownMenuItem<String>>(
                        (value) => DropdownMenuItem<String>(
                              value: value["id"].toString(),
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
                  '${ward_name}',
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
                            Container(
                              
                              height: screenHeight*0.01,
                              width:screenWidht*0.8,
                            ),
                            TextFormField(
                            
                    controller: edittotalroomcontroller,
                    keyboardType:TextInputType.none,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      
                      labelText: "Total Room  ",
                      
                    ),
                     onChanged: (value) {
                final int? count = int.tryParse(value);
                 final int? data = int.tryParse(value);
                if (count != null && count > 0) {
                  updateRoomControllers(count,);
                } else {
                  updateRoomControllers(0,);
                }
              }
                    ),
                  
                                   
                  SizedBox(height: screenHeight*0.02,),
         ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: roomControllers.length,
              itemBuilder: (BuildContext context, int index) {
    return Padding(
      
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text('Room ${index + 1}'),
                     Text('Room No *'),
                    TextFormField(
                      keyboardType:TextInputType.number,
                      controller: roomControllers[index],
                      decoration: InputDecoration(
                        // labelText: 'Enter details for Room ${index + 1}',
                         hintText: 'Enter Room No ',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16), 
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text('Total Bed ${index + 1}'),
                    Text('Total Bed *'),
                    TextFormField(
                      keyboardType:TextInputType.number,
                      controller: bedControllers[index], 
                      decoration: InputDecoration(
                        // labelText: 'Enter Total Bed ${index + 1}',
                         hintText: 'Enter Total Bed ',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  },
),
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
                    child:Text('Update',
                    style: TextStyle(fontSize: 20,color: Colors.white),),
                    onPressed: (() async{
                        var bedValues = bedControllers.map((controller) => controller.text).toList();
                        var roomValues = roomControllers.map((controller) => controller.text).toList();
                        //  var room_details_id = room_details_id.map((controller) => controller.text).toList();
                      if(edittotalroomcontroller.text.isEmpty){
                          NigDocToast().showErrorToast('Please Enter Room Name');
                                      
                       
                        }else{
                          var items={
                              "id":id.toString(),
                              "room_details_id":room_details_id,
                              "floor_id":floordropdown,
                              "ward_id":warddropdown,
                              "total_bed":bedValues,
                              "total_room":roomValues
                
                          };
print(items);
                          var list = await PatientApi()
                                     .DocEditRoom(accesstoken, items);
                                 if (list['message'] ==
                                     "updated successfully") {
                                   NigDocToast().showSuccessToast(
                                       'updated successfully');
                                   Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                           builder: (context) => RoomList()));
                                 } else {
                                   NigDocToast()
                                       .showErrorToast('Please TryAgain later');
                                 }
                         // Helper().isvalidElement(data);
                         //   print(data);
                        }
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>RoomList()));
                    }),),
                 
                  ],
                ),
              ),
            ),
          )): Center(child: Container(child: SpinLoader())),
      ) 
      
      );
  }
  getWardListRoom()async{
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
}