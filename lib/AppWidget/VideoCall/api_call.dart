import 'dart:convert';
import 'package:http/http.dart' as http;

//Auth token we will use to generate a meeting and connect to it
String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiJmNzliOGJjNS04MzlkLTRjOTMtYTA5YS1lZGY5ZjM1YWE4NmYiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTY5NjU5OTcwMywiZXhwIjoxODU0Mzg3NzAzfQ.B_MfOR1pMq_UrfEvwORx3kaJ2dlulAPqis1dzFuUeq8";

// API call to create meeting
Future<String> createMeeting() async {
  final http.Response httpResponse = await http.post(
    Uri.parse("https://api.videosdk.live/v2/rooms"),
    headers: {'Authorization': token},
  );

//Destructuring the roomId from the response
  return json.decode(httpResponse.body)['roomId'];
  
}