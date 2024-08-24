class BaseResponse {
  final bool isValid;

  final String message;

  BaseResponse({
    required this.isValid,
    required this.message,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      isValid: json['is_valid'] ?? true,
      message: json['message'] ?? '',
    );
  }
}
