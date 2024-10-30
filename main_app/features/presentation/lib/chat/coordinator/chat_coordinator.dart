import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core/base_classes/base_coordinator.dart';
import 'package:core/logging/logger.dart';
import 'package:domain/usecase/wallet_credentials_list/i_wallet_credentials_list_use_case.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presentation/chat/navigation_handler/chat_navigation_handler.dart';
import 'package:presentation/chat/state/chat_state.dart';
import 'package:security_suit/security_suit.dart';
import 'package:shared_dependencies/data_providers/language_data_provider.dart';

class ChatCoordinator extends BaseCoordinator<ChatViewState> {
  // final ILanguageDataProvider languageDataProvider;
  final ChatNavigationHandler navigationHandler;
  StreamSubscription? networkSubscription;
  // final IWalletCredentialsListUseCase getWalletCredentialsListUseCase;
  // Map<String, dynamic> content = {};


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