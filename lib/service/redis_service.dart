import 'dart:io';

import 'package:pool/pool.dart';
import 'package:redis/redis.dart';
import 'package:yaml/yaml.dart';

class RedisAuth {
  static late final _host;
  static late final _port;
  static late final Pool _pool;

  static Future<void> initialize() async {
    var file = File('mysql.yaml');
    // 读取文件是异步操作
    var content = loadYaml(await file.readAsString());
    _host = content['redis']['host'];
    _port = content['redis']['port'];
    _pool = Pool(content['redis']['maxConnections']);
  }

  static Future<Command> getConnection() async {
    var conn = RedisConnection();
    await conn.connect(_host, _port);
    return Command(conn);
  }

  /**
   * 从redis中获取数据
   */
  static Future<String> getData(String key) async {
    return _pool.withResource(() async {
      var command = await getConnection();
      try {
        // 这里因为返回的是一个future，因此还是要用await才可以
        var data = await command.get(key);
        return data.toString();
      } finally {
        command.get_connection().close();
      }
    });
  }
}
