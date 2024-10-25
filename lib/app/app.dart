import 'package:flutter/material.dart';
import 'package:rickandmorty/app/theme.dart';
import 'package:rickandmorty/features/characters/presentation/screens/characters_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const CharactersScreen(),
    );
  }
}
