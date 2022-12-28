class DeleteBookingModel {
  String? message;
  List<String>? messages;
  int? code;
  bool? status;

  DeleteBookingModel({
    this.message,
    this.messages,
    this.code,
    this.status,
  });
  factory DeleteBookingModel.fromJson(Map<String, dynamic>? json) => DeleteBookingModel(
        message: json?['message'],
        messages: json?['messages'] ?? [],
        code: json?['code'],
        status: json?['status'],
      );
}
