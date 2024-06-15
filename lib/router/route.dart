
import 'package:server_learning/handler/chat_handler.dart';
import 'package:server_learning/handler/home_handler.dart';
import 'package:server_learning/handler/login_handler.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';

Router createRoute() {
  var route = Router();
  route.get('/home', homeHandler);
  route.post('/login', login);
  route.get('/chat', webSocketHandler(ChatHandler().chatMsg));
  return route;
}