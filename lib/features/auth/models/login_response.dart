class LoginResponse {
  final String message;
  final String token;
  final String role;

  LoginResponse({
    required this.message,
    required this.token,
    required this.role,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'] as String? ?? '',
      token:   json['token']   as String? ?? '',
      role:    json['role']    as String? ?? '',
    );
  }
}
