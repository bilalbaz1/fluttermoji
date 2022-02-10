import 'dart:convert';

SatinAlinanAvatarModel satinAlinanAvatarModelFromJson(String str) =>
    SatinAlinanAvatarModel.fromJson(json.decode(str));

String satinAlinanAvatarModelToJson(SatinAlinanAvatarModel data) =>
    json.encode(data.toJson());

class SatinAlinanAvatarModel {
  SatinAlinanAvatarModel({
    required this.resimYol,
  });

  String resimYol;

  factory SatinAlinanAvatarModel.fromJson(Map<String, dynamic> json) =>
      SatinAlinanAvatarModel(
        resimYol: json["resimYol"],
      );

  Map<String, dynamic> toJson() => {
        "resimYol": resimYol,
      };
}
