import 'package:freezed_annotation/freezed_annotation.dart';

part 'environment_select_state.freezed.dart';

@freezed
class EnvironmentSelectState with _$EnvironmentSelectState {
  factory EnvironmentSelectState({
    @Default(false) bool enableOauthToken,
    required String appVersion,
    @Default(true) bool debugLogEnabled,
    @Default(true) bool warnLogEnabled,
    @Default(true) bool infoLogEnabled,
    @Default(true) bool errorLogEnabled,
    @Default(false) bool disableCertificatePinning,
    @Default(false) bool mockLogin,
  }) = _EnvironmentSelectState;
}
