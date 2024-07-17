import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:magic_hat/models/character_model.dart';
import 'package:magic_hat/utils/constants.dart';
import 'package:magic_hat/widgets/app_bar.dart';
import 'package:magic_hat/widgets/characters_info_bio_item.dart';

class CharactersInfoPage extends StatelessWidget {
  const CharactersInfoPage({
    super.key,
    required this.character,
  });

  final CharacterModel character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: character.name,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 16.0,
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 144.0,
                height: 200.0,
                child: character.image != null
                    ? CachedNetworkImage(
                        imageUrl: character.image ?? '',
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
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 32.0,
                    ),
                    if (character.isSuccess == true) ...[
                      CharactersInfoBioItem(
                        title: 'Name',
                        description: character.name,
                      ),
                      if (character.alternateNames != null) ...[
                        CharactersInfoBioItem(
                          title: 'Alternate names',
                          description: character.alternateNames!,
                        ),
                      ],
                      CharactersInfoBioItem(
                        title: 'Species',
                        description: character.species,
                      ),
                      CharactersInfoBioItem(
                        title: 'Gender',
                        description: character.gender,
                      ),
                      if (character.house != null) ...[
                        CharactersInfoBioItem(
                          title: 'House',
                          description: character.house!,
                        ),
                      ],
                      if (character.dateOfBirth != null) ...[
                        CharactersInfoBioItem(
                          title: 'Date of Birth',
                          description: character.dateOfBirth!,
                        ),
                      ],
                      CharactersInfoBioItem(
                        title: 'Is Wizard',
                        description: '${character.wizard}',
                      ),
                      if (character.ancestry != null) ...[
                        CharactersInfoBioItem(
                          title: 'Ancestry',
                          description: character.ancestry!,
                        ),
                      ],
                      if (character.eyeColour != null) ...[
                        CharactersInfoBioItem(
                          title: 'Eye colour',
                          description: character.eyeColour!,
                        ),
                      ],
                      if (character.hairColour != null) ...[
                        CharactersInfoBioItem(
                          title: 'Hair colour',
                          description: character.hairColour!,
                        ),
                      ],
                      if (character.wand != null) ...[
                        CharactersInfoBioItem(
                          title: 'Wand',
                          description: character.wand!,
                        ),
                      ],
                      if (character.patronus != null) ...[
                        CharactersInfoBioItem(
                          title: 'Patronus',
                          description: character.patronus!,
                        ),
                      ],
                      CharactersInfoBioItem(
                        title: 'Is Hogwarts student',
                        description: '${character.hogwartsStudent}',
                      ),
                      CharactersInfoBioItem(
                        title: 'Is Hogwarts staff',
                        description: '${character.hogwartsStaff}',
                      ),
                      if (character.actor != null) ...[
                        CharactersInfoBioItem(
                          title: 'Actor',
                          description: character.actor!,
                        ),
                      ],
                      if (character.alternateActors != null) ...[
                        CharactersInfoBioItem(
                          title: 'Alternate actors',
                          description: character.alternateActors!,
                        ),
                      ],
                      CharactersInfoBioItem(
                        title: 'Is alive',
                        description: '${character.alive}',
                      ),
                    ] else ...[
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 2.0),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: const Center(
                          child: Text(
                            'ACCESS DENIED',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              letterSpacing: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
