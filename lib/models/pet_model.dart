// To parse this JSON data, do
//
//     final petModel = petModelFromJson(jsonString);

import 'dart:convert';

PetModel petModelFromJson(String str) => PetModel.fromJson(json.decode(str));

String petModelToJson(PetModel data) => json.encode(data.toJson());

class PetModel {
  int id;
  String userName;
  String petName;
  String petType;
  String gender;
  String location;
  String image;
  String createdAt;
  String updatedAt;

  PetModel({
    required this.id,
    required this.userName,
    required this.petName,
    required this.petType,
    required this.gender,
    required this.location,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  PetModel copyWith({
    int? id,
    String? userName,
    String? petName,
    String? petType,
    String? gender,
    String? location,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) =>
      PetModel(
        id: id ?? this.id,
        userName: userName ?? this.userName,
        petName: petName ?? this.petName,
        petType: petType ?? this.petType,
        gender: gender ?? this.gender,
        location: location ?? this.location,
        image: image ?? this.image,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory PetModel.fromJson(Map<String, dynamic> json) => PetModel(
        id: json["id"],
        userName: json["user_name"],
        petName: json["pet_name"],
        petType: json["pet_type"],
        gender: json["gender"],
        location: json["location"],
        image: json["image"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "pet_name": petName,
        "pet_type": petType,
        "gender": gender,
        "location": location,
        "image": image,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
