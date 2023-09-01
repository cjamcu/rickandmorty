part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  final int index;

  const NavigationState({this.index = 0});

  @override
  List<Object> get props => [index];
}

class NavigationInitial extends NavigationState {
  const NavigationInitial(int index) : super(index: index);
}

class PageChanged extends NavigationState {
  const PageChanged(int index) : super(index: index);
}
