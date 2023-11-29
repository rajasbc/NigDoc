import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/Setting/Setting.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../AppWidget/common/Colors.dart' as custom_color;

class TreatmentList extends StatefulWidget {
  const TreatmentList({super.key});

  @override
  State<TreatmentList> createState() => _TreatmentListState();
}

class _TreatmentListState extends State<TreatmentList> {
  final LocalStorage storage = new LocalStorage('doctor_store');
   TextEditingController searchText = TextEditingController();


  var accesstoken=null;
  var ProductList;
  var userResponse;
  bool isLoading=false;
  var list=0;
  
  var searchList;
  var treatmentList;
  var Treatment_List;

   @override
  void initState() {
    userResponse = storage.getItem('userResponse');
    accesstoken=userResponse['access_token'];

    gettreatmentlist();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Treatment_List=Helper().isvalidElement(searchList)&&searchText.text.isNotEmpty?searchList: treatmentList;
    double screenHeight = MediaQuery.of(context).size.height - 50;
    double screenWidth = MediaQuery.of(context).size.width;
      return new WillPopScope(
       onWillPop: () async {
         Navigator.push(
          context, MaterialPageRoute(builder: (context)=> Setting(),)
         );
         return true;
        },
        child:Scaffold(
          appBar: AppBar(title: Text('Treatment List',
          style: TextStyle(color: Colors.white),),
          backgroundColor: custom_color.appcolor ,
          leading: IconButton(onPressed: (){
            Navigator.push(
          context, MaterialPageRoute(builder: (context)=> Setting(),)
         );
          }, icon: Icon(Icons.arrow_back,
          color: Colors.white,),),
          // actions: [TextButton(onPressed: (){
          //   Navigator.push(context, MaterialPageRoute(builder: (context) => const Add()),);
          // }, child: 
          // Row(
          //   children: [
          //     Icon(Icons.add, color: Colors.black,),
          //     Text('Add',style: TextStyle(fontSize: 18, color:Colors.black),),
          //   ],
          // )),
          // ],
          ),
          body:isLoading? SingleChildScrollView(
            child: Padding(padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [
                // Container(
                //   width: screenWidth*0.9,
                //   child: TextFormField(decoration: 
                //   InputDecoration(border: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(8),
                //   ),hintText: 'Search',
                //   prefixIcon: Container(
                //     padding: EdgeInsets.all(10),
                //     child: Icon(Icons.search),
                //   ),
                //   ),
                //   ),
                //     ),
                 SizedBox(
                  height: 10,
                ),
                Center(child: 
                Container(
                  height: screenHeight * 0.06,
                  width: screenWidth*0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(color:custom_color.appcolor),
                      borderRadius: BorderRadius.all(Radius.circular(0))),
                  child: Row(
                    children: [
                      Container(
                          width: screenWidth * 0.1,
                          height: screenHeight,
                          child: Icon(Icons.search,
                              color: custom_color.appcolor)),
                      Container(
                        width: screenWidth * 0.65,
                        child: TextField(
                          controller: searchText,
                          onChanged: (text) {
                            print(text);

                            this.setState(() {});
                            // var list = ProductListItem;
                              searchList = treatmentList.where((element) {
                                var treatList = element['treatment_name'].toString().toLowerCase();
                                return treatList.contains(text.toLowerCase());
                                // return true;
                              }).toList();
                              this.setState(() {});
                          },
                          decoration: new InputDecoration(
                            filled: true,
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            hintText: 'Search Treatment List Here...',
                          ),
                        ),
                      ),
                      searchText.text.isNotEmpty
                          ? Container(
                              width: screenWidth * 0.1,
                              height: screenHeight,
                              child: IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    searchText.text = '';
                                    searchList='';
                                  });
                                },
                              ))
                          : Container(),
                    ],
                  ),
                ),),


                    // SizedBox(height: screenHeight*0.01),

                    Helper().isvalidElement(Treatment_List) && Treatment_List.length > 0 ?
                     Container(
                      height:screenHeight * 0.86,
                      

                     width: screenWidth,
                      padding:EdgeInsets.all(15),
                      child: 
                      ListView.builder(
                        // shrinkWrap: true,
                        itemCount: Treatment_List.length,
                        itemBuilder: (BuildContext context, int index){
                          list=index+1;
                          var data=Treatment_List[index];
                          return Container(
                            child: Column(
                              children: [
                                Card(
                                  color: index % 2 == 0
                                                ? custom_color.lightcolor
                                                : Colors.white,
                                  child: ListTile(
                                    title: SizedBox(child: Text('${data['treatment_name']}')),
                                    leading: Text('$list'),
                     
                                  ),
                                )
                              ],
                            ),
                          );
                      })
                       ):Container(child:
            Text('No Data Found')
          ),
                         SizedBox(height: 10,),
                     ],
            ),),
          ):Center(
            child: Container(child:SpinLoader()
          ))));
  }
   gettreatmentlist() async {
    var List = await PatientApi().gettreatmentlist(accesstoken);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        isLoading=true;
        treatmentList = List['list'];
      });
      // TreatmentList = List['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
    }
  }
}