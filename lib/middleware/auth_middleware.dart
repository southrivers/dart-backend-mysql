import 'package:server_learning/service/auth_service.dart';
import 'package:shelf/shelf.dart';

/**
 *   说明，这里的middleware
 */
Middleware authMiddleware() {
  return (Handler inHandler) {
    return (Request request) {
      var path = request.url.path;
      if (path.contains('login')) {
        return inHandler(request);
      } else {
        var token = request.headers['Authorization'];
        if (token == null) {
          return Response.forbidden('invalid token');
        } else {
          try {
            var jwt = AuthService.verifyToken(token);
            var nReq = request.change(context: {'jwt': jwt});
            return inHandler(nReq);
          } catch (e) {
            return Response.forbidden('invalid token');
          }
        }
      }
    };
  };
}