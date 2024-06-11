import 'dart:async';
import 'dart:convert';
import 'dart:io';
import '../model/user.dart';
import 'package:mysql1/mysql1.dart';
import 'package:pool/pool.dart';
import 'package:yaml/yaml.dart';

class MysqlService {
  // 连接信息
  static late final ConnectionSettings _settings;

  // 连接池信息
  static late final Pool _pool;

  // 这里涉及到读取文件，因此是异步的操作
  static Future<void> initialize() async {
    var yamlFile = File('mysql.yaml');
    var content = await yamlFile.readAsString();
    var config = loadYaml(content);
    _settings = ConnectionSettings(
        host: config['database']['host'],
        port: config['database']['port'],
        user: config['database']['user'],
        password: config['database']['password'],
        db: config['database']['db']);
    _pool = Pool(config['database']['maxConnections']);
  }

  static Future<MySqlConnection> getConnection() async {
    return await MySqlConnection.connect(_settings);
  }

  static Future<List<User>> getData() async {
    return _pool.withResource(() async {
      var conn = await getConnection();
      await Future.delayed(Duration(seconds: 1));
      try {
        // 这里返回的是一个对象，需要转成json才可以返回给前端
        var result = await conn.query('select user_id, user_name,nick_name from sys_user');
        // FIXME 这里应该是存在问题的，必须要两次conn.query才可以执行第一次的sql,可以在上面获取链接的后面加上await
        // result = await conn.query('');
        // 这里返回的是一个对象，需要转成json才可以返回给前端
        var data = result.map((e) {
          return User.fromMap(e.fields);
        }).toList();
        // 注意这里的toMap才是对象的序列化方法
        return data;
      } finally {
        await conn.close();
      }
    });
  }
}
