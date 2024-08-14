import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:mosttest/model/livenessDAO.dart';
import 'package:mosttest/util/constants.dart';
import 'package:http/http.dart' as http;

Future<LivenessDAO?> validarLiveliness(
  XFile video,
  String? token,
) async {
  var uri = Uri.https(baseURL, '/liveness/detect');
  var request = http.MultipartRequest('POST', uri)
    ..fields['movement'] = 'smile'
    ..files.add(http.MultipartFile.fromBytes("file", await video.readAsBytes()!,
        filename: "arquivo.mp4"))
    ..headers.addAll({'Authorization': 'Bearer $token'});
  var response = await request.send();

  var responseBody = await response.stream.bytesToString();
  //print(responseBody);
  var decodedResponse = jsonDecode(responseBody);
  if (response.statusCode != 200) return null;
  final obj = LivenessDAO.fromJson(decodedResponse);

  return obj;
}

Future<String?> auth(String token) async {
  var uri = Uri.https(baseURL, '/user/authenticate');
  final body = jsonEncode({"token": token});
  var response = await http
      .post(uri, body: body, headers: {'Content-Type': 'application/json'});
  //print(response.body);
  if (response.statusCode != 200) return null;
  var decodedResponse = jsonDecode(response.body);
  return decodedResponse['token'];
}
