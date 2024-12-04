class AuthModel {
  final String email;

  AuthModel({required this.email});

  /// Verifica si el email tiene un formato válido.
  bool isValid() {
    final emailRegex = RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+$");
    return emailRegex.hasMatch(email);
  }

  /// Convierte el modelo a un formato JSON.
  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }

  /// Crea un modelo a partir de un objeto JSON.
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      email: json['email'],
    );
  }
}
