import 'package:core/logging/logger.dart';
import 'package:core/translation/i_app_localization_service.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
//import 'package:local_auth_ios/local_auth_ios.dart';

class BiometricsAuth {
  final LocalAuthentication _auth = LocalAuthentication();
  final IAppLocalizationService _appLocalizationService;

  BiometricsAuth(this._appLocalizationService);

  Future<bool> authenticate() async {
    try {
      final availableBiometrics = await _auth.getAvailableBiometrics();

      if (availableBiometrics.isEmpty) {
        PSLogger.logError('No Biometrics Available');
        return false;
      }
      final biometricsAuthReason = _getPlatformMessages('biometrics_auth_reason');
      if (biometricsAuthReason == null) {
        throw Exception('Please specify "biometrics_auth_reason" in "assets/lang/');
      }
      final authenticated = await _auth.authenticate(
        localizedReason: biometricsAuthReason,
        authMessages: [
          AndroidAuthMessages(
            signInTitle: _getPlatformMessages('android_sign_in_title'),
            cancelButton: _getPlatformMessages('cancel_button'),
            goToSettingsButton: _getPlatformMessages('go_to_settings_button'),
            goToSettingsDescription: _getPlatformMessages('go_to_settings_description'),
            biometricHint: _getPlatformMessages('android_biometric_hint'),
            biometricNotRecognized: _getPlatformMessages('android_biometric_not_recognized'),
            biometricRequiredTitle: _getPlatformMessages('android_biometric_required_title'),
            biometricSuccess: _getPlatformMessages('android_biometric_success'),
            deviceCredentialsRequiredTitle: _getPlatformMessages('android_device_credentials_required_title'),
            deviceCredentialsSetupDescription: _getPlatformMessages('android_device_credentials_setup_description'),
          ),
          // IOSAuthMessages(
          //   cancelButton: _getPlatformMessages('cancel_button'),
          //   goToSettingsButton: _getPlatformMessages('go_to_settings_button'),
          //   goToSettingsDescription: _getPlatformMessages('go_to_settings_description'),
          //   localizedFallbackTitle: _getPlatformMessages('ios_localized_fallback_title'),
          //   lockOut: _getPlatformMessages('ios_lockout'),
          // ),
        ],
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      return authenticated;
    } on PlatformException catch (e) {
      PSLogger.logError('Biometrics Platform Exception $e');
      return false;
    }
  }

  Future<void> cancelAuthentication() async {
    await _auth.stopAuthentication();
  }

  String? _getPlatformMessages(String localisedKey) {
    final localisedValue = _appLocalizationService.getValue(localisedKey);
    if (localisedKey == localisedValue) {
      return null;
    } else {
      return localisedValue;
    }
  }
}
