import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/app/theme.dart';
import 'package:rickandmorty/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:rickandmorty/features/auth/data/repositories/firebase_auth_repository_impl.dart';
import 'package:rickandmorty/features/auth/presentation/providers/auth_provider.dart'
    as auth_provider;
import 'package:rickandmorty/features/characters/data/datasources/characters_datasource.dart';
import 'package:rickandmorty/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:rickandmorty/features/characters/presentation/providers/characters_provider.dart';
import 'package:rickandmorty/features/characters/presentation/providers/search_characters_provider.dart';
import 'package:rickandmorty/features/characters/presentation/screens/characters_screen.dart';
import 'package:rickandmorty/features/auth/presentation/login_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => auth_provider.AuthProvider(
            authRepository: FirebaseAuthRepositoryImpl(
              authDatasource: FirebaseAuthDatasource(
                firebaseAuth: FirebaseAuth.instance,
              ),
            ),
          ),
        ),
        ChangeNotifierProvider<CharactersProvider>(
          create: (context) => CharactersProvider(
            charactersRepository: CharactersRepositoryImpl(
              charactersDatasource: CharactersDatasourceApi(client: Client()),
            ),
          )..getCharacters(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchCharactersProvider(
            charactersRepository: CharactersRepositoryImpl(
              charactersDatasource: CharactersDatasourceApi(client: Client()),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: FirebaseAuth.instance.currentUser != null
            ? const CharactersScreen()
            : const LoginScreen(),
      ),
    );
  }
}
