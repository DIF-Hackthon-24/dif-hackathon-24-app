class WalletCredentialsOfferRequestState {
  String  getCredentialsOfferRequestData;

  WalletCredentialsOfferRequestState({
    this.getCredentialsOfferRequestData = "",
  });

  WalletCredentialsOfferRequestState copyWith({
    String?  getCredentialsOfferRequestDataCopy
  }) {
    return WalletCredentialsOfferRequestState(
      getCredentialsOfferRequestData: getCredentialsOfferRequestDataCopy ?? getCredentialsOfferRequestData,
    );
  }
}