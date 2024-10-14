
import 'package:domain/entity/wallet_credentials_list/wallet_credentials_list_entity.dart';

class SplashViewState {
  bool startAnimation;
  bool isLoading;
  int? loadingValue;
  bool noInternet;
  bool hasConfigFetchFailed;
  bool hasSyncApiFailed;
  bool isDownloadFailed;
  bool showDownloadFailedDetails;
  bool showDownloadFailed;
  bool haveMovedToNextScreen;
  bool isForceUpgradeRequired;
  bool isForceUpgradeSkipped;
  int failedImages;
  int failedVideos;
  List<WalletCredentialListEntity>? walletCredentialList;

  SplashViewState({
    this.startAnimation = false,
    this.isLoading = false,
    this.loadingValue,
    this.noInternet = false,
    this.hasConfigFetchFailed = false,
    this.hasSyncApiFailed = false,
    this.isDownloadFailed = false,
    this.showDownloadFailed = false,
    this.showDownloadFailedDetails = false,
    this.haveMovedToNextScreen = false,
    this.isForceUpgradeRequired = false,
    this.isForceUpgradeSkipped = false,
    this.failedImages = 0,
    this.failedVideos = 0,
   this.walletCredentialList,
  });

  SplashViewState copyWith({
    int? loadingValue,
    int? failedImages,
    int? failedVideos,
    bool? isLoading,
    bool? startAnimation,
    bool? noInternet,
    bool? hasConfigFetchFailed,
    bool? hasSyncApiFailed,
    bool? isDownloadFailed,
    bool? haveMovedToNextScreen,
    bool? isForceUpgradeRequired,
    bool? isForceUpgradeSkipped,
    bool? showDownloadFailed,
    bool? showDownloadFailedDetails,
    List<WalletCredentialListEntity>? walletCredentialList,
  }) {
    return SplashViewState(
      isForceUpgradeRequired:
      isForceUpgradeRequired ?? this.isForceUpgradeRequired,
      isForceUpgradeSkipped:
      isForceUpgradeSkipped ?? this.isForceUpgradeSkipped,
      loadingValue: loadingValue ?? this.loadingValue,
      isLoading: isLoading ?? this.isLoading,
      startAnimation: startAnimation ?? this.startAnimation,
      haveMovedToNextScreen: haveMovedToNextScreen ?? this.haveMovedToNextScreen,
      noInternet: noInternet ?? this.noInternet,
      hasConfigFetchFailed: hasConfigFetchFailed ?? this.hasConfigFetchFailed,
      hasSyncApiFailed: hasSyncApiFailed ?? this.hasSyncApiFailed,
      isDownloadFailed: isDownloadFailed ?? this.isDownloadFailed,
      failedImages: failedImages ?? this.failedImages,
      failedVideos: failedVideos ?? this.failedVideos,
      showDownloadFailed: showDownloadFailed ?? this.showDownloadFailed,
      showDownloadFailedDetails: showDownloadFailedDetails ?? this.showDownloadFailedDetails,
      walletCredentialList: walletCredentialList,
    );
  }
}
