part of 'quiz_bloc.dart';

@immutable
class QuizState {
  const QuizState({
    this.status = BlocStatus.initial,
    this.successAttempts = 0,
    this.failedAttempts = 0,
    this.character,
    this.characters = const [],
  });

  final BlocStatus status;
  final int successAttempts;
  final int failedAttempts;
  final CharacterModel? character;
  final List<CharacterModel> characters;

  QuizState copyWith({
    BlocStatus? status,
    int? successAttempts,
    int? failedAttempts,
    CharacterModel? character,
    List<CharacterModel>? characters,
  }) {
    return QuizState(
      status: status ?? this.status,
      successAttempts: successAttempts ?? this.successAttempts,
      failedAttempts: failedAttempts ?? this.failedAttempts,
      character: character ?? this.character,
      characters: characters ?? this.characters,
    );
  }
}
