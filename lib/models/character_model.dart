import 'package:magic_hat/utils/helpers.dart';

enum CharacterModelFields {
  id,
  name,
  alternateNames,
  species,
  gender,

  house,
  dateOfBirth,
  yearOfBirth,
  wizard,
  ancestry,
  eyeColor,
  hairColor,
  wand,
  patronus,
  hogwartsStudent,
  hogwartsStaff,
  actor,
  alternateActors,
  alive,
  image,
  attempts,
  isSuccess,
}

const String characterModelName = 'CharacterModel';

class CharacterModel {
  const CharacterModel({
    required this.id,
    required this.name,
    this.alternateNames,
    required this.species,
    required this.gender,
    this.house,
    this.dateOfBirth,
    this.yearOfBirth,
    required this.wizard,
    this.ancestry,
    this.eyeColour,
    this.hairColour,
    this.wand,
    this.patronus,
    required this.hogwartsStudent,
    required this.hogwartsStaff,
    this.actor,
    this.alternateActors,
    required this.alive,
    this.image,
    this.attempts,
    this.isSuccess,
  });

  factory CharacterModel.fromJsonApi(Map<String, dynamic> json) {
    final String? alternateNames =
        (json['alternate_names'] as List).isNotEmpty ? (json['alternate_names'] as List).join(', ') : null;

    final String? alternateActors =
        (json['alternate_actors'] as List).isNotEmpty ? (json['alternate_actors'] as List).join(', ') : null;

    final String? wand = convertWand(
      data: json['wand'],
    );

    return CharacterModel(
      id: json['id'],
      name: json['name'],
      alternateNames: alternateNames,
      species: json['species'],
      gender: json['gender'],
      house: (json['house'] as String).isNotEmpty ? json['house'] : null,
      dateOfBirth: json['dateOfBirth'],
      yearOfBirth: json['yearOfBirth'],
      wizard: json['wizard'],
      ancestry: (json['ancestry'] as String).isNotEmpty ? json['ancestry'] : null,
      eyeColour: (json['eyeColour'] as String).isNotEmpty ? json['eyeColour'] : null,
      hairColour: (json['hairColour'] as String).isNotEmpty ? json['hairColour'] : null,
      wand: wand,
      patronus: (json['patronus'] as String).isNotEmpty ? json['patronus'] : null,
      hogwartsStudent: json['hogwartsStudent'],
      hogwartsStaff: json['hogwartsStaff'],
      actor: (json['actor'] as String).isNotEmpty ? json['actor'] : null,
      alternateActors: alternateActors,
      alive: json['alive'],
      image: (json['image'] as String).isNotEmpty ? json['image'] : null,
    );
  }

