import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_hat/database/local_database.dart';
import 'package:magic_hat/models/character_model.dart';
import 'package:magic_hat/models/isolate_model.dart';
import 'package:magic_hat/repositories/characters_repository.dart';
import 'package:magic_hat/utils/enums.dart';
import 'package:magic_hat/utils/helpers.dart';
import 'package:magic_hat/utils/in_app_notification_service.dart';

part 'quiz_event.dart';

part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc({
    required this.localDB,
    required this.charactersRepository,
    required this.isolateToken,
  }) : super(const QuizState()) {
    on<LoadQuizData>((event, emit) async {
      emit(
        state.copyWith(
          status: BlocStatus.loading,
        ),
      );

      final List<CharacterModel> characters = [];

      final List<CharacterModel>? savedCharacters = await localDB.getCharacters();

      if (savedCharacters != null) {
        characters.addAll(
          savedCharacters,
        );
      } else {
        final List<CharacterModel>? loadedCharacters = await compute(
          charactersRepository.loadCharacters,
          IsolateModel(
            token: isolateToken,
          ),
        );

        if (loadedCharacters != null) {
          await localDB.saveCharacters(
            characters: loadedCharacters,
          );

          characters.addAll(
            loadedCharacters,
          );
        }
      }

      final CharacterModel character = randomCharacter(
        characters: characters,
      );

      emit(
        state.copyWith(
          status: BlocStatus.loaded,
          character: character,
          characters: characters,
        ),
      );

      final int successAttempts = characters.fold(0, (p, e) => e.isSuccess == true ? p + 1 : p);

      final int failedAttempts = characters.fold(0, (p, e) => e.isSuccess == false ? p + 1 : p);

      if (characters.isNotEmpty) {
        emit(
          state.copyWith(
            status: BlocStatus.success,
            successAttempts: successAttempts,
            failedAttempts: failedAttempts,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: BlocStatus.failed,
          ),
        );
      }
    });

    on<RestartQuiz>((event, emit) async {
      emit(
        state.copyWith(
          status: BlocStatus.loading,
        ),
      );

      await localDB.deleteAllHistoryData();

      final List<CharacterModel> characters = [];

      final List<CharacterModel>? loadedCharacters = await compute(
        charactersRepository.loadCharacters,
        IsolateModel(
          token: isolateToken,
        ),
      );

      if (loadedCharacters != null) {
        await localDB.saveCharacters(
          characters: loadedCharacters,
        );

        characters.addAll(
          loadedCharacters,
        );
      }

      final CharacterModel character = randomCharacter(
        characters: characters,
      );

      emit(
        state.copyWith(
          status: BlocStatus.loaded,
          character: character,
          characters: characters,
        ),
      );

      if (characters.isNotEmpty) {
        InAppNotificationService.show(
          title: 'Quiz restarted',
        );

        emit(
          state.copyWith(
            status: BlocStatus.success,
            successAttempts: 0,
            failedAttempts: 0,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: BlocStatus.failed,
          ),
        );
      }
    });

    on<RefreshCharacter>((event, emit) async {
      final CharacterModel character = randomCharacter(
        characters: state.characters,
      );

      InAppNotificationService.show(
        title: 'Character refreshed',
      );

      emit(
        state.copyWith(
          character: character,
        ),
      );
    });

    on<SelectCharacter>((event, emit) async {
      final List<CharacterModel> characters = [...state.characters];

      final remainingAttempts = characters.fold(0, (p, e) => e.isSuccess == null ? p + 1 : p);

      if (remainingAttempts > 1) {
        final int index = characters.indexWhere(
          (e) => e.id == event.characterId,
        );

        if (index == -1) return;

        CharacterModel selectedCharacter;

        final int attempts = characters[index].attempts == null ? 1 : characters[index].attempts! + 1;

        final bool isInHouse = characters[index].house == event.selectedHouse;

        if (isInHouse) {
          selectedCharacter = characters[index].copyWith(
            attempts: attempts,
            isSuccess: true,
          );
        } else {
          selectedCharacter = characters[index].copyWith(
            attempts: attempts,
            isSuccess: false,
          );
        }

        await localDB.updateCharacters(
          characterId: selectedCharacter.id,
          character: selectedCharacter,
        );

        characters[index] = selectedCharacter;

        final CharacterModel newCharacter = randomCharacter(
          characters: characters,
        );

        emit(
          state.copyWith(
            successAttempts: isInHouse ? state.successAttempts + 1 : state.successAttempts,
            failedAttempts: !isInHouse ? state.failedAttempts + 1 : state.failedAttempts,
            character: newCharacter,
            characters: characters,
          ),
        );
      } else {
        add(
          const RestartQuiz(),
        );
      }
    });

    on<RestartCharacter>((event, emit) async {
      final List<CharacterModel> characters = [...state.characters];

      final int index = characters.indexWhere(
        (e) => e.id == event.characterId,
      );

      if (index == -1) return;

      final CharacterModel character = characters[index].copyWithNull(
        attempts: characters[index].attempts,
        isSuccess: null,
      );

      await localDB.updateCharacters(
        characterId: character.id,
        character: character,
      );

      characters[index] = character;

      emit(
        state.copyWith(
          characters: characters,
        ),
      );
    });
  }

  final LocalDB localDB;
  final CharactersRepository charactersRepository;
  final RootIsolateToken isolateToken;
}
