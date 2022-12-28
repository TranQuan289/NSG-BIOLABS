class Metadata {
  Metadata({
    this.totalCount,
    this.totalPages,
    this.nextPage,
    this.prevPage,
    this.currentPage,
    this.currentPerPage,
  });

  int? totalCount;
  int? totalPages;
  int? nextPage;
  int? prevPage;
  int? currentPage;
  int? currentPerPage;

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        totalCount: json['total_count'],
        totalPages: json['total_pages'],
        nextPage: json['next_page'],
        prevPage: json['prev_page'],
        currentPage: json['current_page'],
        currentPerPage: json['current_per_page'],
      );

  Map<String, dynamic> toJson() => {
        'total_count': totalCount,
        'total_pages': totalPages,
        'next_page': nextPage,
        'prev_page': prevPage,
        'current_page': currentPage,
        'current_per_page': currentPerPage,
      };
}