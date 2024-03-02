// To parse this JSON data, do
//
//     final industrySchema = industrySchemaFromJson(jsonString);

import 'dart:convert';

IndustrySchema industrySchemaFromJson(String str) => IndustrySchema.fromJson(json.decode(str));

String industrySchemaToJson(IndustrySchema data) => json.encode(data.toJson());

class IndustrySchema {
    final int? id;
    final String? name;
    final String? icon;
    final String? description;
    final List<Tag>? tags;

    IndustrySchema({
        this.id,
        this.name,
        this.icon,
        this.description,
        this.tags,
    });

    factory IndustrySchema.fromJson(Map<String, dynamic> json) => IndustrySchema(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
        description: json["description"],
        tags: json["tags"] == null ? [] : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
        "description": description,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x.toJson())),
    };
}

class Tag {
    final int? tagId;
    final String? tagName;

    Tag({
        this.tagId,
        this.tagName,
    });

    factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        tagId: json["tag_id"],
        tagName: json["tag_name"],
    );

    Map<String, dynamic> toJson() => {
        "tag_id": tagId,
        "tag_name": tagName,
    };
}
