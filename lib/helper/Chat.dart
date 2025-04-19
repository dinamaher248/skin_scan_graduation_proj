import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:http/http.dart' as http;
import '../Api/constants.dart';
import '../widgets/chat/image_servise.dart';
import 'token.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';

class Chat {
  HubConnection? hubConnection;

  Future<void> openCon(id) async {
    hubConnection =
        HubConnectionBuilder().withUrl("$resourceUrl/chatHub?uid=$id").build();
  }

  Future<void> startCon() async {
    if (hubConnection != null) {
      int retryCount = 0;
      while (retryCount < 3) {
        try {
          await hubConnection?.start();
          print("Connection started");
          break;
        } catch (e) {
          retryCount++;
          print("Error starting connection (Attempt $retryCount): $e");
          await Future.delayed(Duration(seconds: 2));
        }
      }
      if (retryCount == 3) {
        print("Failed to start connection after 3 attempts.");
      }
    } else {
      print("HubConnection is null");
    }
  }

  Future<void> sendMessage(String recipientId, String message) async {
    if (hubConnection?.state == HubConnectionState.connected) {
      try {
        await hubConnection?.invoke("sendMessage", args: [
          {
            "senderId":
                await Tokens.getId(await Tokens.retrieve('access_token')),
            "recipientId": recipientId,
            "content": message,
            "type": "text"
          }
        ]);

        print("Message sent successfully: $message to $recipientId");
      } catch (e) {
        print("Error sending message: $e");
      }
    } else {
      print("Waiting for connection");
    }
  }

  Future<List<dynamic>> retriveMessage() async {
    List<dynamic> data = [];
    hubConnection?.on('receiveMessage', (arguments) {
      if (arguments != null) data = arguments;
    });
    return data;
  }

  Future<List<dynamic>> fetchChatHistory(
      String senderId, String receiverId) async {
    final url = Uri.parse(
        "$resourceUrl/api/Chat/history?sen=$senderId&reci=$receiverId");
    String? token = await Tokens.retrieve('access_token');
    final headers = {
      "Authorization": "Bearer $token",
    };

    print("Fetching chat history from: $url with token: $token");

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      print("Chat history fetched: ${response.body}");
      final List<dynamic> history = json.decode(response.body);
      print('history printed ... : $history');
      return history ;
      // .map((msg) => {
      //       'id': msg['id'],
      //       'text': msg['content'],
      //       'senderId': msg['senderId'],
      //       'receiverId': msg['recipientId'],
      //       'timestamp': msg['timestamp'],
      //       'type': msg['type']
      //     })
      // .toList();
    } else {
      print(
          "Failed to load chat history with status code: ${response.statusCode}");
      throw Exception('Failed to load chat history');
    }
  }

  Future<String?> sendImage(String recipientId, XFile image) async {
    if (hubConnection?.state == HubConnectionState.connected) {
      final url = Uri.parse("$resourceUrl/api/Chat/file-upload");
      final token = await Tokens.retrieve('access_token');

      print("Uploading image to: $url");

      print("Token used: $token");

      print("Image path: ${image.path}");
      print("Image name: ${image.name}");

      if (!await File(image.path).exists()) {
        print("Error: Image file does not exist at path ${image.path}");
        return "";
      }

      final formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(image.path, filename: image.name),
        "senderId": await Tokens.getId(token),
        "receiverId": recipientId,
      });

      try {
        final response = await Dio().post(
          url.toString(),
          data: formData,
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
          ),
        );
        if (response.statusCode == 200) {
          final jsonResponse = response.data;
          print(jsonResponse);
          return jsonResponse['fileUrl'];
        } else {
          print(
              " Failed to send image: ${response.statusCode} - ${response.data}");
        }
      } catch (e) {
        if (e is DioError) {
          print("DioError: ${e.response?.statusCode} - ${e.response?.data}");
        } else {
          print(" Error sending image: $e");
        }
      }
    } else {
      print(" Waiting for connection...");
    }
  }

  Future<void> establishConnection() async {
    if (hubConnection?.state != HubConnectionState.connected) {
      try {
        print("Connection not established. Attempting to reconnect...");
        await hubConnection?.start();
        print("Connection reestablished.");
      } catch (e) {
        print("Error reconnecting: $e");
      }
    } else {
      print("Connection already established.");
    }
  }
}
