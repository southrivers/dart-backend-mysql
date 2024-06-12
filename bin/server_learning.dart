import 'package:server_learning/middleware/auth_middleware.dart';
import 'package:server_learning/router/route.dart';
import 'package:server_learning/service/mysql_service.dart';
import 'package:server_learning/service/redis_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

void main(List<String> arguments) async {

  var route = createRoute();
  // 这里需要加上await
  await MysqlService.initialize();
  await RedisAuth.initialize();
  var handler = Pipeline().addMiddleware(authMiddleware()).addHandler(route);
  await io.serve(handler, 'localhost', 9000);
  print("serve start");
}