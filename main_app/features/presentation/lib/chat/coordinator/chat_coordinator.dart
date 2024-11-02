import 'dart:async';
import 'package:core/base_classes/base_coordinator.dart';
import 'package:flutter/material.dart';
import 'package:presentation/chat/navigation_handler/chat_navigation_handler.dart';
import 'package:presentation/chat/state/chat_state.dart';

class ChatCoordinator extends BaseCoordinator<ChatViewState> {
  final ChatNavigationHandler navigationHandler;
  StreamSubscription? networkSubscription;


  ChatCoordinator({
    required this.navigationHandler,
  }) : super(
    ChatViewState(
    ),
  );

  Future<void> initialize(BuildContext context) async {}

  void navigateToWalletCredentialExchange(String initialOffer)
  {
    navigationHandler.navigateToWalletCredentialExchange(initialOffer);
  }

  void navigateToSplash() {
    navigationHandler.navigateToSplash();
  }
}
