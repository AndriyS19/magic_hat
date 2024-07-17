part of 'quiz_bloc.dart';

@immutable
abstract class QuizEvent {
  const QuizEvent();
}

class LoadQuizData extends QuizEvent {
  const LoadQuizData();
}

class RestartQuiz extends QuizEvent {
  const RestartQuiz();
}

class RefreshCharacter extends QuizEvent {
  const RefreshCharacter();
}

class SelectCharacter extends QuizEvent {
  const SelectCharacter({
    required this.characterId,
    this.selectedHouse,
  });

  final String characterId;
  final String? selectedHouse;
}

class RestartCharacter extends QuizEvent {
  const RestartCharacter({
    required this.characterId,
  });

  final String characterId;
}
