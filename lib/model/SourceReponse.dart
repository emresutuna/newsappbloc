// To parse this JSON data, do
//
//     final sourceResponse = sourceResponseFromJson(jsonString);

import 'dart:convert';

SourceResponse sourceResponseFromJson(String str) => SourceResponse.fromJson(json.decode(str));

String sourceResponseToJson(SourceResponse data) => json.encode(data.toJson());

class SourceResponse {
    SourceResponse({
        this.status,
        this.sources,
    });

    String status;
    List<Source> sources;

    factory SourceResponse.fromJson(Map<String, dynamic> json) => SourceResponse(
        status: json["status"],
        sources: List<Source>.from(json["sources"].map((x) => Source.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "sources": List<dynamic>.from(sources.map((x) => x.toJson())),
    };
}

class Source {
    Source({
        this.id,
        this.name,
        this.description,
        this.url,
        this.category,
        this.language,
        this.country,
    });

    String id;
    String name;
    String description;
    String url;
    String category;
    String language;
    String country;

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        url: json["url"],
        category: json["category"],
        language: json["language"],
        country: json["country"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "url": url,
        "category": category,
        "language": language,
        "country": country,
    };
}

enum Category { GENERAL, BUSINESS, TECHNOLOGY }

final categoryValues = EnumValues({
    "business": Category.BUSINESS,
    "general": Category.GENERAL,
    "technology": Category.TECHNOLOGY
});

enum Country { DE }

final countryValues = EnumValues({
    "de": Country.DE
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
