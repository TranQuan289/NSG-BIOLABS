class EquipmentType {
  EquipmentType({
    this.id,
    this.name,
    this.position,
  });

  int? id;
  String? name;
  int? position;

  factory EquipmentType.fromJson(Map<String, dynamic> json) => EquipmentType(
        id: json['id'],
        name: json['name'],
        position: json['position'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'position': position,
      };
}