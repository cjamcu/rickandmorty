part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
}

class PageTappedEvent extends NavigationEvent {
  final int index;

  const PageTappedEvent({required this.index});

  @override
  List<Object> get props => [index];
}