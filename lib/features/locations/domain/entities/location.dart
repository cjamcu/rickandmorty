import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final int id;
  final String name;
  final String type;
  final String dimension;

  const Location(
      {required this.id,
      required this.name,
      required this.type,
      required this.dimension});

  @override
  List<Object?> get props => [id, name, type, dimension];
}
