import 'dart:math';

import 'package:magic_hat/models/character_model.dart';


String? convertWand({
  required Map<String, dynamic> data,
}) {
  String wand = '';

  data.forEach((key, value) {
    if (value is String) {
      if (value.isNotEmpty) {
        wand = '$wand\n$key: $value';
      }
    } else {
      if (value != null) {
        wand = '$wand\n$key: $value';
      }
    }
  });

  final String result = wand.trim();

  if (result.isNotEmpty) {
    return result;
  }

  return null;
}

CharacterModel randomCharacter({
  required List<CharacterModel> characters,
}) {
  final List<CharacterModel> validCharacters =
      characters.where((e) => e.isSuccess == null).toList();

  final int index = randomNumber(
    validCharacters.length,
  );

  final CharacterModel character = validCharacters[index];

  return character;
}

int randomNumber(int max) {
  final DateTime now = DateTime.now();
  final Random random = Random(now.millisecondsSinceEpoch);

  return random.nextInt(max);
}

List<CharacterModel> sortCharacters({
  required List<CharacterModel> characters,
}) {
  final List<CharacterModel> validCharacters =
      characters.where((e) => e.isSuccess != null).toList();

  validCharacters.sort((a, b) => b.isSuccess == true ? 1 : -1);

  return validCharacters;
}
