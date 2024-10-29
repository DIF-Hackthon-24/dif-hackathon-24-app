import 'package:core/qr_code/qr_code_scanner.dart';
import 'package:flutter/material.dart';
import 'package:shared_dependencies/constants/color_constants.dart';
import 'package:shared_dependencies/constants/dimension_constants.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:widget_library/input_text_view/form_text_field.dart';
import 'package:http/http.dart' as http;

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

  ChatMessage({
    required this.text,
    this.actionLabel,
    this.onActionPressed,
    required this.isSentByUser
  });
}

class ChatMessageWidget extends StatelessWidget {
  final ChatMessage message;

  const ChatMessageWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              if (message.actionLabel != null && message.onActionPressed != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: message.onActionPressed,
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

class ChatWidget extends StatelessWidget {
  // final PreferencesOnboardingInputFormAttributes attributes;

  final List<ChatMessage> messages;

  const ChatWidget({Key? key, required this.messages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return ChatMessageWidget(message: messages[index]);
        },
      ),
    );
  }
}