  factory CharacterModel.fromJsonDatabase(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      alternateNames: json['alternateNames'],
      species: json['species'],
      gender: json['gender'],
      house: json['house'],
      dateOfBirth: json['dateOfBirth'],
      yearOfBirth: json['yearOfBirth'],
      wizard: json['wizard'] == 1 ? true : false,
      ancestry: json['ancestry'],
      eyeColour: json['eyeColour'],
      hairColour: json['hairColour'],
      wand: json['wand'],
      patronus: json['patronus'],
      hogwartsStudent: json['hogwartsStudent'] == 1 ? true : false,
      hogwartsStaff: json['hogwartsStaff'] == 1 ? true : false,
      actor: json['actor'],
      alternateActors: json['alternateActors'],
      alive: json['alive'] == 1 ? true : false,
      image: json['image'],
      attempts: json['attempts'],
      isSuccess: json['isSuccess'] != null
          ? json['isSuccess'] == 1
              ? true
              : false
          : null,
    );
  }

  final String id;
  final String name;
  final String? alternateNames;
  final String species;
  final String gender;
  final String? house;
  final String? dateOfBirth;
  final int? yearOfBirth;
  final bool wizard;
  final String? ancestry;
  final String? eyeColour;
  final String? hairColour;
  final String? wand;
  final String? patronus;
  final bool hogwartsStudent;
  final bool hogwartsStaff;
  final String? actor;
  final String? alternateActors;
  final bool alive;
  final String? image;
  final int? attempts;
  final bool? isSuccess;

  CharacterModel copyWith({
    String? id,
    String? name,
    String? alternateNames,
    String? species,
    String? gender,
    String? house,
    String? dateOfBirth,
    int? yearOfBirth,
    bool? wizard,
    String? ancestry,
    String? eyeColour,
    String? hairColour,
    String? wand,
    String? patronus,
    bool? hogwartsStudent,
    bool? hogwartsStaff,
    String? actor,
    String? alternateActors,
    bool? alive,
    String? image,
    int? attempts,
    bool? isSuccess,
  }) {
    return CharacterModel(
      id: id ?? this.id,
      name: name ?? this.name,
      alternateNames: alternateNames ?? this.alternateNames,
      species: species ?? this.species,
      gender: gender ?? this.gender,
      house: house ?? this.house,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      yearOfBirth: yearOfBirth ?? this.yearOfBirth,
      wizard: wizard ?? this.wizard,
      ancestry: ancestry ?? this.ancestry,
      eyeColour: eyeColour ?? this.eyeColour,
      hairColour: hairColour ?? this.hairColour,
      wand: wand ?? this.wand,
      patronus: patronus ?? this.patronus,
      hogwartsStudent: hogwartsStudent ?? this.hogwartsStudent,
      hogwartsStaff: hogwartsStaff ?? this.hogwartsStaff,
      actor: actor ?? this.actor,
      alternateActors: alternateActors ?? this.alternateActors,
      alive: alive ?? this.alive,
      image: image ?? this.image,
      attempts: attempts ?? this.attempts,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  CharacterModel copyWithNull({
    String? id,
    String? name,
    String? alternateNames,
    String? species,
    String? gender,
    String? house,
    String? dateOfBirth,
    int? yearOfBirth,
    bool? wizard,
    String? ancestry,
    String? eyeColour,
    String? hairColour,
    String? wand,
    String? patronus,
    bool? hogwartsStudent,
    bool? hogwartsStaff,
    String? actor,
    String? alternateActors,
    bool? alive,
    String? image,
    required int? attempts,
    required bool? isSuccess,
  }) {
    return CharacterModel(
      id: id ?? this.id,
      name: name ?? this.name,
      alternateNames: alternateNames ?? this.alternateNames,
      species: species ?? this.species,
      gender: gender ?? this.gender,
      house: house ?? this.house,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      yearOfBirth: yearOfBirth ?? this.yearOfBirth,
      wizard: wizard ?? this.wizard,
      ancestry: ancestry ?? this.ancestry,
      eyeColour: eyeColour ?? this.eyeColour,
      hairColour: hairColour ?? this.hairColour,
      wand: wand ?? this.wand,
      patronus: patronus ?? this.patronus,
      hogwartsStudent: hogwartsStudent ?? this.hogwartsStudent,
      hogwartsStaff: hogwartsStaff ?? this.hogwartsStaff,
      actor: actor ?? this.actor,
      alternateActors: alternateActors ?? this.alternateActors,
      alive: alive ?? this.alive,
      image: image ?? this.image,
      attempts: attempts,
      isSuccess: isSuccess,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'alternateNames': alternateNames,
        'species': species,
        'gender': gender,
        'house': house,
        'dateOfBirth': dateOfBirth,
        'yearOfBirth': yearOfBirth,
        'wizard': wizard == true ? 1 : 0,
        'ancestry': ancestry,
        'eyeColour': eyeColour,
        'hairColour': hairColour,
        'wand': wand,
        'patronus': patronus,
        'hogwartsStudent': hogwartsStudent == true ? 1 : 0,
        'hogwartsStaff': hogwartsStaff == true ? 1 : 0,
        'actor': actor,
        'alternateActors': alternateActors,
        'alive': alive == true ? 1 : 0,
        'image': image,
        'attempts': attempts,
        'isSuccess': isSuccess != null
            ? isSuccess == true
                ? 1
                : 0
            : null,
      };
}
