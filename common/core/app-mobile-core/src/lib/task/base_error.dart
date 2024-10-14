class BaseError {
  final String errorCode;
  final String message;
  final String? messageEN;
  final String? messageAR;
  final String? traceId;
  final int? statusCode;
  final String? request;
  final String? response;
  final String? reference;

  const BaseError({
    required this.errorCode,
    required this.message,
    this.messageEN,
    this.messageAR,
    this.traceId,
    this.statusCode = 0,
    this.request,
    this.response,
    this.reference,
  });
}
