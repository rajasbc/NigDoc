import 'package:flutter/material.dart';
import 'package:nigdoc/AppWidget/VideoCall/participant_tile.dart';
import 'package:videosdk/videosdk.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  late Room _room;

  Map<String, Participant> participants = {};
  String? joined;

  @override
  void initState() {
    // create room
    _room = VideoSDK.createRoom(
      roomId: "05yi-eckx-yoy3",
      token:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiJmNzliOGJjNS04MzlkLTRjOTMtYTA5YS1lZGY5ZjM1YWE4NmYiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTY5NjU5OTcwMywiZXhwIjoxODU0Mzg3NzAzfQ.B_MfOR1pMq_UrfEvwORx3kaJ2dlulAPqis1dzFuUeq8",
      displayName: "Arunkumar's Org",
      micEnabled: true,
      camEnabled: true,
      defaultCameraIndex:
          1, // Index of MediaDevices will be used to set default camera
    );

    //set up event listener which will give any updates happening in the room
    setRoomEventListener();
    super.initState();
  }

  // listening to room events
  void setRoomEventListener() {
    //Event called when room is joined successfully
    _room.on(Events.roomJoined, () {
      setState(() {
        joined = "JOINED";
        participants.putIfAbsent(
            _room.localParticipant.id, () => _room.localParticipant);
      });
    });

    //Event called when new participant joins
    _room.on(
      Events.participantJoined,
      (Participant participant) {
        setState(
          () => participants.putIfAbsent(participant.id, () => participant),
        );
      },
    );
    //Event called when a participant leaves the room
    _room.on(Events.participantLeft, (String participantId) {
      if (participants.containsKey(participantId)) {
        setState(
          () => participants.remove(participantId),
        );
      }
    });
    //Event called when you leave the meeting
    _room.on(Events.roomLeft, () {
      participants.clear();
      Navigator.popUntil(context, ModalRoute.withName('/'));
    });
  }

  // onbackButton pressed leave the room
  Future<bool> _onWillPop() async {
    _room.leave();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('VideoSDK QuickStart'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: joined != null
              ? joined == "JOINED"
                  ? Column(
                      children: [
                        //render all participants in the room
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              return ParticipantTile(
                                  participant:
                                      participants.values.elementAt(index));
                            },
                            itemCount: participants.length,
                          ),
                        )
                      ],
                    )
                  : const Text("JOINING the Room",
                      style: TextStyle(color: Colors.white))
              : ElevatedButton(
                  onPressed: () {
                    //Method to join the room
                    _room.join();
                    setState(() {
                      joined = "JOINING";
                    });
                  },
                  child: const Text("Join the Room")),
        ),
      ),
    );
  }
}
