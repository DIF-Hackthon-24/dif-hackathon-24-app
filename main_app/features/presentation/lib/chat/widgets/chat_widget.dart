import 'package:core/qr_code/qr_code_scanner.dart';
import 'package:flutter/material.dart';
import 'package:shared_dependencies/constants/color_constants.dart';
import 'package:shared_dependencies/constants/dimension_constants.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:widget_library/input_text_view/form_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:presentation/chat/coordinator/chat_coordinator.dart';
import 'dart:convert';


// class PreferencesOnboardingInputFormAttributes{
//   Function submitButtonPressed;
//   PreferencesOnboardingInputFormAttributes(
//       { required this.submitButtonPressed});
// }

class ChatMessage {
  final String text;
  final String? actionLabel;
  final VoidCallback? onActionPressed;
  final bool isSentByUser;
  final String? initialOffer;

  ChatMessage({
    required this.text,
    this.actionLabel,
    this.onActionPressed,
    required this.isSentByUser,
    this.initialOffer,
  });
}

Future<void> sendMessage({
  required String data,
}) async {
  final url = 'http://188.245.52.145:80/records/create';
  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'protocol': 'http://chat-protocol.xyz',
      'protocolPath': 'thread/message',
      'parentContextId': 'bafyreigpj6drhqhtgltzcsrldnuti35sophnxvq2jlul5wzs2eb7djkho4',
      'dataFormat': 'application/json',
      'recipient': 'did:key:z6MkeXmNA9HutZcYei7YsU5jimrMcb7EU43BWTXqLXw59VRq',
      'data': data,
      'keyInfo': {
        "keyId": "did:key:z6Mkkq7UNpMq9cdYoC5bqG2C4reWkPTgwDzKqBy1Y8utc4gW#z6Mkkq7UNpMq9cdYoC5bqG2C4reWkPTgwDzKqBy1Y8utc4gW",
        "privateJwk": {
          "crv": "Ed25519",
          "d": "XRax-83L3XJJjMXsocJP_VxjF0u8ZwxUNqlkUmc8s54",
          "kty": "OKP",
          "x": "Xr80ytPQM3T4fkbCjHhTDBBZJF0orXhEFuiH5Ahky8c",
          "kid": "U4ePCnrZP0IOeE45gBnHpHT6IHQNeXG1H53ik-SJfIA",
          "alg": "EdDSA"
        }
      },
      'target': 'did:key:z6Mkkq7UNpMq9cdYoC5bqG2C4reWkPTgwDzKqBy1Y8utc4gW',
    }),
  );

  if (response.statusCode == 200) {
    print('Record created successfully');

  } else {
    throw Exception('Failed to create record: ${response.body}');
  }
}

class ChatMessageWidget extends StatelessWidget {
  final ChatMessage message;
  final ChatCoordinator coordinator;

  const ChatMessageWidget({Key? key, required this.message, required this.coordinator}) : super(key: key);

  handleShareBooking(String? action) {
    if (action == "Share booking") {
      sendMessage(data: "{\"title\":\"Successfully shared booking details!\"}");
    }
    coordinator.navigateToWalletCredentialExchange(message.initialOffer ?? '');
  }

  @override
  Widget build(BuildContext context) {
    print("initialOffer ${message.initialOffer}");
    return Align(
      alignment: message.isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.text,
                style: const TextStyle(fontSize: 16.0),
              ),
              if (message.actionLabel != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: message.actionLabel == "Share booking" || message.actionLabel == "Save room key" ? () => {
                      handleShareBooking(message.actionLabel)
                    } : message.onActionPressed!,
                    child: Text(message.actionLabel!, style: const TextStyle(color: Colors.white)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// class ChatWidget extends StatelessWidget {
//   // final PreferencesOnboardingInputFormAttributes attributes;
//
//   final List<ChatMessage> messages;
//
//   const ChatWidget({Key? key, required this.messages}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Chat'),
//       ),
//       body: ListView.builder(
//         itemCount: messages.length,
//         itemBuilder: (context, index) {
//           return ChatMessageWidget(coordinator: coordinator, message: messages[index]);
//         },
//       ),
//     );
//   }
// }




