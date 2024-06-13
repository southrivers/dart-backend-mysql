import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

Future<Response> chat(Request request) async {
  final _client = <WebSocketChannel>[];
  final httpRequest =
      request.context['shelf.io.request'] as HttpRequest;
  if (WebSocketTransformer.isUpgradeRequest(httpRequest)) {
    var socket = await WebSocketTransformer.upgrade(httpRequest);
    var channel = IOWebSocketChannel(socket);
    _client.add(channel);
    channel.stream.listen((event) {
      for (var value in _client) {
        value.sink.add('feed back: ${event.toString()}');
      }
    }, onDone: () {
      _client.remove(channel);
    });
    return Response.ok('connection is established');
  } else {
    return Response.notFound('not a web socket');
  }
}
