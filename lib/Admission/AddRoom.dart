import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/Admission/Room.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../AppWidget/common/Colors.dart' as custom_color;

class Addroom extends StatefulWidget {
  const Addroom({super.key});

  @override
  State<Addroom> createState() => _AddroomState();
}

class _AddroomState extends State<Addroom> {
   final LocalStorage storage = new LocalStorage('doctor_store');
   TextEditingController totalroomcontroller = TextEditingController();
  var floordropdown;
  var warddropdown;
  List floorList =[];
  List wardList = [];
  var userResponse;
  var accesstoken;
  bool isLoading =false;
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

  @override
  // void dispose() {
  //   totalroomcontroller.dispose();
  //   for (var controller in roomControllers) {
  //     controller.dispose();
  //   }
  //   super.dispose();
  // }

 void updateRoomControllers(int count) {
  setState(() {
    // Update room controllers
    if (roomControllers.length < count) {
      for (int i = roomControllers.length; i < count; i++) {
        roomControllers.add(TextEditingController());
        bedControllers.add(TextEditingController());
      }
    } else if (roomControllers.length > count) {
      roomControllers.removeRange(count, roomControllers.length);
      bedControllers.removeRange(count, bedControllers.length);
    }
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
      child: Scaffold(
         appBar: AppBar(
          title: Text('Add Room',style: TextStyle(color: Colors.white),),
           backgroundColor:custom_color.appcolor,
          leading: IconButton(onPressed: (){
            Navigator.push(
          context, MaterialPageRoute(builder: (context)=> RoomList(),)
         );
          }, icon: Icon(Icons.arrow_back,
          color: Colors.white,),),
        ),
        body: SafeArea(
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
                            ))
                    .toList()

                )),
                  SizedBox(height: screenHeight*0.02,),
                  SizedBox(
            width: screenWidht * 0.95,
            child: wardList.length>0? DropdownButtonFormField(
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
                  // warddropdown = item.toString();
                   warddropdown = item;
                 var u=warddropdown.split('&%*');
                 
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
                            Container(
                              
                              height: screenHeight*0.01,
                              width:screenWidht*0.8,
                            ),
                            TextFormField(
                    controller: totalroomcontroller,
                    keyboardType:TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      
                      labelText: "Total Room * ",
                      
                    ),
                     onChanged: (value) {
                final int? count = int.tryParse(value);
                if (count != null && count > 0) {
                  updateRoomControllers(count);
                } else {
                  updateRoomControllers(0);
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
                    child:Text('Submit',
                    style: TextStyle(fontSize: 20,color: Colors.white),),
                    onPressed: (() async{
                        var bedValues = bedControllers.map((controller) => controller.text).toList();
                        var roomValues = roomControllers.map((controller) => controller.text).toList();
                      if(totalroomcontroller.text.isEmpty){
                          NigDocToast().showErrorToast('Please Enter Total Room');
                                      
                       
                        }else{
                          var items={
                              
                              "floor_id":floordropdown,
                              "ward_id":warddropdown,
                              "total_bed":bedValues,
                              "total_room":roomValues
                
                          };
                          var list = await PatientApi()
                                     .AddDocRoom(accesstoken, items);
                                 if (list['message'] ==
                                     "Room Add successfully") {
                                   NigDocToast().showSuccessToast(
                                       'Room Add successfully');
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
          )),
      ));
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