import 'package:core/base_classes/base_view.dart';
import 'package:flutter/material.dart';
import 'package:presentation/chat/coordinator/chat_coordinator.dart';
import 'package:presentation/chat/state/chat_state.dart';
import 'package:presentation/credential_exchange/coordinator/wallet_credentials_offer_request_coordinator.dart';
import 'package:presentation/credential_exchange/state/wallet_credentials_offer_request_state.dart';
import 'package:presentation/chat/widgets/chat_widget.dart';
import 'package:presentation/credential_exchange/widgets/wallet_identity_verification_document_widget.dart';
import 'package:widget_library/common_widget/app_bars/ps_appbar.dart';
import 'package:widget_library/ps_scaffold.dart';
import 'package:presentation/preference_collection/widgets/preferences_onboarding_form_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

String extractAuthor(Map<String, dynamic> auth) {
  String protectedRaw = auth['signature']['signatures'][0]['protected'];
  String protectedString = utf8.decode(base64Url.decode(base64Url.normalize(protectedRaw)));
  Map<String, dynamic> protectedDecoded = jsonDecode(protectedString);
  String keyId = protectedDecoded['kid'];
  return keyId.split('#')[0];
}

// user pov - click button to verify booking, has the link to verify booking cred

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

Future<List<ChatMessage>> fetchChatMessages() async {
  print("fetching chat messages");
  final url = 'http://188.245.52.145:80/records/query';
  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'protocol': 'http://chat-protocol.xyz',
      'protocolPath': 'thread/message',
      'parentId': 'bafyreigpj6drhqhtgltzcsrldnuti35sophnxvq2jlul5wzs2eb7djkho4',
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
    final List<dynamic> data = jsonDecode(response.body);
    print("data: ${data}");
    return data.map((item) => ChatMessage(
      text: item['encodedData']['title'],
      actionLabel: item['encodedData']['action'],
      isSentByUser: extractAuthor(item['authorization']) == "did:key:z6Mkkq7UNpMq9cdYoC5bqG2C4reWkPTgwDzKqBy1Y8utc4gW",
      initialOffer: item['encodedData']['initialOffer'],
      onActionPressed: () {
        print("action pressed");
        if (item['encodedData']['action'] == "Start check-in") {
          sendMessage(data:
          "{\"title\":\"Okay, I'm ready to check-in!\"}");
        }
        
      },
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
    return BaseView<ChatCoordinator,
        ChatViewState>(
      setupCoordinator: (coordinator) async {
        await coordinator.initialize(context);
      },
      builder: (
          context,
          state,
          viewModel,
          ) =>
          buildWithState(
            context,
            state,
            viewModel,
          ),
    );
  }

  Widget buildWithState(
      BuildContext context,
      ChatViewState state,
      ChatCoordinator coordinator,
      ) {
    return PSScaffold(
      appBarAttributes: PSAppBarAttributes(
          title: "Chat with Starlight Hotels", left: [
        PSAppBarButtonAttributes(
          type: PSAppBarButtons.back,
          onPressed: () => coordinator.navigateToSplash(),
        ),
      ],
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
                return ChatMessageWidget(coordinator: coordinator, message: snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }
  }

