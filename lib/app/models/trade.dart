// To parse this JSON data, do
//
//     final tradeSchema = tradeSchemaFromJson(jsonString);

import 'dart:convert';

TradeSchema tradeSchemaFromJson(String str) => TradeSchema.fromJson(json.decode(str));

String tradeSchemaToJson(TradeSchema data) => json.encode(data.toJson());

class TradeSchema {
    final int? id;
    final String? businessName;
    final String? firstName;
    final String? lastName;
    final String? email;
    final String? address;
    final String? suburb;
    final String? city;
    final String? region;
    final Industry? industry;
    final List<Tag>? tags;
    final String? logo;
    final dynamic landline;
    final String? mobile;
    final int? rating;

    TradeSchema({
        this.id,
        this.businessName,
        this.firstName,
        this.lastName,
        this.email,
        this.address,
        this.suburb,
        this.city,
        this.region,
        this.industry,
        this.tags,
        this.logo,
        this.landline,
        this.mobile,
        this.rating,
    });

    factory TradeSchema.fromJson(Map<String, dynamic> json) => TradeSchema(
        id: json["id"],
        businessName: json["business_name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        address: json["address"],
        suburb: json["suburb"],
        city: json["city"],
        region: json["region"],
        industry: json["industry"] == null ? null : Industry.fromJson(json["industry"]),
        tags: json["tags"] == null ? [] : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
        logo: json["logo"],
        landline: json["landline"],
        mobile: json["mobile"],
        rating: json["rating"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "business_name": businessName,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "address": address,
        "suburb": suburb,
        "city": city,
        "region": region,
        "industry": industry?.toJson(),
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x.toJson())),
        "logo": logo,
        "landline": landline,
        "mobile": mobile,
        "rating": rating,
    };
}

class Industry {
    final int? id;
    final String? name;

    Industry({
        this.id,
        this.name,
    });

    factory Industry.fromJson(Map<String, dynamic> json) => Industry(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class Tag {
    final int? id;
    final String? name;
    final String? icon;

    Tag({
        this.id,
        this.name,
        this.icon,
    });

    factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
    };
}
