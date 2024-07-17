import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_hat/bloc/quiz_bloc.dart';
import 'package:magic_hat/utils/constants.dart';
import 'package:magic_hat/utils/enums.dart';
import 'package:magic_hat/widgets/app_bar.dart';
import 'package:magic_hat/widgets/houses_grid.dart';
import 'package:magic_hat/widgets/user_score.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _restartQuiz() {
    context.read<QuizBloc>().add(
          const RestartQuiz(),
        );
  }

  void _refreshCharacter() {
    context.read<QuizBloc>().add(
          const RefreshCharacter(),
        );
  }

  void _selectCharacter({
    required String characterId,
    String? selectedHouse,
  }) {
    context.read<QuizBloc>().add(
          SelectCharacter(
            characterId: characterId,
            selectedHouse: selectedHouse,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Home Screen',
        onAction: _restartQuiz,
      ),
      body: BlocBuilder<QuizBloc, QuizState>(
        builder: (_, state) {
          if (state.status == BlocStatus.success) {
            return RefreshIndicator(
              onRefresh: () async => _refreshCharacter(),
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 12.0,
                ),
                children: [
                  UserScoreWidget(
                    correctAnswer: state.successAttempts,
                    wrongAnswer: state.failedAttempts,
                  ),
                  const SizedBox(height: 20.0),
                  Column(
                    children: [
                      SizedBox(
                        width: 144.0,
                        height: 200.0,
                        child: state.character?.image != null
                            ? CachedNetworkImage(
                                imageUrl: state.character?.image ?? '',
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
                      const SizedBox(height: 20.0),
                      Text(
                        state.character!.name,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  HouseGrid(
                    onTap: (String? house) => _selectCharacter(
                      characterId: state.character!.id,
                      selectedHouse: house,
                    ),
                  ),
                ],
              ),
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
