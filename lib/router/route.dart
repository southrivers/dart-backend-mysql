
import 'package:server_learning/handler/home_handler.dart';
import 'package:server_learning/handler/login_handler.dart';
import 'package:shelf_router/shelf_router.dart';

Router createRoute() {
  var route = Router();
  route.get('/home', homeHandler);
  route.post('/login', login);
  return route;
}