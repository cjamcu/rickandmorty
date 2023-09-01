import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/features/characters/presentation/characters_page.dart';
import 'package:rickandmorty/features/episodes/presentation/episodies_page.dart';
import 'package:rickandmorty/features/locations/presentation/locations_page.dart';
import 'package:rickandmorty/features/navigation/presentation/bloc/navigation_bloc.dart';

class NavigationPage extends StatelessWidget {
  NavigationPage({super.key});

  final pages = [
    CharactersPage(),
    const LocationsPage(),
    const EpisodesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state.index,
              children: pages,
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.index,
              onTap: (index) {
                context.read<NavigationBloc>().add(
                      PageTappedEvent(index: index),
                    );
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Characters',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.location_on),
                  label: 'Locations',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.tv),
                  label: 'Episodes',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
