import 'dart:io';
import 'package:magic_hat/models/character_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalDB {
  const LocalDB._();

  static const LocalDB instance = LocalDB._();

  static const String _privateColumnId = '_id';
  static const String _autoincrementType = 'INTEGER PRIMARY KEY AUTOINCREMENT';

  static const String _intNullableType = 'INTEGER';
  static const String _intNotNullType = 'INTEGER NOT NULL';
  static const String _stringNullableType = 'TEXT';
  static const String _stringNotNullType = 'TEXT NOT NULL';

  static Database? _charactersDatabase;

  // [START] Init data

  Future<void> ensureInitialized() async {
    await _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    final Directory folderDirectory = await getApplicationDocumentsDirectory();

    final String folderPath = join(
      folderDirectory.path,
      'local_database',
    );

    final Directory directory = Directory(folderPath);

    await directory.create(
      recursive: true,
    );

    await _createAndOpenCharactersTables(
      folderPath: folderPath,
    );
  }

  Future<void> _createAndOpenCharactersTables({
    required String folderPath,
  }) async {
    _charactersDatabase = await openDatabase(
      '$folderPath/characters.db',
      version: 1,
      onCreate: (Database database, _) async {
        await database.execute(
          '''
            CREATE TABLE $characterModelName ( 
              $_privateColumnId $_autoincrementType,            
              ${CharacterModelFields.id.name} $_stringNotNullType,
              ${CharacterModelFields.name.name} $_stringNotNullType,
              ${CharacterModelFields.alternateNames.name} $_stringNullableType,
              ${CharacterModelFields.species.name} $_stringNotNullType,
              ${CharacterModelFields.gender.name} $_stringNotNullType,
              ${CharacterModelFields.house.name} $_stringNullableType,
              ${CharacterModelFields.dateOfBirth.name} $_stringNullableType,
              ${CharacterModelFields.yearOfBirth.name} $_intNullableType,
              ${CharacterModelFields.wizard.name} $_intNotNullType,
              ${CharacterModelFields.ancestry.name} $_stringNullableType,
              ${CharacterModelFields.eyeColor.name} $_stringNullableType,
              ${CharacterModelFields.hairColor.name} $_stringNullableType,
              ${CharacterModelFields.wand.name} $_stringNullableType,
              ${CharacterModelFields.patronus.name} $_stringNullableType,
              ${CharacterModelFields.hogwartsStudent.name} $_intNotNullType,
              ${CharacterModelFields.hogwartsStaff.name} $_intNotNullType,
              ${CharacterModelFields.actor.name} $_stringNullableType,
              ${CharacterModelFields.alternateActors.name} $_stringNullableType,
              ${CharacterModelFields.alive.name} $_intNotNullType,
              ${CharacterModelFields.image.name} $_stringNullableType,
              ${CharacterModelFields.attempts.name} $_intNullableType,
              ${CharacterModelFields.isSuccess.name} $_intNullableType
            )
          ''',
        );
      },
    );
  }

  Future<void> saveCharacters({
    required List<CharacterModel> characters,
  }) async {
    final Batch batch = _charactersDatabase!.batch();

    for (int i = 0; i < characters.length; i++) {
      batch.insert(
        characterModelName,
        characters[i].toJson(),
      );
    }

    await batch.commit(
      noResult: true,
    );
  }

  Future<List<CharacterModel>?> getCharacters() async {
    final List<Map<String, dynamic>> response = await _charactersDatabase!.query(
      characterModelName,
    );

    if (response.isNotEmpty) {
      final List<CharacterModel> characters = [];

      for (int i = 0; i < response.length; i++) {
        characters.add(
          CharacterModel.fromJsonDatabase(
            response[i],
          ),
        );
      }

      return characters;
    }

    return null;
  }

  Future<void> updateCharacters({
    required String characterId,
    required CharacterModel character,
  }) async {
    await _charactersDatabase!.update(
      characterModelName,
      character.toJson(),
      where: '${CharacterModelFields.id.name} = ?',
      whereArgs: [characterId],
    );
  }

  Future<void> deleteAllHistoryData() async {
    await _charactersDatabase!.delete(
      characterModelName,
    );
  }
}
