import 'package:flutter/material.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/VideoCall/join_screen.dart';
import 'package:nigdoc/AppWidget/VideoCall/meeting_controls.dart';
import 'package:videosdk/videosdk.dart';
import './participant_tile.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;


class MeetingScreen extends StatefulWidget {
  final String meetingId;
  final String token;

  const MeetingScreen(
      {super.key, required this.meetingId, required this.token});

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  late Room _room;
  var micEnabled = true;
  var camEnabled = true;
  bool change = true;

  Map<String, Participant> participants = {};

  @override
  void initState() {
    // create room
    _room = VideoSDK.createRoom(
      roomId: widget.meetingId,
      token: widget.token,
      displayName: "John Doe",
      micEnabled: micEnabled,
      camEnabled: camEnabled,
      defaultCameraIndex:
          1, // Index of MediaDevices will be used to set default camera
    );

    setMeetingEventListener();

    // Join room
    _room.join();

    super.initState();
  }

  // listening to meeting events
  void setMeetingEventListener() {
    _room.on(Events.roomJoined, () {
      setState(() {
        participants.putIfAbsent(
            _room.localParticipant.id, () => _room.localParticipant);
      });
    });

    _room.on(
      Events.participantJoined,
      (Participant participant) {
        setState(
          () => participants.putIfAbsent(participant.id, () => participant),
        );
      },
    );

    _room.on(Events.participantLeft, (String participantId) {
      if (participants.containsKey(participantId)) {
        setState(
          () => participants.remove(participantId),
        );
      }
    });

    _room.on(Events.roomLeft, () {
      participants.clear();
      Navigator.popUntil(context, ModalRoute.withName('/'));
    });
  }

  // onbackButton pressed leave the room
  Future<bool> _onWillPop() async {
    _room.leave();
     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Dash()),
    );
    return true;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
         appBar: AppBar(
          title: Text(
            'Video Call',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: custom_color.appcolor,
          leading: IconButton(
            onPressed: () {
             _onWillPop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        // appBar: AppBar(
        //   title: const Text('Video Call'),
        //   backgroundColor:custom_color.appcolor ,
        // ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text('Call Id : '+ widget.meetingId),
              ),
              //render all participant
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child:
                    
                    // participants.length == 2 ? Stack(
                    //   alignment: AlignmentDirectional.bottomEnd,
                    //   children: [
                    //     ParticipantTile(
                    //         key: Key(participants.values
                    //             .elementAt(change ? 0 : 1)
                    //             .id),
                    //         participant:
                    //             participants.values.elementAt(change ? 0 : 1)),
                    //     InkWell(
                    //       onTap: () {
                    //         setState(() {
                    //           change = !change;
                    //         });
                    //       },
                    //       child: Container(
                    //        height: 250,
                    //         width: 150,
                    //         child: ParticipantTile(
                    //             key: Key(participants.values
                    //                 .elementAt(change ? 1 : 0)
                    //                 .id),
                    //             participant: participants.values
                    //                 .elementAt(change ? 1 : 0)),
                    //       ),
                    //     ),
                    //   ],
                    // ):participants.length == 1 ? ParticipantTile(
                    //         key: Key(participants.values
                    //             .elementAt(0)
                    //             .id),
                    //         participant:
                    //             participants.values.elementAt(0)):
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                        mainAxisExtent: 300,
                      ),
                      itemBuilder: (context, index) {
                        return ParticipantTile(
                            key: Key(participants.values.elementAt(index).id),
                            participant: participants.values.elementAt(index));
                      },
                      itemCount: participants.length,
                    ),
                    ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RawMaterialButton(
                    onPressed: () {
                     
                      setState(() {
                        micEnabled ? _room.muteMic() : _room.unmuteMic();
                        micEnabled = !micEnabled;
                      });
                    },
                    child: Icon(
                      micEnabled ? Icons.mic : Icons.mic_off,
                      color: micEnabled ? Colors.white : Colors.blueAccent,
                      size: 20.0,
                    ),
                    shape: CircleBorder(),
                    elevation: 2.0,
                    fillColor: micEnabled ? Colors.blueAccent : Colors.white,
                    padding: const EdgeInsets.all(12.0),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      _room.leave();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Dash()),
                      );
                    },
                    child: Icon(
                      Icons.call_end,
                      color: Colors.white,
                      size: 35.0,
                    ),
                    shape: CircleBorder(),
                    elevation: 2.0,
                    fillColor: Colors.redAccent,
                    padding: const EdgeInsets.all(15.0),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      
                      setState(() {
                        camEnabled ? _room.disableCam() : _room.enableCam();
                        camEnabled = !camEnabled;
                      });
                    },
                    child: Icon(
                      camEnabled ? Icons.videocam : Icons.videocam_off_outlined,
                      color: camEnabled ? Colors.white : Colors.blueAccent,
                      size: 20.0,
                    ),
                    shape: CircleBorder(),
                    elevation: 2.0,
                    fillColor: camEnabled ? Colors.blueAccent : Colors.white,
                    padding: const EdgeInsets.all(12.0),
                  )
                ],
              )
              // MeetingControls(
              //   onToggleMicButtonPressed: () {
              //     micEnabled ? _room.muteMic() : _room.unmuteMic();
              //     micEnabled = !micEnabled;
              //   },
              //   onToggleCameraButtonPressed: () {
              //     camEnabled ? _room.disableCam() : _room.enableCam();
              //     camEnabled = !camEnabled;
              //   },
              //   onLeaveButtonPressed: () {
              //     _room.leave();
              //      Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => Dash(),
              //             ));
              //   },
              // ),
            ],
          ),
        ),
      ),
      // home: JoinScreen(),
    );
  }
}
