import 'package:core/base_classes/base_view.dart';
import 'package:flutter/material.dart';
import 'package:presentation/credential_exchange/coordinator/wallet_credentials_offer_request_coordinator.dart';
import 'package:presentation/credential_exchange/state/wallet_credentials_offer_request_state.dart';
import 'package:presentation/chat/widgets/chat_widget.dart';
import 'package:presentation/credential_exchange/widgets/wallet_identity_verification_document_widget.dart';
import 'package:widget_library/common_widget/app_bars/ps_appbar.dart';
import 'package:widget_library/ps_scaffold.dart';
import 'package:presentation/preference_collection/widgets/preferences_onboarding_form_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<ChatMessage>> fetchChatMessages() async {
  print("fetching chat messages");
  final url = 'http://188.245.52.145:80/records/query';
  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'protocol': 'http://chat-protocol.xyz',
      'protocolPath': 'thread/message',
      'parentId': 'your_parent_id',
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
  print(response);
  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => ChatMessage(
      text: item['text'],
      actionLabel: item['actionLabel'],
      isSentByUser: item['isSentByUser'],
    )).toList();
  } else {
    throw Exception('Failed to load chat messages');
  }
}

class ChatView extends StatefulWidget {
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late Future<List<ChatMessage>> futureMessages;

  @override
  void initState() {
    super.initState();
    futureMessages = fetchChatMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with Starlight Hotels'),
      ),
      body: FutureBuilder<List<ChatMessage>>(
        future: futureMessages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No messages found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ChatMessageWidget(message: snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }
}
