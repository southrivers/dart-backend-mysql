import 'package:web_socket_channel/web_socket_channel.dart';

class ChatHandler {
  var client = <WebSocketChannel>[];

  Future<void> chatMsg(WebSocketChannel webSocketChannel) async {
    client.add(webSocketChannel);
    webSocketChannel.stream.listen((event) {
      for (var value in client) {
        if (value != webSocketChannel) {
          value.sink.add(event);
        }
      }
    }, onDone: () {
      client.remove(webSocketChannel);
    });
  }
}
