import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/Admission/AddRoom.dart';
import 'package:nigdoc/Admission/Admission.dart';
import 'package:nigdoc/Admission/EditRoom.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../AppWidget/common/Colors.dart' as custom_color;

class RoomList extends StatefulWidget {
  const RoomList({super.key});

  @override
  State<RoomList> createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  final LocalStorage storage = new LocalStorage('doctor_store');
   TextEditingController searchText = TextEditingController();
   TextEditingController wardnamecontroller = TextEditingController();
   TextEditingController editwardnamecontroller = TextEditingController();
  var searchList;
  var list =0;
  var selected_floor;
  var userResponse;
  var accesstoken;
  bool isLoading = false;
  var roomList;
  var floordropdown;
var data2;
var delete = 'yes';
var room_List;
  List floorList =[];
  void initState() {
     userResponse = storage.getItem('userResponse');
    accesstoken =  userResponse['access_token'];
    
     init();
     
  }
  init() async {
    await getroomList();
    // await getFloorList();

    setState(() {
    
    });

   
  }
     getroomList() async {
    var List = await PatientApi().getRoomList(accesstoken);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        roomList = List['list'];
        isLoading = true;
        filterItems(searchText.text);
      });
    }
  }
   void filterItems(String text) {
    // setState(() {
    if (text.isEmpty) {
      setState(() {
        room_List = roomList;
      });
    } 
    else if (text.length >= 3) {
      setState(() {
        room_List = roomList.where((item) =>
            item['floor_name']
                .toString()
                .toLowerCase()
                .contains(text.toLowerCase()),
            // item['phone']
            //     .toString()
            //     .toLowerCase()
            //     .contains(text.toLowerCase())
                ).toList();
      });
    }
  }
  //  getDocWardList() async {
  //   var List = await PatientApi().getDocWardList(accesstoken);
  //   if (Helper().isvalidElement(List) &&
  //       Helper().isvalidElement(List['status']) &&
  //       List['status'] == 'Token is Expired') {
  //     Helper().appLogoutCall(context, 'Session expeired');
  //   } else {
  //     setState(() {
  //       wardList = List['list'];
  //       isLoading = true;
  //       // filterItems(searchText.text);
  //     });
  //   }
  // }
  // getFloorList() async {
  //   var List = await PatientApi().getDocFloor(accesstoken);
  //   if (Helper().isvalidElement(List) &&
  //       Helper().isvalidElement(List['status']) &&
  //       List['status'] == 'Token is Expired') {
  //     Helper().appLogoutCall(context, 'Session expeired');
  //   } else {
  //     setState(() {
  //       floorList = List['list'];
  //       isLoading = true;
  //       // filterItems(searchText.text);
  //     });
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidht = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
         Navigator.push(
          context, MaterialPageRoute(builder: (context)=> Admission(),)
         );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Room List',style: TextStyle(color: Colors.white),),
           backgroundColor:custom_color.appcolor,
          leading: IconButton(onPressed: (){
            Navigator.push(
          context, MaterialPageRoute(builder: (context)=> Admission(),)
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
                    Center(child: 
                          Container(
                            height: screenHeight * 0.06,
                            width: screenWidht*0.95,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: custom_color.appcolor,),
                                borderRadius: BorderRadius.all(Radius.circular(4))),
                            child: Row(
                              children: [
                                // Container(
                                //     width: screenWidth * 0.1,
                                //     height: screenHeight,
                                //     child: Icon(Icons.search,
                                //         color: custom_color.appcolor,)),
                                Container(
                                  width: screenWidht * 0.65,
                                  child: TextField(
                                    controller: searchText,
                                    onChanged: (text) {
                                      print(text);
                                filterItems(text);
                                      this.setState(() {});
                                      // var list = ProductListItem;
                                        // searchList = medicineList.where((element) {
                                        //   var treatList = element['name'].toString().toLowerCase();
                                        //   return treatList.contains(text.toLowerCase());
                                        //   // return true;
                                        // }).toList();
                                        // this.setState(() {});
                                    },
                                    decoration: new InputDecoration(
                                      filled: true,
                                      border: InputBorder.none,
                                      fillColor: Colors.white,
                                      hintText: 'Search Room List Here...',
                                    ),
                                  ),
                                ),
                                searchText.text.isNotEmpty
                                    ? Container(
                                        width: screenWidht * 0.06,
                                        height: screenHeight,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              searchText.clear();
                                              filterItems(searchText.text);
                                              searchList='';
                                            });
                                          },
                                        ))
                                    : Container(),
                                     Container(
                                    width: screenWidht * 0.18,
                                    height: screenHeight,
                                    child: Icon(Icons.search,
                                        color: custom_color.appcolor,)),
                                        
                              ],
                            ),
                          ),),
                          SizedBox(height: screenHeight*0.02,),
                           Helper().isvalidElement(room_List) && room_List.length > 0 ?
                           Container(
                            height:screenHeight * 0.85,
                            
                                     
                           width: screenWidht,
                            // padding:EdgeInsets.all(5),
                            child: 
                            ListView.builder(
                              shrinkWrap: true,
                              // physics: NeverScrollableScrollPhysics(),
                              itemCount: room_List.length,
                              // itemCount: 1,
                              itemBuilder: (BuildContext context, int index){
                                list=index+1;
                                var data=room_List[index];
                                return Container(
                                  child: Column(
                                    children: [
                                      Card(
                                        color: index % 2 == 0
                                                      ?custom_color.lightcolor
                                                      : Colors.white,
                                        child: ListTile(
                                          // title: SizedBox(child: Text('${data['floor_name']}')),
                                          // subtitle: Text('₹  ${data['mrp']}'),
                                          title: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Floor Name : ${data['floor_name']}', ),
                                              Text('Ward Name : ${data['ward_name']}'),
                                               Text('Total Room : ${data['total_room']}'),
                                               Text('Total Bed : ${data['bed'] == null ?'':data['bed'] }'),
                                            ],
                                          ),
                                        
                                          // subtitle: Column(
                                          //   crossAxisAlignment: CrossAxisAlignment.start,
                                          //   children: [
                                          //     Text('Total Room :', style: TextStyle(fontWeight: FontWeight.bold)),
                                          //      Text('Total Bed : ', style: TextStyle(fontWeight: FontWeight.bold)),
                                          //   ],
                                          // ),
                                          leading: Padding(
                                            padding: const EdgeInsets.only(top:3.0),
                                            child: Text('($list)'),
                                          ),
                            
                  
                             trailing: PopupMenuButton(itemBuilder: (context)=>
                    [
                    PopupMenuItem(
                      child: Row(
                      children: [
                        
                          Icon(Icons.edit,
                          color: custom_color.appcolor,
                          ),
                             Padding(padding: EdgeInsets.only(left:10),
                             child: Center(child: Text('Edit',style: TextStyle(fontSize: 16),)),),
                  
                      ],
                    ),
                   
                    onTap: ()async{
                        await storage.setItem('edit_room', data);
                      
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Editroom()));
         
                    }
                                        
                       ),
                                  
                    PopupMenuItem(
                          child: Row(
                          children: [
                        
                          Icon(Icons.delete,
                          color: custom_color.appcolor,
                          ),
                             Padding(padding: EdgeInsets.only(left:10),
                             child: Center(child: Text('Delete',style: TextStyle(fontSize: 16),
                             
                             )),
                             
                             ),
                    
                      ],
                    ),
                   
                    onTap: () {
                       showDialog(context: context, builder: (context)=>AlertDialog(
                    
                          actions: [
                            IconButton(onPressed: (){
                       Navigator.push(context,MaterialPageRoute(builder: (context) => RoomList()));
                        }, icon: Icon(Icons.close,color: Colors.red,)),
                            SizedBox(height: screenHeight*0.02,),
                             Center(child: Container(child: Text('DELETE ROOM',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),))),
                             SizedBox(height: screenHeight*0.02,),
                             Container(
                              child: Text('Are you sure you want to delete the Room Details?',style: TextStyle(fontSize: 16),),
                             ),
                              SizedBox(height: screenHeight*0.02,),
                             Container(
                              child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child: ElevatedButton(
                                       style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      
                    )
                    
                  ),
                                      onPressed: (){
                                    
                                      Navigator.pop(context);
                                      }, child: Text('Cancel' ,style: TextStyle(fontSize: 20,color: Colors.white),)),
                                  ),
                                  Container(
                                    child: ElevatedButton(
                                       style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      
                    )
                    
                  ),
                  
                                      onPressed: ()async{
                                        
                                               var value= {
                                                 "id":data['id'].toString(),
                                              
                                               };
                                               var list = await PatientApi()
                                        .DocDeleteRoom( accesstoken, value);
                                    if (list['message'] ==
                                        "Deleted successfully") {
                                      NigDocToast().showSuccessToast(
                                          'Deleted successfully');
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => RoomList()));
                                    } else {
                                      NigDocToast()
                                          .showErrorToast('Please TryAgain later');
                                    }
                                      }, child: Text('Confirm' ,style: TextStyle(fontSize: 20,color: Colors.white),)),
                                  ),
                                  
                                ],
                              ),
                             )
                          ]
                       ));
                    }
                                        
                    ),
                   
                    ],            
                               ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                            })
                             )
                             :Container(child:
                              Text('No Data Found')
                              )
                  ],
                ),
              ),
            ),
          ),
         
        ),
         floatingActionButton: FloatingActionButton(
            
            onPressed:(){
         Navigator.push(context, MaterialPageRoute(builder: (context)=>Addroom()));
            
             
            },
          child:Icon(Icons.add,
          size: 30,
          color: Colors.white,),
          backgroundColor: custom_color.appcolor,
            
            ),
      ));
  }
}