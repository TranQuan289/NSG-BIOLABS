import '../site.dart';

class FilterModel {
  FilterModel({
    this.levels,
    this.sites,
  });

  List<int>? levels;
  List<Site>? sites;

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
        levels: json['levels'] == null ? [] : List<int>.from(json['levels'].map((x) => x)),
        sites: json['sites'] == null
            ? []
            : List<Site>.from(json['sites'].map((x) => Site.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'levels': List<dynamic>.from(levels!.map((x) => x)),
        'sites': List<dynamic>.from(sites!.map((x) => x.toJson())),
      };
}
