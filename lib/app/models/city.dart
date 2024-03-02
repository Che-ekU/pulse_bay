// To parse this JSON data, do
//
//     final citySchema = citySchemaFromJson(jsonString);

import 'dart:convert';

CitySchema citySchemaFromJson(String str) => CitySchema.fromJson(json.decode(str));

String citySchemaToJson(CitySchema data) => json.encode(data.toJson());

class CitySchema {
    final int? id;
    final String? name;
    final int? countryId;
    final List<City>? cities;

    CitySchema({
        this.id,
        this.name,
        this.countryId,
        this.cities,
    });

    factory CitySchema.fromJson(Map<String, dynamic> json) => CitySchema(
        id: json["id"],
        name: json["name"],
        countryId: json["country_id"],
        cities: json["cities"] == null ? [] : List<City>.from(json["cities"]!.map((x) => City.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_id": countryId,
        "cities": cities == null ? [] : List<dynamic>.from(cities!.map((x) => x.toJson())),
    };
}

class City {
    final int? id;
    final String? name;
    final int? regionId;
    final List<Suburb>? suburbs;

    City({
        this.id,
        this.name,
        this.regionId,
        this.suburbs,
    });

    factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        regionId: json["region_id"],
        suburbs: json["suburbs"] == null ? [] : List<Suburb>.from(json["suburbs"]!.map((x) => Suburb.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "region_id": regionId,
        "suburbs": suburbs == null ? [] : List<dynamic>.from(suburbs!.map((x) => x.toJson())),
    };
}

class Suburb {
    final int? id;
    final String? name;
    final int? cityId;

    Suburb({
        this.id,
        this.name,
        this.cityId,
    });

    factory Suburb.fromJson(Map<String, dynamic> json) => Suburb(
        id: json["id"],
        name: json["name"],
        cityId: json["city_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "city_id": cityId,
    };
}
