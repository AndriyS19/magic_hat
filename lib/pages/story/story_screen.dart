import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_hat/bloc/quiz_bloc.dart';
import 'package:magic_hat/models/character_model.dart';
import 'package:magic_hat/pages/characters_info_page/characters_info_page.dart';
import 'package:magic_hat/utils/constants.dart';
import 'package:magic_hat/utils/enums.dart';
import 'package:magic_hat/utils/helpers.dart';
import 'package:magic_hat/widgets/app_bar.dart';
import 'package:magic_hat/widgets/user_score.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  void _restartQuiz() {
    context.read<QuizBloc>().add(
          const RestartQuiz(),
        );
  }

  void _restartCharacter(String characterId) {
    context.read<QuizBloc>().add(
          RestartCharacter(
            characterId: characterId,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'List Screen',
        onAction: _restartQuiz,
      ),
      body: BlocBuilder<QuizBloc, QuizState>(
        builder: (_, state) {
          if (state.status == BlocStatus.success) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 16,
                  ),
                  child: UserScoreWidget(
                    correctAnswer: state.successAttempts,
                    wrongAnswer: state.failedAttempts,
                  ),
                ),
                ChatsContent(
                  characters: sortCharacters(
                    characters: state.characters,
                  ),
                  onRestart: _restartCharacter,
                  onTap: (CharacterModel character) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharactersInfoPage(
                          character: character,
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }

          return const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
              strokeWidth: 4,
            ),
          );
        },
      ),
    );
  }
}

class ChatsContent extends StatelessWidget {
  const ChatsContent({
    super.key,
    required this.characters,
    required this.onRestart,
    required this.onTap,
  });

  final List<CharacterModel> characters;
  final void Function(String) onRestart;
  final void Function(CharacterModel) onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: characters.length,
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 16.0,
        ),
        itemBuilder: (_, int i) {
          return GestureDetector(
            onTap: () {
              onTap(
                characters[i],
              );
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              height: 65.0,
              margin: EdgeInsets.only(
                bottom: i != characters.length - 1 ? 12.0 : 0.0,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 40.0,
                    height: double.infinity,
                    child: characters[i].image != null
                        ? CachedNetworkImage(
                            imageUrl: characters[i].image ?? '',
                            fit: BoxFit.cover,
                            progressIndicatorBuilder: (_, __, progress) {
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    value: progress.progress,
                                    strokeWidth: 3.0,
                                  ),
                                ],
                              );
                            },
                          )
                        : Image.asset(AppImages.unknownUser),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          characters[i].name,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                        ),
                        Text(
                          'Attempts: ${characters[i].attempts}',
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      characters[i].isSuccess == true
                          ? const Icon(
                              Icons.task_alt_rounded,
                              color: Colors.green,
                            )
                          : Row(
                              children: [
                                GestureDetector(
                                  onTap: () => onRestart(characters[i].id),
                                  behavior: HitTestBehavior.opaque,
                                  child: const Icon(
                                    Icons.restart_alt_rounded,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 12.0),
                                const Icon(
                                  Icons.warning_rounded,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
