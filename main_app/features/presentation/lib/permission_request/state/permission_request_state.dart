// permission_request_state.dart
class PermissionRequestState {
  String  getPermissionRequestData;

  PermissionRequestState({
    this.getPermissionRequestData = "",
  });

  PermissionRequestState copyWith({
    String?  getPermissionRequestDataCopy
  }) {
    return PermissionRequestState(
      getPermissionRequestData: getPermissionRequestDataCopy ?? getPermissionRequestData,
    );
  }
}