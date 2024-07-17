import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_hat/bloc/quiz_bloc.dart';
import 'package:magic_hat/database/local_database.dart';
import 'package:magic_hat/pages/home/home_screen.dart';
import 'package:magic_hat/pages/story/story_screen.dart';
import 'package:magic_hat/repositories/characters_repository.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const StoryPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final CharactersRepository _charactersRepository = CharactersRepository();

  final RootIsolateToken _isolateToken = RootIsolateToken.instance!;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CharactersRepository>(
          create: (_) => _charactersRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<QuizBloc>(
            create: (_) => QuizBloc(
              localDB: LocalDB.instance,
              charactersRepository: _charactersRepository,
              isolateToken: _isolateToken,
            )..add(
                const LoadQuizData(),
              ),
          ),
        ],
        child: Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: _widgetOptions,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'List',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: const Color(0xFFffc900),
            unselectedItemColor: const Color.fromARGB(255, 45, 45, 52),
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 10.0,
          ),
        ),
      ),
    );
  }
}
