
import 'dart:convert';

import 'package:server_learning/service/auth_service.dart';
import 'package:shelf/shelf.dart';

Future<Response> login(Request request) async {
  var data = await request.readAsString();
  var userData = jsonDecode(data);
  var token = AuthService.generateJwtToken(userData);
  return Response.ok(token);
}