class Site {
  Site({
    this.id,
    this.name,
    this.colorTag,
    this.level,
    this.status,
  });

  int? id;
  String? name;
  String? colorTag;
  int? level;
  bool? status;

  factory Site.fromJson(Map<String, dynamic> json) => Site(
        id: json['id'],
        name: json['name'],
        colorTag: json['color_tag'],
        level: json['level'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'color_tag': colorTag,
        'level': level,
      };
}
