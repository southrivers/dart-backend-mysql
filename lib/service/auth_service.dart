import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
class AuthService {

  static final _sign = 'hello';

  static String generateJwtToken(Map<String, dynamic> user) {
    var userName = user['name'];
    var jwt = JWT({'name': userName});
    var token = jwt.sign(SecretKey(_sign));
    return token;
  }

  static JWT verifyToken(String token) {
    var jwt = JWT.verify(token, SecretKey(_sign));
    return jwt;
  }
}