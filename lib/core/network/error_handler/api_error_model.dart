class ApiErrorModel {
  final String message;

  ApiErrorModel({
    required this.message,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) => ApiErrorModel(
        message: json['message'],
      );
}
