import 'dart:async';
import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:server_learning/service/mysql_service.dart';
import 'package:server_learning/service/redis_service.dart';
import 'package:shelf/shelf.dart';

FutureOr<Response> homeHandler(Request request) async {
  var jwt = request.context['jwt'] as JWT;
  print(jwt.payload['name']);
  try {
    var data = await MysqlService.getData();
    var redisData = await RedisAuth.getData('name');
    var response = {
      'status': 0,
      'msg': 'success',
      'redisData': redisData,
      'data':data.map((e) => e.toMap()).toList(),
    };
    return Response.ok(jsonEncode(response));
  } catch(e) {
    // 这种格式是一个map，需要将其转换成对应的json才可以
    var response = {
      'status': 0,
      'msg': 'error'
    };
    return Response.internalServerError(body: jsonEncode(response));
  }

}
