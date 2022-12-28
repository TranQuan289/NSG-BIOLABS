import 'package:domain/models/metadata.dart';

class APIResponse {
  APIResponse({
    this.metadata,
    this.message,
    this.code,
    this.status,
    this.data,
  });

  Metadata? metadata;
  String? message;
  int? code;
  bool? status;
  dynamic data;

  factory APIResponse.fromJson(Map<String, dynamic> json) {
    return APIResponse(
      metadata: json['metadata'] == null ? null : Metadata.fromJson(json['metadata']),
      message: json['message'],
      code: json['code'],
      status: json['status'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toObject() {
    return Map<String, dynamic>.from(data);
  }

  List<Map<String, dynamic>> toList() {
    return List<Map<String, dynamic>>.from(data);
  }

  List<Map<String, dynamic>> toItems() {
    return List<Map<String, dynamic>>.from(data['data']);
  }
}

// class Metadata {
//   Metadata({
//     this.totalCount,
//     this.totalPages,
//     this.nextPage,
//     this.prevPage,
//     this.currentPage,
//     this.currentPerPage,
//   });

//   int? totalCount;
//   int? totalPages;
//   int? nextPage;
//   int? prevPage;
//   int? currentPage;
//   int? currentPerPage;

//   factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
//         totalCount: json['total_count'],
//         totalPages: json['total_pages'],
//         nextPage: json['next_page'],
//         prevPage: json['prev_page'],
//         currentPage: json['current_page'],
//         currentPerPage: json['current_per_page'],
//       );
// }
